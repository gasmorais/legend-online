package map.campaign.view.ui.airgarden.game.llk.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.AirGardenGameLlkManager;
   import mvc.module.llk.LlkModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class AirGardenGameLlkGoodsItem extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _goodsIcon:ScaleFrameImage;
      
      private var _goodsName:FilterFrameText;
      
      private var _goodsCount:FilterFrameText;
      
      private var _useBtn:IconButton;
      
      private var _type:int;
      
      private var _bomoPoint:int;
      
      private var _resetPoint:int;
      
      public function AirGardenGameLlkGoodsItem()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         var _loc1_:ConfigInfosTempInfo = null;
         _bomoPoint = 10;
         _resetPoint = 10;
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("linkgame_bomb_need");
         if(_loc1_ && parseInt(_loc1_.ConfigValue))
         {
            _bomoPoint = parseInt(_loc1_.ConfigValue);
         }
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("linkgame_reset_need");
         if(_loc1_ && parseInt(_loc1_.ConfigValue))
         {
            _resetPoint = parseInt(_loc1_.ConfigValue);
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.llk.LlkGoodsItemBg");
         _goodsIcon = ComponentFactory.Instance.creatComponentByStylename("LlkGoodsItem.goodsIcon");
         _goodsName = ComponentFactory.Instance.creatComponentByStylename("LlkGoodsItem.goodsName");
         _goodsCount = ComponentFactory.Instance.creatComponentByStylename("LlkGoodsItem.goodsCount");
         _useBtn = ComponentFactory.Instance.creatComponentByStylename("LlkGoodsItem.useBtn2");
         addChild(_bg);
         addChild(_goodsIcon);
         addChild(_goodsName);
         addChild(_goodsCount);
         addChild(_useBtn);
         _useBtn.x = 34;
      }
      
      public function refresh() : void
      {
         if(_type == 1)
         {
            if(_goodsIcon)
            {
               _goodsIcon.setFrame(1);
            }
            if(_goodsName)
            {
               _goodsName.text = LanguageMgr.GetTranslation("llk.view.LlkGoodsItem.GoodsName1");
            }
            if(_goodsCount)
            {
               _goodsCount.text = "x" + model.info.bombCount;
            }
         }
         else if(_type == 2)
         {
            if(_goodsIcon)
            {
               _goodsIcon.setFrame(2);
            }
            if(_goodsName)
            {
               _goodsName.text = LanguageMgr.GetTranslation("llk.view.LlkGoodsItem.GoodsName2");
            }
            if(_goodsCount)
            {
               _goodsCount.text = "x" + model.info.resetCount;
            }
         }
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         refresh();
      }
      
      private function initEvent() : void
      {
         if(_useBtn)
         {
            _useBtn.addEventListener("click",__useClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_useBtn)
         {
            _useBtn.removeEventListener("click",__useClickHandler);
         }
      }
      
      private function __useClickHandler(param1:MouseEvent) : void
      {
         if(_type == 1)
         {
            if(model.info.bombCount <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("AirGardenGame.hint1"));
            }
            else if(isNullMap)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("llk.view.LlkGoodsItem.gateNotStart"));
            }
            else
            {
               AirGardenGameLlkManager.llkOp(3);
            }
         }
         else if(_type == 2)
         {
            if(model.info.resetCount <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("AirGardenGame.hint2"));
            }
            else if(isNullMap)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("llk.view.LlkGoodsItem.gateNotStart"));
            }
            else
            {
               AirGardenGameLlkManager.llkOp(4);
            }
         }
      }
      
      private function get isNullMap() : Boolean
      {
         var _loc3_:int = 0;
         if(StringHelper.isNullOrEmpty(model.info.points))
         {
            return true;
         }
         var _loc1_:Array = [];
         var _loc2_:Boolean = true;
         _loc1_ = model.info.points.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc1_[_loc3_] != 0)
            {
               _loc2_ = false;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function get model() : LlkModel
      {
         return AirGardenGameLlkManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_goodsIcon);
         _goodsIcon = null;
         ObjectUtils.disposeObject(_goodsName);
         _goodsName = null;
         ObjectUtils.disposeObject(_goodsCount);
         _goodsCount = null;
         ObjectUtils.disposeObject(_useBtn);
         _useBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

