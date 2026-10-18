package auction.view
{
   import auction.view.record.AuctionRecordResultPane;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class AuctionRecordPane extends Sprite implements Disposeable
   {
      
      private var _resultPane:AuctionRecordResultPane;
      
      public function AuctionRecordPane()
      {
         super();
         _resultPane = new AuctionRecordResultPane();
         addChild(_resultPane);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_resultPane);
         _resultPane = null;
      }
   }
}

