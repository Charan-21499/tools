//PORT SCANNER
package main

import "fmt"
import "net"
import "sort"

// array to store open ports
var s = []int{}
var host string

// function to take port number from channel and check wether they are open or not
func worker(port chan int){
  for p := range port {
      address := fmt.Sprintf("%s:%d",host,p)
      var conn,err = net.Dial("tcp",address) // connecting to port
      if err==nil{  // if err is nil then the port is open
        s = append(s,p)
        fmt.Println(s)
        conn.Close() // closing the connected port
      }else{

      }
  }
}

func main() {
  fmt.Println("Enter Host name")
  fmt.Scanf("%s",&host)
  fmt.Println("--------------------------------------------------------------------------------------------")
  ports := make(chan int,100) // creating the channel to send port number
  for i:=0;i<cap(ports);i++{
    go worker(ports) // assagning each thread of the function to the channel
  }
  for i:=1;i<=65535;i++ {  // sending data to the channel inturn to the threads
    ports<-i
  }
  close(ports)
  fmt.Printf("Connected Ports to %s\n",host)
  sort.Ints(s)
  for _,po := range s{
    fmt.Println(po)
  }
}
