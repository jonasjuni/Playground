//: ## Concurrency
//:
//: Use `async` to mark a function that runs asynchronously.
//:
import _Concurrency

func fetchUserID(from server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}

//: You mark a call to an asynchronous function by writing `await` in front of it.
//:
func fetchUsername(from server: String) async -> String {
    let userID = await fetchUserID(from: server)
    if userID == 501 {
        return "John Appleseed"
    }
    return "Guest"
}

//: Use `async let` to call an asynchronous function, letting it run in parallel with other asynchronous code. When you use the value it returns, write `await`.
//:
// async let doesn't work on Playground
func connectUser(to server: String) async {
    let userID = await fetchUserID(from: server)
    let username = await fetchUsername(from: server)
    let greeting = "Hello \(username), user ID \(userID)"
    print(greeting)
}

//: Use `Task` to call asynchronous functions from synchronous code, without waiting for them to return.
//:
Task{
    await connectUser(to: "primary")
}


//: [Previous](@previous) | [Next](@next)
