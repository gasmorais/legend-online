package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.view.community.BaseItemView;
   
   public class DreamArenaRewardItem extends Component
   {
      
      private var _titleText:FilterFrameText;
      
      private var _line:Image;
      
      private var _rewardBox:HBox;
      
      private var numStr:String;
      
      private var _data:Array;
      
      public function DreamArenaRewardItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _titleText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRewardItem.titleText");
         _rewardBox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRewardItem.rewardBox");
         _line = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRewardItem.line");
         addChild(_titleText);
         addChild(_rewardBox);
         addChild(_line);
      }
      
      public function setTitleText(param1:String) : void
      {
         numStr = param1;
         var _loc2_:Array = numStr.split(",");
         if(_loc2_.length > 1)
         {
            _titleText.text = _loc2_[0] + "-" + _loc2_[1];
         }
         else
         {
            _titleText.text = numStr;
         }
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
         if(data)
         {
            _line.visible = true;
            data.sortOn("itemId",16);
            for each(var _loc4_:CommonDropTempInfo in data)
            {
               _loc2_ = new GoodsInfo();
               _loc3_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
               _loc2_.templateId = _loc4_.itemId;
               _loc2_.count = _loc4_.count;
               _loc3_.data = _loc2_;
               _rewardBox.addChild(_loc3_);
            }
         }
      }
      
      public function clean() : void
      {
         _titleText.text = "";
         _rewardBox.removeAllChild();
         _line.visible = false;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         super.dispose();
      }
   }
}

