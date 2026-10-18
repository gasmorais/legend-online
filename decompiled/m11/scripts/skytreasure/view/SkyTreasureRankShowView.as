package skytreasure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import events.SkyTreasureEvent;
   import mvc.module.skytreasure.SkyTreasureModel;
   import yishi.manager.SkyTreasureManager;
   import yishi.view.tips.BaseTip;
   
   public class SkyTreasureRankShowView extends BaseTip
   {
      
      private var _vBox:VBox;
      
      public function SkyTreasureRankShowView()
      {
         super();
         initEvent();
      }
      
      public function get model() : SkyTreasureModel
      {
         return SkyTreasureManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         SkyTreasureManager.Instance.addEventListener("SKYTREASURE_ACTIVES_INFO",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         SkyTreasureManager.Instance.removeEventListener("SKYTREASURE_ACTIVES_INFO",__updateHandler);
      }
      
      private function __updateHandler(param1:SkyTreasureEvent) : void
      {
         init();
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ShowItemView = null;
         super.init();
         _bg.width = 360;
         _bg.height = model.ranRewardsList.length * 60;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("skytreasure.rankviewshow.vBox1");
         _loc2_ = 0;
         while(_loc2_ < model.ranRewardsList.length)
         {
            _loc1_ = new ShowItemView();
            _loc1_.setTitleData(_loc2_ + 1);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         addChild(_vBox);
         _bg.width = _vBox.width + 20;
      }
      
      override public function get height() : Number
      {
         if(_bg)
         {
            return _bg.height;
         }
         return super.height;
      }
      
      override public function get width() : Number
      {
         if(_bg)
         {
            return _bg.width;
         }
         return super.width;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.controls.container.HBox;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ObjectUtils;
import flash.display.Sprite;
import manager.LanguageMgr;
import mvc.module.skytreasure.SkyTreasureModel;
import yishi.datas.goods.GoodsInfo;
import yishi.manager.SkyTreasureManager;
import yishi.view.community.BaseItemView;

class ShowItemView extends Sprite
{
   
   private var _titletxt:FilterFrameText;
   
   private var _hBox:HBox;
   
   public function ShowItemView()
   {
      super();
      _titletxt = ComponentFactory.Instance.creatComponentByStylename("skytreasure.rankView.titleTxt");
      _hBox = ComponentFactory.Instance.creatComponentByStylename("skytreasure.rankView.hbox2");
      _hBox.addChild(_titletxt);
      addChild(_hBox);
   }
   
   public function get model() : SkyTreasureModel
   {
      return SkyTreasureManager.Instance.model;
   }
   
   public function setTitleData(param1:int) : void
   {
      var _loc4_:int = 0;
      var _loc3_:BaseItemView = null;
      var _loc2_:GoodsInfo = null;
      if(param1 == 1)
      {
         _titletxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.showView.value01");
      }
      else if(param1 == 2)
      {
         _titletxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.showView.value02");
      }
      else if(param1 == 3)
      {
         _titletxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.showView.value03");
      }
      _loc4_ = 0;
      while(_loc4_ < model.ranRewardsList[param1 - 1].itemsList.length)
      {
         _loc3_ = ComponentFactory.Instance.creatCustomObject("skytreasure.boxShowView.Item");
         _loc2_ = new GoodsInfo();
         _loc2_.templateId = model.ranRewardsList[param1 - 1].itemsList[_loc4_].templateId;
         _loc2_.count = model.ranRewardsList[param1 - 1].itemsList[_loc4_].count;
         _loc3_.data = _loc2_;
         _hBox.addChild(_loc3_);
         _loc4_++;
      }
   }
   
   public function dispose() : void
   {
      ObjectUtils.disposeObject(_titletxt);
      _titletxt = null;
      ObjectUtils.disposeObject(_hBox);
      _hBox = null;
   }
}
