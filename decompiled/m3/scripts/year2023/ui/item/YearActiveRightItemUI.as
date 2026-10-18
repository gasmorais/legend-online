package year2023.ui.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SpeicalRewardTempInfo;
   import yishi.view.community.BaseItemView;
   
   public class YearActiveRightItemUI extends Sprite
   {
      
      protected var _egglrightTxt:FilterFrameText;
      
      protected var _eggRightIcon:BaseItemView;
      
      protected var _eggrightImg:Image;
      
      private var _data:SpeicalRewardTempInfo;
      
      public function YearActiveRightItemUI()
      {
         super();
         initView();
      }
      
      public function set data(param1:SpeicalRewardTempInfo) : void
      {
         var _loc2_:Array = null;
         var _loc3_:GoodsInfo = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = _data.FreeReward.split(",");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = int(_loc2_[0]);
            _loc3_.count = int(_loc2_[1]);
            _eggRightIcon.data = _loc3_;
            _egglrightTxt.text = "" + _data.Gear;
         }
      }
      
      private function initView() : void
      {
         _egglrightTxt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.egglrightTxt");
         _eggRightIcon = ComponentFactory.Instance.creatCustomObject("ui.yearactive.eggRightIcon");
         _eggrightImg = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggrightImg");
         addChild(_egglrightTxt);
         addChild(_eggRightIcon);
         addChild(_eggrightImg);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_egglrightTxt);
         _egglrightTxt = null;
         ObjectUtils.disposeObject(_eggRightIcon);
         _eggRightIcon = null;
         ObjectUtils.disposeObject(_eggrightImg);
         _eggrightImg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

