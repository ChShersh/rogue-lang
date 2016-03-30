module RogueAST where

import RogueTokens

type Program      = [Declaration]
type FunctionType = [(Identifier, TypeToken)]
type Statements   = [Statement]

{- Program blocks -}
data Declaration
    = VarDef { mutability   :: MutabilityToken
             , name         :: Identifier
             , declaredType :: Maybe TypeToken
             , varValue     :: Expr
             }
    | FunDef { name       :: Identifier
             , arguments  :: FunctionType
             , returnType :: TypeToken
             , funBody    :: Statements
             }
    deriving Show

data Statement
    = Def Declaration      -- variable definition
    | Exp Expr             -- expression like function call
    | Ass Identifier Expr  -- assignment
    | If Expr Statements Statements  -- `if` operator
    | While Expr Statements  -- while loop
    | Ret (Maybe Expr) -- return ControlFlow operation
    deriving Show

{- Expression blocks -}
data Expr
    {- Logic block -}
    = And Expr Expr
    | Or  Expr Expr
    | Not Expr

    {- Cmp blocks -} 
    | Equal     Expr Expr
    | NotEqual  Expr Expr
    | LowerEq   Expr Expr
    | Lower     Expr Expr
    | GreaterEq Expr Expr
    | Greater   Expr Expr 

    {- Math block -}
    | Plus     Expr Expr 
    | Minus    Expr Expr 
    | Times    Expr Expr
    | Division Expr Expr
    | Modulo   Expr Expr
    | Power    Expr Expr
    | Negate   Expr

    {- Constant values -}
    | IntConst  Int
    | BoolConst Bool  
    | VarExpr   Identifier  -- TODO: remove in favor of VarOrCall?

    {- Function or var -}
    | VarOrCall Identifier [Expr]
    deriving Show