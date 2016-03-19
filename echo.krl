
ruleset echo {

  global {
    hello = function(obj) {
      msg = "Hello " + obj
      msg
    };
 
  }
  rule hello {
    select when echo hello
    send_directive("say") with
      something = "Hello World";
  }
  rule message{
    select when echo message
    pre{
    input = event:attr("input").klog("Our passed in input: ");
    }
    send_directive("say") with
      something = "#{input}"
  }
 
}