import { useState } from "react";
import { DashboardLayout } from "@/components/shared/DashboardLayout";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Timer, BarChart, TrendingUp, Clock, CheckCircle, XCircle } from "lucide-react";
import { Separator } from "@/components/ui/separator";

// --- Data Structures (Mocked Test Data for demonstration) ---
interface AssignedTest {
  id: string;
  title: string;
  source: 'AI-MCQs' | 'Teacher-Upload' | 'Google-Form';
  status: 'Pending' | 'InProgress' | 'Submitted';
  dueDate: string;
  timeLimitMinutes: number;
  timeSpentSeconds?: number;
  teacherInsight?: 'On Time' | 'Late' | 'Quick';
  timeDifference?: number; // Negative is Quick, Positive is Late
}

// --- Helper Functions ---
const formatTimeDifference = (seconds: number) => {
    const absSeconds = Math.abs(seconds);
    const mins = Math.floor(absSeconds / 60);
    const secs = absSeconds % 60;
    return `${mins}m ${secs}s`;
}

const getInsightColor = (insight: string | undefined) => {
    switch (insight) {
      case 'Quick':
        return 'text-green-600';
      case 'Late':
        return 'text-red-600';
      case 'On Time':
      default:
        return 'text-blue-600';
    }
}

// Mock Data: Submissions only
const mockSubmittedTests: AssignedTest[] = [
    {
      id: "T-103",
      title: "Democratic Politics Quiz",
      source: "Google-Form",
      status: "Submitted",
      dueDate: "2025-11-20",
      timeLimitMinutes: 45, // 2700s
      timeSpentSeconds: 2100, // 35 mins
      teacherInsight: 'Quick',
      timeDifference: -600,
    },
    {
      id: "T-104",
      title: "Maths Algebra Mid-Term",
      source: "Teacher-Upload",
      status: "Submitted",
      dueDate: "2025-10-25",
      timeLimitMinutes: 90, // 5400s
      timeSpentSeconds: 5520, // 92 mins
      teacherInsight: 'Late',
      timeDifference: 120,
    },
    {
      id: "T-105",
      title: "Science Chapter 1 MCQs",
      source: "AI-MCQs",
      status: "Submitted",
      dueDate: "2025-11-01",
      timeLimitMinutes: 30, // 1800s
      timeSpentSeconds: 1800, // 30 mins
      teacherInsight: 'On Time',
      timeDifference: 0,
    },
];

const calculateMetrics = (tests: AssignedTest[]) => {
    const submittedCount = tests.length;
    let quickCount = 0;
    let lateCount = 0;
    let onTimeCount = 0;
    let totalTimeDifference = 0;

    tests.forEach(test => {
        if (test.teacherInsight === 'Quick') quickCount++;
        else if (test.teacherInsight === 'Late') lateCount++;
        else if (test.teacherInsight === 'On Time') onTimeCount++;
        
        if (test.timeDifference !== undefined) {
             totalTimeDifference += test.timeDifference;
        }
    });
    
    // Average Speed Insight
    let averageInsight = 'On Time';
    let averageDifference = 0;

    if (submittedCount > 0) {
        averageDifference = totalTimeDifference / submittedCount;
        if (averageDifference < -60) { // More than 1 minute quick on average
            averageInsight = 'Quick';
        } else if (averageDifference > 60) { // More than 1 minute late on average
            averageInsight = 'Late';
        }
    }
    
    return {
        submittedCount,
        quickCount,
        lateCount,
        onTimeCount,
        averageDifference: Math.round(averageDifference),
        averageInsight,
    };
}


export default function StudentPerformance() {
    const metrics = calculateMetrics(mockSubmittedTests);

    return (
        <DashboardLayout>
            <div className="container mx-auto px-4 pt-6 pb-6 space-y-8">
                <div>
                    <h1 className="text-3xl font-bold text-foreground flex items-center gap-2">
                        <BarChart className="h-7 w-7 text-primary" /> Performance Analytics
                    </h1>
                    <p className="text-muted-foreground">Detailed insights into your test taking speed and efficiency.</p>
                </div>

                <Separator />
                
                {/* --- Summary Cards --- */}
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <Card className="shadow-md">
                        <CardHeader className="flex flex-row items-center justify-between pb-2">
                            <CardTitle className="text-sm font-medium text-muted-foreground">
                                Total Tests Submitted
                            </CardTitle>
                            <CheckCircle className="w-5 h-5 text-green-500" />
                        </CardHeader>
                        <CardContent>
                            <div className="text-3xl font-bold">{metrics.submittedCount}</div>
                        </CardContent>
                    </Card>

                    <Card className="shadow-md">
                        <CardHeader className="flex flex-row items-center justify-between pb-2">
                            <CardTitle className="text-sm font-medium text-muted-foreground">
                                Average Time Trend
                            </CardTitle>
                            <TrendingUp className={`w-5 h-5 ${getInsightColor(metrics.averageInsight)}`} />
                        </CardHeader>
                        <CardContent>
                            <div className={`text-3xl font-bold ${getInsightColor(metrics.averageInsight)}`}>
                                {metrics.averageInsight}
                            </div>
                            <p className="text-sm text-muted-foreground mt-1">
                                Avg. speed difference: {formatTimeDifference(metrics.averageDifference)}
                            </p>
                        </CardContent>
                    </Card>

                    <Card className="shadow-md">
                        <CardHeader className="flex flex-row items-center justify-between pb-2">
                            <CardTitle className="text-sm font-medium text-muted-foreground">
                                Speed Breakdown
                            </CardTitle>
                            <Clock className="w-5 h-5 text-accent-foreground" />
                        </CardHeader>
                        <CardContent>
                            <p className="text-md font-bold text-green-600">{metrics.quickCount} Quick</p>
                            <p className="text-md font-bold text-red-600">{metrics.lateCount} Late</p>
                            <p className="text-md font-bold text-blue-600">{metrics.onTimeCount} On Time</p>
                        </CardContent>
                    </Card>
                </div>

                {/* --- Recent Test Performance List --- */}
                <Card className="shadow-md">
                    <CardHeader>
                        <CardTitle>Recent Test Submissions</CardTitle>
                        <CardDescription>Review individual performance against set time limits.</CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-4">
                        {mockSubmittedTests.map((test) => (
                            <div key={test.id} className="flex justify-between items-center p-3 border-b last:border-b-0">
                                <div>
                                    <p className="font-semibold">{test.title}</p>
                                    <p className="text-xs text-muted-foreground">
                                        Limit: {test.timeLimitMinutes} min | Due: {test.dueDate}
                                    </p>
                                </div>
                                <div className="text-right">
                                    <p className={`font-bold ${getInsightColor(test.teacherInsight)}`}>
                                        {test.teacherInsight}
                                    </p>
                                    <p className="text-xs text-muted-foreground">
                                        Time: {formatTimeDifference(test.timeSpentSeconds || 0)}
                                        ({test.timeDifference > 0 ? `+${formatTimeDifference(test.timeDifference)}` : `-${formatTimeDifference(Math.abs(test.timeDifference))}`})
                                    </p>
                                </div>
                            </div>
                        ))}
                    </CardContent>
                </Card>
            </div>
        </DashboardLayout>
    );
}
