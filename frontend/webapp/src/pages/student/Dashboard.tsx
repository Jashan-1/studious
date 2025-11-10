import { DashboardLayout } from '@/components/shared/DashboardLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { useAuth } from '@/contexts/AuthContext';
import { ClipboardCheck, BookOpen, Trophy, Clock, Zap, TrendingUp } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

// --- Mock Test Data for Dashboard Summary ---
const mockDashboardStats = {
    testsAssigned: 5,
    testsCompleted: 3,
    avgScore: '85%',
    booksAccessed: 3,
    studyHours: '12h',
    // New Performance Insights
    avgTimeInsight: 'Quick', 
    avgTimeDifference: -180, // -3 minutes
};

export default function StudentDashboard() {
  const { user } = useAuth();
  const navigate = useNavigate();

  const stats = [
    { icon: ClipboardCheck, label: 'Tests Assigned', value: mockDashboardStats.testsAssigned, color: 'text-primary' },
    { icon: Trophy, label: 'Average Score', value: mockDashboardStats.avgScore, color: 'text-success' },
    { icon: BookOpen, label: 'Books Accessed', value: mockDashboardStats.booksAccessed, color: 'text-accent' },
    { icon: Clock, label: 'Study Hours', value: mockDashboardStats.studyHours, color: 'text-chart-4' },
  ];
  
  const formatTimeDifference = (seconds: number) => {
    const absSeconds = Math.abs(seconds);
    const mins = Math.floor(absSeconds / 60);
    return `${mins} min`;
  }
  
  const getInsightColor = (insight: string) => {
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
          <p className="text-muted-foreground">Here's what's happening with your studies today</p>
        </div>

        {/* --- STATS GRID --- */}
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
          
          {/* --- Performance Insight Card (FIXED) --- */}
          <Card className="shadow-md">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <TrendingUp className="h-5 w-5 text-primary" /> Test Speed Insight
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
                <p className="text-md text-muted-foreground">Based on your last {mockDashboardStats.testsCompleted} test submissions:</p>
                <div className="flex items-center gap-4 p-4 rounded-lg bg-muted">
                    <Zap className={`h-8 w-8 ${getInsightColor(mockDashboardStats.avgTimeInsight)}`} />
                    <div>
                        <p className="text-2xl font-bold">
                            You are typically <span className={`${getInsightColor(mockDashboardStats.avgTimeInsight)}`}>{mockDashboardStats.avgTimeInsight}</span>!
                        </p>
                        <p className="text-sm text-muted-foreground">
                            {/* FIX 1: Replaced **...** with <span> and font-bold class */}
                            You save an average of <span className="font-bold">{formatTimeDifference(mockDashboardStats.avgTimeDifference)}</span> per test compared to the time limit.
                        </p>
                    </div>
                </div>
                {/* FIX 2 & 3: Styled the link as a button that aligns properly */}
                <Button 
                    variant="link" 
                    className="p-0 justify-start text-primary" 
                    onClick={() => navigate('/student/performance')}
                >
                    View detailed performance report &gt;
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
                    onClick={() => navigate('/student/books')}
                    className="w-full p-4 text-left bg-primary text-primary-foreground rounded-lg hover:opacity-90 transition-opacity"
                >
                  <p className="font-medium">Open NCERT Books</p>
                  <p className="text-sm opacity-90">Start reading your textbooks</p>
                </button>
                <button 
                    onClick={() => navigate('/student/my-content')}
                    className="w-full p-4 text-left bg-success text-success-foreground rounded-lg hover:opacity-90 transition-opacity"
                >
                  <p className="font-medium">Upload New Content</p>
                  <p className="text-sm opacity-90">Generate summaries and tests</p>
                </button>
                <button 
                    onClick={() => navigate('/student/tests')}
                    className="w-full p-4 text-left bg-accent text-accent-foreground rounded-lg hover:opacity-90 transition-opacity"
                >
                  <p className="font-medium">Go to Assigned Tests</p>
                  <p className="text-sm opacity-90">Start your pending exams</p>
                </button>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </DashboardLayout>
  );
}