package war2023.item
{
   public class SecretwarResultRankListItem extends SecretwarRankListItem
   {
      
      public function SecretwarResultRankListItem()
      {
         super();
      }
      
      override protected function creatOneItem() : SecretwarRankOneItem
      {
         return new SecretwarResultRankOneItem();
      }
   }
}

