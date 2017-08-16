<Window x:Class="WpfApplication2.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApplication2"
        mc:Ignorable="d"
        Title="FoxDeploy Awesome Tool" Height="670.572" Width="598.474" Topmost="True">
    <Grid Margin="0,0,45,0">
        <Image x:Name="image" HorizontalAlignment="Left" Height="100" Margin="24,28,0,0" VerticalAlignment="Top" Width="100" Source=" C:\Users\DCasteel\Dropbox\Public\uncle-sam-desktop-support.gif"/>
        <TextBlock x:Name="textBlock" HorizontalAlignment="Left" Height="56" Margin="129,72,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="406" FontSize="14"><Run Text="Casteel's User Lookup Tool"/><LineBreak/><Run Text="Use this tool to find out all sorts of useful information about corporate users"/></TextBlock>
        <Button x:Name="close" Content="Close" HorizontalAlignment="Left" Margin="460,610,0,0" VerticalAlignment="Top" Width="75"/>
        <Button x:Name="getUser" Content="GetLocalUser" HorizontalAlignment="Left" Margin="327,146,0,0" VerticalAlignment="Top" Width="75"/>

        <TextBox x:Name="userbox" HorizontalAlignment="Left" Height="23" Margin="174,147,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="120"/>
        <Label x:Name="USer" Content="Enter a username" HorizontalAlignment="Left" Height="23" Margin="24,147,0,0" VerticalAlignment="Top" Width="115"/>

        <ListView x:Name="UserName" HorizontalAlignment="Left" Height="93" Margin="24,512,0,0" VerticalAlignment="Top" Width="511">
            <ListView.View>
                <GridView>
                    <GridViewColumn Header="FullName" DisplayMemberBinding ="{Binding 'Name'}" Width="120"/>
                    <GridViewColumn Header="Description" DisplayMemberBinding ="{Binding 'Description'}" Width="120"/>
                    <GridViewColumn Header="Enabled" DisplayMemberBinding ="{Binding 'Enabled'}" Width="120"/>
                    <GridViewColumn Header="LastPWChange" DisplayMemberBinding ="{Binding 'LastPWChange'}" Width="120"/>
                </GridView>
            </ListView.View>
        </ListView>
        <Label x:Name="dispName" Content="Name" HorizontalAlignment="Left" Margin="56,186,0,0" VerticalAlignment="Top"/>
        <Label x:Name="dispDesc" Content="Description" HorizontalAlignment="Left" Margin="28,217,0,0" VerticalAlignment="Top"/>
        <Label x:Name="dispEnabled" Content="Enabled" HorizontalAlignment="Left" Margin="46,248,0,0" VerticalAlignment="Top"/>
        <Label x:Name="dispLastPWChng" Content="LastPWChange" HorizontalAlignment="Left" Margin="9,279,0,0" VerticalAlignment="Top"/>
        <Label Content="C.U.L.T." HorizontalAlignment="Left" Margin="134,21,0,0" VerticalAlignment="Top" FontSize="36"/>
        <TextBox x:Name="resName" HorizontalAlignment="Left" Height="23" Margin="124,189,0,0" TextWrapping="Wrap" Text="Name" VerticalAlignment="Top" Width="278"/>
        <TextBox x:Name="resDesc" HorizontalAlignment="Left" Height="23" Margin="124,221,0,0" TextWrapping="Wrap" Text="Description" VerticalAlignment="Top" Width="278"/>
        <TextBox x:Name="resEnabled" HorizontalAlignment="Left" Height="23" Margin="124,252,0,0" TextWrapping="Wrap" Text="Enabled" VerticalAlignment="Top" Width="278"/>
        <TextBox x:Name="resPWlastChg" HorizontalAlignment="Left" Height="23" Margin="124,283,0,0" TextWrapping="Wrap" Text="Last Time the PW Was changed" VerticalAlignment="Top" Width="278"/>
    </Grid>
</Window>
