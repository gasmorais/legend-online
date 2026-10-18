package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.view.community.BaseItemView;
   
   public class DreamAreanaPreviewRewardItem extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _winCountText:FilterFrameText;
      
      private var _winBit:Bitmap;
      
      private var _rewardHbox:HBox;
      
      private var index:int;
      
      private var _data:Array;
      
      public function DreamAreanaPreviewRewardItem(param1:int)
      {
         super();
         index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.DreamAreanaPreviewRewardItem.bg");
         _winCountText = ComponentFactory.Instance.creatComponentByStylename("DreamAreanaPreviewRewardItem.winCountText");
         _winBit = ComponentFactory.Instance.creatBitmap("asset.DreamAreanaPreviewRewardItem.winBit");
         _rewardHbox = ComponentFactory.Instance.creatComponentByStylename("DreamAreanaPreviewRewardItem.rewardHbox");
         addChild(_bg);
         _bg.visible = index % 2 == 0;
         addChild(_winCountText);
         addChild(_winBit);
         addChild(_rewardHbox);
      }
      
      public function setWinCount(param1:int) : void
      {
         _winCountText.text = param1 + "";
      }
      
      public function get data() : Array
      {
         return _data;
      }
      
      public function set data(param1:Array) : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         _data = param1;
         _rewardHbox.removeAllChild();
         if(data)
         {
            data.sortOn("itemId",16);
            for each(var _loc4_:CommonDropTempInfo in data)
            {
               _loc2_ = new GoodsInfo();
               _loc3_ = ComponentFactory.Instance.creatCustomObject("DreamAreanaReportFrame.rewardItem");
               _loc2_.templateId = _loc4_.itemId;
               _loc2_.count = _loc4_.count;
               _loc3_.data = _loc2_;
               _rewardHbox.addChild(_loc3_);
            }
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_winCountText);
         _winCountText = null;
         ObjectUtils.disposeObject(_winBit);
         _winBit = null;
         ObjectUtils.disposeObject(_rewardHbox);
         _rewardHbox = null;
         super.dispose();
      }
   }
}

