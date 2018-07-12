require "spec"

module LinkedList

  class List
    property :head

    def initialize(@head=nil)
    end

    def length
      current = @head
      count = 0
      while current
        count += 1
        current = current.next
      end
      count
    end

    def print
      if current = @head
        print current.val
        while current = current.next
          print " => #{current.val}"
        end
      end
    end

    def append(value : Int32)
      current = @head

      if current.nil?
        return @head = Node.new(value)
      else
        while c = current.next
          current = c
        end

        current.next = Node.new(value)
      end
    end

    def append(values : Array(Int32))
      current = @head

      if current.nil?
        @head = Node.new(values.shift)
      end
      current = @head

      unless current.nil?
        while c = current.as(LinkedList::Node).next
          current = c
        end

        values.each do |v|
          if current
            current.next = Node.new(v)
            current = current.next
          end
        end
      end
    end

    def last
      return unless h = @head
      return h if h.next.nil?

      current = h

      while c = current.next
        return c if c.next.nil?
        current = c
      end
    end

    def prepend(value : Int32)
      new_node = Node.new(value)
      new_node.next = head
      head = new_node
    end

    def delete_first_with_value(value : Int32)
      return if (current = @head).nil?

      if current.val == value
        @head = current.next
      else
        while current
          n = current.next
          break if n.nil?

          if n.val == value
            current.next = n.next
            current = n.next
            break
          end

          current = n
        end
      end
    end
  end


  class Node

    property val
    property next : Node?

    def initialize(@val : Int32)
    end
  end
end

describe "List" do
  describe "#new" do
    it "initializes an empty list" do
      list = LinkedList::List.new
      list.head.should be nil
    end

    it "initializes with a node" do
      list = LinkedList::List.new(LinkedList::Node.new(1))

      if h = list.head
        h.should be_a LinkedList::Node
        h.val.should eq 1
      end
    end
  end

  describe "#head" do
    it "returns the first node in the List" do
      list = LinkedList::List.new
      list.append(10)
      if head = list.head
        head.val.should eq 10
      end
    end
  end

  describe "#last" do
    it "returns the last node in the linked list" do
      list = LinkedList::List.new
      list.append(10)
      list.append(20)
      list.append(20)
      list.append(80)
      list.last.should be_a LinkedList::Node
      list.last.as(LinkedList::Node).val.should eq 80
    end
  end

  describe "#prepend" do
    it "prepends the value to the front of the linked list" do
      list = LinkedList::List.new

      list.prepend(10)
      if h = list.head
        h.val.should eq 10
      end
    end
  end

  describe "#append" do
    it "appends a node to the linked list" do
      list = LinkedList::List.new
      list.append(10)
      if node = list.head
        node.val.should eq 10
      end
    end

    it "appends another node" do
      list = LinkedList::List.new
      list.append(10)
      list.append(20)
      if last = list.last
        last.val.should eq 20
      end
      list.length
    end
  end

  describe "#print" do
    # Visual test until I can workout how to redirect STDOUT
    it "prints the lists node values in format" do
      list = LinkedList::List.new
      list.append([1,2,3])
      list.print
    end
  end

  describe "#append Array" do
    it "appends a node to the linked list" do
      list = LinkedList::List.new
      list.append([1,2,3])
      list.length.should eq 3
      if node = list.head
        node.val.should eq 1
      end
    end

    it "appends another node" do
      list = LinkedList::List.new
      list.append(10)
      list.append([1,2,3])
      if last = list.last
        last.val.should eq 3
      end
      list.length.should eq 4
    end
  end

  describe "#delete_first_with_value" do
    describe "when the value is at the head of the list" do
      it "deletes a node from the list that matches the given value" do
        list = LinkedList::List.new
        list.append(10)
        list.append(20)
        list.append(30)
        list.delete_first_with_value(10)
        if node = list.head
          node.val.should eq 20
        end
        list.length.should eq 2
      end
    end

    describe "when the value is in the middle of the list" do
      it "deletes a node from the list that matches the given value" do
        list = LinkedList::List.new
        list.append(10)
        list.append(20)
        list.append(30)
        list.delete_first_with_value(20)
        if node = list.head
          node.val.should eq 10
        end
        list.length.should eq 2
      end
    end

    describe "when the value is at the end of the list" do
      it "deletes a node from the list that matches the given value" do
        list = LinkedList::List.new
        list.append(10)
        list.append(20)
        list.append(30)
        list.append(30)
        list.delete_first_with_value(30)
        if node = list.head
          node.val.should eq 10
        end
        list.length.should eq 3
      end
    end
  end
end

