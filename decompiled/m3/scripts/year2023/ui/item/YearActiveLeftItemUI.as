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
   
   public class YearActiveLeftItemUI extends Sprite
   {
      
      protected var _eggleftTxt:FilterFrameText;
      
      protected var _eggLeftIcon:BaseItemView;
      
      protected var _eggleftImg:Image;
      
      private var _data:SpeicalRewardTempInfo;
      
      public function YearActiveLeftItemUI()
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
            _eggLeftIcon.data = _loc3_;
            _eggleftTxt.text = "" + _data.Gear;
         }
      }
      
      private function initView() : void
      {
         _eggleftTxt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggleftTxt");
         _eggLeftIcon = ComponentFactory.Instance.creatCustomObject("ui.yearactive.eggLeftIcon");
         _eggleftImg = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.eggleftImg");
         addChild(_eggleftTxt);
         addChild(_eggLeftIcon);
         addChild(_eggleftImg);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_eggleftTxt);
         _eggleftTxt = null;
         ObjectUtils.disposeObject(_eggLeftIcon);
         _eggLeftIcon = null;
         ObjectUtils.disposeObject(_eggleftImg);
         _eggleftImg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

