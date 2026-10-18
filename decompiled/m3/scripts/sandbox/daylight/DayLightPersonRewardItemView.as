package sandbox.daylight
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class DayLightPersonRewardItemView extends Sprite implements Disposeable
   {
      
      private var _rankTxt:FilterFrameText;
      
      private var _goodsItem:BaseItemView;
      
      private var _numTxt:FilterFrameText;
      
      private var _data:Object;
      
      public function DayLightPersonRewardItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightPersonRewardItemView.rankTxt");
         _goodsItem = ComponentFactory.Instance.creatCustomObject("daylight.DayLightPersonRewardItemView.goodsItem");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightPersonRewardItemView.numTxt");
         addChild(_rankTxt);
         addChild(_goodsItem);
         addChild(_numTxt);
         var _loc1_:String = LanguageMgr.GetTranslation("warlords.WarlordsGeneralListCell.str02",10);
         _loc1_ = LanguageMgr.GetTranslation("public.colon",_loc1_);
         _rankTxt.htmlText = _loc1_;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = 2060801;
         _goodsItem.data = _loc2_;
         _numTxt.htmlText = "*" + LanguageMgr.GetTranslation("ArialFont","999");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_goodsItem);
         _goodsItem = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:String = null;
         _data = param1;
         if(param1)
         {
            _loc2_ = LanguageMgr.GetTranslation("warlords.WarlordsGeneralListCell.str02",param1.rank);
            _loc2_ = LanguageMgr.GetTranslation("public.colon",_loc2_);
            _rankTxt.htmlText = _loc2_;
            _numTxt.htmlText = "*" + LanguageMgr.GetTranslation("ArialFont",param1.count);
         }
         else
         {
            _rankTxt.htmlText = "";
            _numTxt.htmlText = "";
         }
      }
      
      override public function get height() : Number
      {
         return 61;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

