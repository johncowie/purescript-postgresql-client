module Data.PostgreSQL.RowList where

-- import Prim.RowList (Cons, Nil) as RowList
-- import Prim.RowList (kind RowList)
-- 
-- infixl 10 type RowList.Cons as :
-- 
-- type Apply (f :: RowList -> RowList) (a ∷ RowList) = f a
-- 
-- infixr 0 type Apply as $
-- 
-- type R = "test" : Int $ "fest" : String $ RowList.Nil
-- 
-- instance fromSQLRowRow0 :: FromSQLRow RowList.Nil where
--   fromSQLRow [] =
--     pure Row0
--   fromSQLRow xs = Left $ "Row has " <> show n <> " fields, expecting 0."
--     where n = Array.length xs
-- 
-- instance toSQLRowRow0 :: ToSQLRow Row0 where
--   toSQLRow Row0 = []
-- -- | A row with 1 field.