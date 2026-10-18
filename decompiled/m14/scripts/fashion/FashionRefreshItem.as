package fashion
{
   import cell.view.fashionbag.FashionBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FashionManager;
   import mvc.module.fashion.FashionModel;
   import mvc.module.fashion.FashionPolishInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.FashionPolishTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   
   public class FashionRefreshItem extends Sprite implements Disposeable
   {
      
      private var _data:GoodsInfo;
      
      private var _fashionItem:FashionBagCell;
      
      private var _progressBg:Bitmap;
      
      private var _progressBar:Bitmap;
      
      private var _ProgressRec:Sprite;
      
      private var _progressTxt:FilterFrameText;
      
      private var _lvTxt:FilterFrameText;
      
      private var _pos:int;
      
      private var _eventSprite:Sprite;
      
      private var _cellFun:Function;
      
      public function FashionRefreshItem(param1:int = 0, param2:Function = null)
      {
         super();
         _pos = param1;
         _cellFun = param2;
         initView();
         addEvent();
      }
      
      public function eventSprite() : void
      {
         if(!_eventSprite)
         {
            _eventSprite = new Sprite();
            _eventSprite.graphics.beginFill(65280,0);
            _eventSprite.graphics.drawRect(0,0,47,47);
            _eventSprite.graphics.endFill();
         }
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      private function initView() : void
      {
         _fashionItem = ComponentFactory.Instance.creatCustomObject("fashion.fashionBagCell");
         _fashionItem.unRegister = 1;
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.fashion.refreshPrBg");
         _progressBar = ComponentFactory.Instance.creatBitmap("asset.fashion.refreshBar");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshProgressTxt");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshLvTxt");
         _ProgressRec = new Sprite();
         _ProgressRec.graphics.beginFill(16711680);
         _ProgressRec.graphics.drawRect(0,0,_progressBar.width,_progressBar.height);
         _ProgressRec.x = -5;
         _ProgressRec.y = 58;
         _progressBar.mask = _ProgressRec;
         eventSprite();
         addChild(_fashionItem);
         addChild(_progressBg);
         addChild(_progressBar);
         addChild(_ProgressRec);
         addChild(_progressTxt);
         addChild(_lvTxt);
         addChild(_eventSprite);
      }
      
      private function addEvent() : void
      {
         if(_fashionItem)
         {
            _fashionItem.addEventListener("click",__onClick);
         }
         if(_fashionItem)
         {
            _fashionItem.addEventListener("mouseOver",__onOver);
         }
         if(_fashionItem)
         {
            _fashionItem.addEventListener("mouseOut",__onOut);
         }
         if(_eventSprite)
         {
            _eventSprite.addEventListener("click",__onClick);
         }
         if(_eventSprite)
         {
            _eventSprite.addEventListener("mouseOver",__onOver);
         }
         if(_eventSprite)
         {
            _eventSprite.addEventListener("mouseOut",__onOut);
         }
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         if(_cellFun != null)
         {
            _cellFun(this);
         }
      }
      
      private function __onOver(param1:MouseEvent) : void
      {
         effect = true;
      }
      
      private function __onOut(param1:MouseEvent) : void
      {
         effect = false;
      }
      
      private function removeEvent() : void
      {
         if(_fashionItem)
         {
            _fashionItem.removeEventListener("click",__onClick);
         }
         if(_fashionItem)
         {
            _fashionItem.removeEventListener("mouseOver",__onOver);
         }
         if(_fashionItem)
         {
            _fashionItem.removeEventListener("mouseOut",__onOut);
         }
         if(_eventSprite)
         {
            _eventSprite.removeEventListener("click",__onClick);
         }
         if(_eventSprite)
         {
            _eventSprite.removeEventListener("mouseOver",__onOver);
         }
         if(_eventSprite)
         {
            _eventSprite.removeEventListener("mouseOut",__onOut);
         }
      }
      
      private function set effect(param1:Boolean) : void
      {
         if(param1)
         {
            _fashionItem.filters = ComponentFactory.Instance.creatFilters("core.LightFilter");
            _eventSprite.filters = ComponentFactory.Instance.creatFilters("core.LightFilter");
         }
         else
         {
            _fashionItem.filters = null;
            _eventSprite.filters = null;
         }
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _fashionItem.visible = _progressBg.visible = _progressBar.visible = _ProgressRec.visible = _progressTxt.visible = _lvTxt.visible = true;
            _eventSprite.visible = false;
            _fashionItem.data = _data;
         }
         else
         {
            _fashionItem.visible = _progressBg.visible = _progressBar.visible = _ProgressRec.visible = _progressTxt.visible = _lvTxt.visible = false;
            _eventSprite.visible = true;
         }
      }
      
      public function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         var _loc5_:FashionPolishInfo = fashionModel.getPolishInfoBySontype(_pos);
         var _loc1_:int = int(FashionManager.instance.getSonTypeByindex(_pos));
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(_loc5_)
         {
            _loc2_ = int(_loc5_.level);
            _loc4_ = int(_loc5_.exp);
         }
         _lvTxt.text = LanguageMgr.GetTranslation("fashion.refreshView.tips08",_loc2_);
         var _loc6_:FashionPolishTemplateInfo = getTemplatesByLevelAndPos(_loc2_,_loc1_);
         var _loc3_:FashionPolishTemplateInfo = getTemplatesByLevelAndPos(_loc2_ + 1,_loc1_);
         if(!_loc3_)
         {
            _progressTxt.text = "max";
            _ProgressRec.scaleX = 1;
         }
         else
         {
            _progressTxt.text = _loc4_ + "/" + _loc3_.Exp;
            _ProgressRec.scaleX = _loc4_ / _loc3_.Exp;
         }
      }
      
      private function getTemplatesByLevelAndPos(param1:int, param2:int) : FashionPolishTemplateInfo
      {
         return TempleteManager.instance.fashionPolishTemplateCate.getTemplatesByLevelAndPos(param1,param2);
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_fashionItem);
         _fashionItem = null;
         ObjectUtils.disposeObject(_progressBg);
         _progressBg = null;
         ObjectUtils.disposeObject(_progressBar);
         _progressBar = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_ProgressRec);
         _ProgressRec = null;
         ObjectUtils.disposeObject(_eventSprite);
         _eventSprite = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _cellFun = null;
      }
   }
}

