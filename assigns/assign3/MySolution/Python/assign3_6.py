class mylist:
    """ parent class of all mylist classes """
    ctag = -1
    def get_ctag(self) -> int:
        return self.ctag
        
    def __iter__(self):
        return mylist_iter(self)
    
    def __reversed__(self):
        return mylist_reverse(self)
        


class mylist_iter:
    """ iterator from a mylist object """
    def __iter__(self):
        return self
    
    def __init__(self, items):
        self.items = items
        self.xs1_iter = None; self.xs2_iter = None

    def __next__(self):
        match self.items.ctag:
            # mylist_nil
            case 0:
                raise StopIteration
            # mylist_cons
            case 1:
                item = self.items.cons1
                self.items = self.items.cons2
                return item
            # mylist_snoc
            case 2:
                item = self.items.snoc2
                self.items = self.items.snoc1
                return item
            # mylist_reverse
            case 3:
                self.items = self.items.original
                return self.__next__()
            # mylist_append2
            case 4:
                if self.xs1_iter is None and self.xs2_iter is None:
                    self.xs1_iter = mylist_iter(self.items.xs1)
                    self.xs2_iter = mylist_iter(self.items.xs2)
                # iterate through first half
                try:
                    item = self.xs1_iter.__next__()
                    return item
                except StopIteration:
                    # iterate through second half
                    try:
                        item = self.xs2_iter.__next__()
                        return item
                    except:
                        raise StopIteration
    


class mylist_nil(mylist):
    """ an empty mylist object """
    def __init__(self):
        self.ctag = 0
    


class mylist_cons(mylist):
    """ prepend an object to a mylist object """
    def __init__(self, cons1: any, cons2: mylist):
        # assert(type(cons1) == mylist)
        self.ctag = 1
        self.cons1: any = cons1
        self.cons2: mylist = cons2

    def get_cons1(self):
        return self.cons1
    
    def cons2(self):
        return self.cons2
    


class mylist_snoc(mylist):
    """ append an item to a mylist object """
    def __init__(self, snoc1: mylist, snoc2: any):
        # assert type(snoc2) == mylist
        self.ctag = 2
        self.snoc1: mylist = snoc1
        self.snoc2: any = snoc2
    
    def get_snoc1(self):
        return self.snoc1
    
    def get_snoc2(self):
        return self.snoc2
    


class mylist_reverse(mylist):
    """ the reverse of a mylist object """
    def __init__(self, xs: mylist):
        self.ctag = 3
        self.mylist = mylist_reverse(xs)
        self.original: mylist = xs



class mylist_append2(mylist):
    """ combines two mylist objects """
    def __init__(self, xs1: mylist, xs2: mylist):
        # assert type(xs1) == mylist and type(xs2) == mylist
        self.ctag = 4
        self.xs1: mylist = xs1
        self.xs2: mylist = xs2

    def get_xs1(self):
        return self.xs1
    
    def get_xs2(self):
        return self.xs2



def mylist_length(xs: mylist) -> int:
    """ returns the length of xs """
    # use the iter we've created above
    return len([x for x in xs])
    # # same implementation as in assign2
    # match xs.ctag:
    #     # mylist_nil
    #     case 0:
    #         return 0
    #     # mylist_cons
    #     case 1:
    #         return 1 + mylist_length(xs.cons2)
    #     # mylist_snoc
    #     case 2:
    #         return mylist_length(xs.snoc1) + 1
    #     # mylist_reverse
    #     case 3:
    #         return mylist_length(xs.original)
    #     # mylist_append2
    #     case 4:
    #         return mylist_length(xs.xs1) + mylist_length(xs.xs2)


def mylist_sing(x0: any) -> mylist:
    """ returns a mylist with single element x0 """
    res = mylist_nil()
    res = mylist_cons(x0, res)
    return res


def mylist_print(xs: mylist, sep="; ") -> None:
    """ prints the elements of xs separated by str sep """
    nx = 0
    print(f"mylist[", end='')
    while xs.ctag > 0:
        if nx > 0:
            print(sep, end='')
        print(xs.cons1, end='')
        nx = nx + 1; xs = xs.cons2
        print("]", end='')


def mylist_reverse(xs: mylist) -> mylist:
    """ returns the reverse of xs """
    res = mylist_nil()
    for x1 in xs:
        res = mylist_cons(x1, res)
    return res


def mylist_foreach(xs: mylist, work):
    """ applies work to each element of xs leftward """
    # assert type(xs) == mylist
    match xs.ctag:
        # mylist_nil
        case 0:
            return None
        # mylist_cons
        case 1:
            work(xs.cons1)
            mylist_foreach(xs.cons2, work)
        # mylist_snoc
        case 2:
            mylist_foreach(xs.snoc1, work)
            work(xs.snoc2)
        # mylist_reverse
        case 3:
            mylist_rforeach(xs.original, work)
        # mylist_append2
        case 4:
            # process left before right
            mylist_foreach(xs.xs1, work)
            mylist_foreach(xs.xs2, work)


def mylist_rforeach(xs: mylist, work):
    """ applies work to each element of xs rightward """
    # assert type(xs) == mylist
    match xs.ctag:
        # mylist_nil
        case 0:
            return None
        # mylist_cons
        case 1:
            # process rest before current
            mylist_rforeach(xs.cons2, work)
            work(xs.cons1)
        # mylist_snoc
        case 2:
            # process current before rest
            work(xs.snoc2)
            mylist_rforeach(xs.snoc1, work)
        # mylist_reverse
        case 3:
            mylist_foreach(xs.original, work)
        # mylist_append2
        case 4:
            # process right before left
            mylist_rforeach(xs.xs2, work)
            mylist_rforeach(xs.xs1, work)