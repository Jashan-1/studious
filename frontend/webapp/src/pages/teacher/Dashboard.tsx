import { DashboardLayout } from '@/components/shared/DashboardLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { useAuth } from '@/contexts/AuthContext';
import { ClipboardCheck, BookOpen, Trophy, Clock, BarChart3, PenTool } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';

// --- Mock Data for Teacher Dashboard Summary (Same as before) ---
const mockDashboardStats = {
    // Existing Stats
    testsAssigned: 12,
    avgClassScore: '80%',
    booksPublished: 5,
    avgStudyHours: '8h',
    // New Performance Insights
    pendingSubmissions: 7,
    classTimeInsight: 'On Time', // Overall Class Speed
    submissionRate: '85%', // Overall submission rate
};

export default function TeacherDashboard() {
  const { user } = useAuth();
  const navigate = useNavigate();

  const stats = [
    { icon: ClipboardCheck, label: 'Tests Assigned', value: mockDashboardStats.testsAssigned, color: 'text-primary' },
    { icon: Trophy, label: 'Avg Class Score', value: mockDashboardStats.avgClassScore, color: 'text-success' },
    { icon: BookOpen, label: 'Books Published', value: mockDashboardStats.booksPublished, color: 'text-accent' },
    { icon: Clock, label: 'Avg Student Hours', value: mockDashboardStats.avgStudyHours, color: 'text-chart-4' },
  ];
  
  const getClassTimeColor = (insight: string) => {
    switch (insight) {
      case 'Quick':
        return 'text-green-600';
      case 'Late':
        return 'text-red-600';
      default:
        return 'text-blue-600';
    }
  }

  return (
    <DashboardLayout>
      <div className="container mx-auto px-4 pt-6 pb-6 space-y-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold mb-2">Welcome back, {user?.name}!</h1>
          <p className="text-muted-foreground">Here's what's happening with your classes today</p>
        </div>

        {/* --- STATS GRID (Existing) --- */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          {stats.map((stat) => (
            <Card key={stat.label} className="shadow-md hover:shadow-lg transition-shadow">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground">
                  {stat.label}
                </CardTitle>
                <stat.icon className={`w-5 h-5 ${stat.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-3xl font-bold">{stat.value}</div>
              </CardContent>
            </Card>
          ))}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          
          {/* --- Class Performance Summary Card (FINAL FIX) --- */}
          <Card className="shadow-md">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <BarChart3 className="h-5 w-5 text-primary" /> Class Performance Summary
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4 flex flex-col h-full">
                <div className="grid grid-cols-2 gap-4">
                    {/* Inner Boxes remain centered and balanced */}
                    <div className="p-3 bg-muted rounded-lg flex flex-col h-full items-center justify-center text-center"> 
                        <p className="text-sm font-medium text-muted-foreground">Pending Submissions</p>
                        <p className="text-2xl font-bold text-red-500">{mockDashboardStats.pendingSubmissions}</p>
                    </div>
                     <div className="p-3 bg-muted rounded-lg flex flex-col h-full items-center justify-center text-center"> 
                        <p className="text-sm font-medium text-muted-foreground">Overall Speed</p>
                        <p className={`text-2xl font-bold ${getClassTimeColor(mockDashboardStats.classTimeInsight)}`}>
                            {mockDashboardStats.classTimeInsight}
                        </p>
                    </div>
                </div>
                
                <p className="text-sm text-muted-foreground">
                    <span className="font-bold">{mockDashboardStats.submissionRate}</span> Submission Rate overall.
                </p>
                
                {/* FIX: Full-width secondary button to fill space and align with Quick Actions */}
                <Button 
                    variant="secondary" // Changed to secondary for a gray/translucent look
                    className="w-full justify-center mt-auto" // Added w-full and justify-center
                    onClick={() => navigate('/teacher/analytics')}
                >
                    View detailed class analytics &gt;
                </Button>
            </CardContent>
          </Card>
          
          {/* --- Quick Actions Card (Existing) --- */}
          <Card className="shadow-md">
            <CardHeader>
              <CardTitle>Quick Actions</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <button 
                    onClick={() => navigate('/teacher/create-test')}
                    className="w-full p-4 text-left bg-primary text-primary-foreground rounded-lg hover:opacity-90 transition-opacity"
                >
                  <p className="font-medium flex items-center gap-2"><PenTool className="h-4 w-4" /> Create New Test</p>
                  <p className="text-sm opacity-90">Set limits and assign to students</p>
                </button>
                <button 
                    onClick={() => navigate('/teacher/my-content')}
                    className="w-full p-4 text-left bg-success text-success-foreground rounded-lg hover:opacity-90 transition-opacity"
                >
                  <p className="font-medium">Manage Content & AI MCQs</p>
                  <p className="text-sm opacity-90">Upload materials or generate quick quizzes</p>
                </button>
                <button 
                    onClick={() => navigate('/teacher/analytics')}
                    className="w-full p-4 text-left bg-accent text-accent-foreground rounded-lg hover:opacity-90 transition-opacity"
                >
                  <p className="font-medium">Review Class Analytics</p>
                  <p className="text-sm opacity-90">Check test submission trends and speed</p>
                </button>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </DashboardLayout>
  );
}