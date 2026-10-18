package skytreasure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.SkyTreasureEvent;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureModel;
   import yishi.manager.SkyTreasureManager;
   import yishi.view.tips.BaseTip;
   
   public class SkyTreasureBoxShowTip extends BaseTip
   {
      
      private var _boxIndex:int;
      
      private var _hBox:HBox;
      
      private var _len:int;
      
      private var _titleText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      public function SkyTreasureBoxShowTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         initEvent();
         _titleText = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.boxShowView.titleText");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("skytreasure.boxviewshow.hBox");
         addChild(_titleText);
         addChild(_hBox);
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
         updateTransform();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BoxShowViewItem = null;
         if(_hBox)
         {
            _hBox.disposeAllChildren();
         }
         _len = model.chargeRewardList[_boxIndex - 1].itemsList.length;
         _bg.width = 80 * _len;
         _titleText.text = LanguageMgr.GetTranslation("activity.skytreasure.boxShowView.title");
         _loc2_ = 0;
         while(_loc2_ < _len)
         {
            _loc1_ = new BoxShowViewItem();
            _loc1_.setTitleData(_boxIndex,_loc2_);
            _hBox.addChild(_loc1_);
            _loc2_++;
         }
         _bg.width = _bg.width > 170 ? _bg.width : 170;
         _bg.height = _hBox.height + 50;
      }
      
      override protected function updateTransform() : void
      {
         if(tipData)
         {
            _boxIndex = int(tipData);
            refreshView();
         }
      }
      
      public function get model() : SkyTreasureModel
      {
         return SkyTreasureManager.Instance.model;
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
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ObjectUtils;
import flash.display.Sprite;
import mvc.module.skytreasure.SkyTreasureModel;
import yishi.datas.goods.GoodsInfo;
import yishi.manager.SkyTreasureManager;
import yishi.view.community.BaseItemView;

class BoxShowViewItem extends Sprite
{
   
   private var _nameTxt:FilterFrameText;
   
   private var _item:BaseItemView;
   
   public function BoxShowViewItem()
   {
      super();
      _nameTxt = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.boxShowView.nameText");
      _item = ComponentFactory.Instance.creatCustomObject("skytreasure.boxShowView.Item");
      addChild(_item);
      addChild(_nameTxt);
   }
   
   public function get model() : SkyTreasureModel
   {
      return SkyTreasureManager.Instance.model;
   }
   
   public function setTitleData(param1:int, param2:int) : void
   {
      var _loc3_:GoodsInfo = new GoodsInfo();
      _loc3_.templateId = model.chargeRewardList[param1 - 1].itemsList[param2].templateId;
      _loc3_.count = model.chargeRewardList[param1 - 1].itemsList[param2].count;
      _item.data = _loc3_;
      _nameTxt.text = _loc3_.templateInfo.TemplateName;
      _nameTxt.height = _nameTxt.textHeight + 5;
   }
   
   public function dispose() : void
   {
      ObjectUtils.disposeObject(_nameTxt);
      _nameTxt = null;
      ObjectUtils.disposeObject(_item);
      _item = null;
   }
}
