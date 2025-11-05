import { DashboardLayout } from '@/components/shared/DashboardLayout';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { useAuth } from '@/contexts/AuthContext';
import { ClipboardCheck, BookOpen, Trophy, Clock } from 'lucide-react';

export default function StudentDashboard() {
  const { user } = useAuth();

  const stats = [
    { icon: ClipboardCheck, label: 'Tests Assigned', value: '5', color: 'text-primary' },
    { icon: Trophy, label: 'Average Score', value: '85%', color: 'text-success' },
    { icon: BookOpen, label: 'Books Accessed', value: '3', color: 'text-accent' },
    { icon: Clock, label: 'Study Hours', value: '12h', color: 'text-chart-4' },
  ];

  return (
    <DashboardLayout>
      <div className="p-8">
        <div className="mb-8">
          <h1 className="text-3xl font-bold mb-2">Welcome back, {user?.name}!</h1>
          <p className="text-muted-foreground">Here's what's happening with your studies today</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          {stats.map((stat) => (
            <Card key={stat.label} className="shadow-card hover:shadow-card-hover transition-shadow">
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
          <Card className="shadow-card">
            <CardHeader>
              <CardTitle>Recent Tests</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex items-center justify-between p-4 bg-muted rounded-lg">
                  <div>
                    <p className="font-medium">Science Chapter 5 Test</p>
                    <p className="text-sm text-muted-foreground">Due: Tomorrow</p>
                  </div>
                  <span className="text-sm px-3 py-1 bg-accent/20 text-accent-foreground rounded-full">
                    Pending
                  </span>
                </div>
                <div className="flex items-center justify-between p-4 bg-muted rounded-lg">
                  <div>
                    <p className="font-medium">Maths Unit Test</p>
                    <p className="text-sm text-muted-foreground">Completed</p>
                  </div>
                  <span className="text-sm px-3 py-1 bg-success/20 text-success-foreground rounded-full">
                    92%
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card className="shadow-card">
            <CardHeader>
              <CardTitle>Quick Actions</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <button className="w-full p-4 text-left bg-primary text-primary-foreground rounded-lg hover:opacity-90 transition-opacity">
                  <p className="font-medium">Open NCERT Books</p>
                  <p className="text-sm opacity-90">Start reading your textbooks</p>
                </button>
                <button className="w-full p-4 text-left bg-success text-success-foreground rounded-lg hover:opacity-90 transition-opacity">
                  <p className="font-medium">Upload New Content</p>
                  <p className="text-sm opacity-90">Generate summaries and tests</p>
                </button>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </DashboardLayout>
  );
}
