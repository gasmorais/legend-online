package map.campaign.view.ui.flametemple
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class FlameTemplePersonRewardItemView extends Sprite implements Disposeable
   {
      
      private var _rankTxt:FilterFrameText;
      
      private var _goodsItem1:BaseItemView;
      
      private var _goodsItem2:BaseItemView;
      
      private var _numTxt1:FilterFrameText;
      
      private var _numTxt2:FilterFrameText;
      
      private var _data:Object;
      
      public function FlameTemplePersonRewardItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("flameTemplePersonRewardItemView.rankTxt");
         _goodsItem1 = ComponentFactory.Instance.creatCustomObject("flameTemplePersonRewardItemView.goodsItem");
         _goodsItem2 = ComponentFactory.Instance.creatCustomObject("flameTemplePersonRewardItemView.goodsItem2");
         _numTxt1 = ComponentFactory.Instance.creatComponentByStylename("flameTemplePersonRewardItemView.numTxt");
         _numTxt2 = ComponentFactory.Instance.creatComponentByStylename("flameTemplePersonRewardItemView.numTxt2");
         addChild(_rankTxt);
         addChild(_goodsItem1);
         addChild(_goodsItem2);
         addChild(_numTxt1);
         addChild(_numTxt2);
         var _loc3_:String = LanguageMgr.GetTranslation("warlords.WarlordsGeneralListCell.str02",10);
         _loc3_ = LanguageMgr.GetTranslation("public.colon",_loc3_);
         _rankTxt.htmlText = _loc3_;
         var _loc2_:GoodsInfo = new GoodsInfo();
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = 208031;
         _loc1_.templateId = 208014;
         _goodsItem1.data = _loc2_;
         _goodsItem2.data = _loc1_;
         _numTxt1.htmlText = "*" + LanguageMgr.GetTranslation("ArialFont","999");
         _numTxt2.htmlText = "*" + LanguageMgr.GetTranslation("ArialFont","999");
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_goodsItem1);
         _goodsItem1 = null;
         ObjectUtils.disposeObject(_goodsItem2);
         _goodsItem2 = null;
         ObjectUtils.disposeObject(_numTxt1);
         _numTxt1 = null;
         ObjectUtils.disposeObject(_numTxt2);
         _numTxt1 = null;
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
            _numTxt1.htmlText = "*" + LanguageMgr.GetTranslation("ArialFont",param1.count);
            _numTxt2.htmlText = "*" + LanguageMgr.GetTranslation("ArialFont",param1.count2);
         }
         else
         {
            _rankTxt.htmlText = "";
            _numTxt1.htmlText = "";
            _numTxt2.htmlText = "";
         }
      }
      
      override public function get height() : Number
      {
         return 61;
      }
      
      public function dispose() : void
      {
         removeEvent();
         initView();
      }
   }
}

