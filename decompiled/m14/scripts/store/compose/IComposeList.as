package store.compose
{
   import mvc.module.store.ComposeGoodsInfo;
   
   public interface IComposeList
   {
      
      function selectedByType(param1:int, param2:ComposeGoodsInfo) : void;
      
      function update(param1:ComposeGoodsInfo) : void;
   }
}

