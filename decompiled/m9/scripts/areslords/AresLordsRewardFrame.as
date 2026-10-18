package areslords
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   
   public class AresLordsRewardFrame extends Frame implements IManualSize
   {
      
      private var _list:ListPanel;
      
      private var _titleImg:Image;
      
      public function AresLordsRewardFrame()
      {
         super();
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("areslords.RewardFrameTitle");
         _list = ComponentFactory.Instance.creatComponentByStylename("areslords.RewardFrameList");
         addToContent(_titleImg);
         addToContent(_list);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         super.dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = ConfigInfoManager.instance.getAresReward();
         var _loc1_:Array = [];
         _loc4_ = 0;
         _loc3_ = int(_loc2_.length);
         while(_loc4_ < _loc3_)
         {
            _loc1_.push({
               "index":_loc4_ + 1,
               "num":_loc2_[_loc4_]
            });
            _loc4_++;
         }
         _loc1_.sortOn("index",0x10 | 2);
         _list.vectorListModel.clear();
         _list.vectorListModel.appendAll(_loc1_);
         _list.list.updateListView();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,285,400);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

