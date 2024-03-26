package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

import bean.Process;
import bean.Result;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Lists;

// Define a servlet mapped to "/Servlet2"
@WebServlet("/Servlet2")
public class Servlet2 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handle GET requests
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the session associated with the request
        HttpSession session = request.getSession();

        // Get the list of processes from the shared Lists class
        List<bean.Process> processes = Lists.processList;

        // Apply different scheduling algorithms and store the results in the shared Lists class
        shortestJobFirst(processes);
        firstComesFirstScheduled(processes);
        priorityScheduling(processes);
        roundRobinScheduling(processes, processes.size());

        // Set the result list in the session and redirect to the Result.jsp page
        session.setAttribute("resultList", Lists.resultList);
        response.sendRedirect("Result.jsp");
    }

    // Shortest Job First Scheduling Algorithm
    public static void shortestJobFirst(List<bean.Process> processes) {
        // Copy the original list of processes for sorting
        List<bean.Process> copyProcesses = new ArrayList<>(processes);
        // Sort the copyProcesses based on arrival time
        copyProcesses.sort(Comparator.comparingInt(p -> p.getArrivalTime()));
        String progressOrder = "";
        int currentTime = 0;
        int totalWaitingTime = 0;
        int n = copyProcesses.size();
        boolean[] completed = new boolean[n];

        // Iterate through the processes and schedule them
        for (int i = 0; i < n; i++) {
            bean.Process current = null;
            int minBurst = Integer.MAX_VALUE;
            int selectedProcess = -1;

            // Find the process with the shortest burst time that has arrived
            for (int j = 0; j < n; j++) {
                if (!completed[j] && copyProcesses.get(j).getArrivalTime() <= currentTime &&
                        copyProcesses.get(j).getBurstTime() < minBurst) {
                    minBurst = copyProcesses.get(j).getBurstTime();
                    selectedProcess = j;
                }
            }

            // Schedule the selected process
            if (selectedProcess != -1) {
                current = copyProcesses.get(selectedProcess);
                current.setCompletionTime(currentTime + current.getBurstTime());
                current.setTurnAroundTime(current.getCompletionTime() - current.getArrivalTime());
                current.setWaitingTime(current.getTurnAroundTime() - current.getBurstTime());
                currentTime = current.getCompletionTime();
                totalWaitingTime += current.getWaitingTime();
                completed[selectedProcess] = true;
                progressOrder = progressOrder + current.getProcessName() + "-";
            }
        }

        // Create a copy of processes and store the result in the shared Lists class
        List<Process> list = copyProcess(copyProcesses);
        Result shortestJobFirst = new Result("Shortest Job First", currentTime, totalWaitingTime / n, progressOrder.substring(0, progressOrder.length() - 1), list);
        Lists.resultList.add(shortestJobFirst);
    }

    // First Come First Serve Scheduling Algorithm
    public static void firstComesFirstScheduled(List<bean.Process> processes) {
        // Sort the processes based on arrival time
        processes.sort(Comparator.comparingInt(p -> p.getArrivalTime()));
        String progressOrder = "";
        int currentTime = 0;
        int totalWaitingTime = 0;
        int n = processes.size();

        // Iterate through the processes and schedule them
        for (int i = 0; i < n; i++) {
            Process current = processes.get(i);

            // Update current time if the process arrives later
            if (currentTime < current.getArrivalTime()) {
                currentTime = current.getArrivalTime();
            }

            // Schedule the process
            current.setCompletionTime(currentTime + current.getBurstTime());
            current.setTurnAroundTime(current.getCompletionTime() - current.getArrivalTime());
            current.setWaitingTime(current.getTurnAroundTime() - current.getBurstTime());
            currentTime = current.getCompletionTime();
            totalWaitingTime += current.getWaitingTime();
            progressOrder = progressOrder + current.getProcessName() + "-";
        }

        // Create a copy of processes and store the result in the shared Lists class
        List<Process> processList = copyProcess(processes);
        Result firstComesFirstScheduled = new Result("First Come First Serve", currentTime, totalWaitingTime / n, progressOrder.substring(0, progressOrder.length() - 1), processList);
        Lists.resultList.add(firstComesFirstScheduled);
    }

    // Priority Scheduling Algorithm
    public static void priorityScheduling(List<bean.Process> processes) {
        // Sort the processes based on priority
        processes.sort(Comparator.comparingInt(p -> p.getPriority()));
        String progressOrder = "";
        int currentTime = 0;
        int totalWaitingTime = 0;
        int n = processes.size();

        // Iterate through the processes and schedule them
        for (int i = 0; i < n; i++) {
            Process current = processes.get(i);

            // Update current time if the process arrives later
            if (currentTime < current.getArrivalTime()) {
                currentTime = current.getArrivalTime();
            }

            // Schedule the process
            current.setCompletionTime(currentTime + current.getBurstTime());
            current.setTurnAroundTime(current.getCompletionTime() - current.getArrivalTime());
            current.setWaitingTime(current.getTurnAroundTime() - current.getBurstTime());
            currentTime = current.getCompletionTime();
            totalWaitingTime += current.getWaitingTime();
            progressOrder = progressOrder + current.getProcessName() + "-";
        }

        // Create a copy of processes and store the result in the shared Lists class
        List<Process> processList = copyProcess(processes);
        Result priorityScheduling = new Result("Priority Scheduling", currentTime, totalWaitingTime / n, progressOrder.substring(0, progressOrder.length() - 1), processList);
        Lists.resultList.add(priorityScheduling);
    }

    // Round Robin Scheduling Algorithm
    public static void roundRobinScheduling(List<Process> processes, int quantum) {
        // Create a copy of the original list of processes for processing
        List<Process> copyProcesses = new ArrayList<>(processes);
        String progressOrder = "";
        int currentTime = 0;
        int totalWaitingTime = 0;
        int n = copyProcesses.size();
        int[] remainingTime = new int[n];

        // Initialize remainingTime array with burst times
        for (int i = 0; i < n; i++) {
            remainingTime[i] = copyProcesses.get(i).getBurstTime();
        }

        // Execute the round-robin scheduling algorithm
        while (true) {
            boolean done = true;

            // Iterate through the processes and schedule them based on quantum time
            for (int i = 0; i < n; i++) {
                Process current = copyProcesses.get(i);

                if (remainingTime[i] > 0) {
                    done = false;

                    // Execute a quantum or the remaining burst time, whichever is smaller
                    if (remainingTime[i] > quantum) {
                        currentTime += quantum;
                        remainingTime[i] -= quantum;
                        progressOrder += current.getProcessName() + "-";
                    } else {
                        currentTime += remainingTime[i];
                        current.setCompletionTime(currentTime);
                        current.setTurnAroundTime(current.getCompletionTime() - current.getArrivalTime());
                        current.setWaitingTime(current.getTurnAroundTime() - current.getBurstTime());
                        totalWaitingTime += current.getWaitingTime();
                        remainingTime[i] = 0;
                        progressOrder += current.getProcessName() + "-";
                    }
                }
            }

            // Check if all processes are completed
            if (done) {
                break;
            }
        }

        // Create a copy of processes and store the result in the shared Lists class
        List<Process> processList = copyProcess(processes);
        Result roundRobinResult = new Result("Round Robin Scheduling", currentTime, totalWaitingTime / n, progressOrder.substring(0, progressOrder.length() - 1), processList);
        Lists.resultList.add(roundRobinResult);
    }

    // Utility method to create a copy of the list of processes
    public static List<Process> copyProcess(List<Process> list) {
        int len = list.size();
        int i = 0;
        List<Process> processList = new ArrayList<Process>();

        // Iterate through the list and create a copy of each process
        while (i < len) {
            Process temp = list.get(i);
            Process process = new Process(temp.getProcessName(), temp.getArrivalTime(), temp.getBurstTime(), temp.getPriority(), temp.getCompletionTime(), temp.getTurnAroundTime(), temp.getWaitingTime(), temp.getRemainingBurstTime());
            processList.add(process);
            i++;
        }

        return processList;
    }
}
