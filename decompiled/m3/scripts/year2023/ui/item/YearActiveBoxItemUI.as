package year2023.ui.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.YearActiveManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class YearActiveBoxItemUI extends Sprite
   {
      
      protected var _itemBg:Bitmap;
      
      protected var _boxBtn:MovieClip;
      
      protected var _boxMc:MovieClip;
      
      protected var _icon:BaseItemView;
      
      public var pos:int;
      
      public function YearActiveBoxItemUI()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatBitmap("asset.yearactive.bao.itemBg");
         _boxBtn = ComponentFactory.Instance.creatCustomObject("ui.yearactive.boxBtn");
         _boxMc = ComponentFactory.Instance.creatCustomObject("ui.yearactive.boxMc");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.yearactive.lookLeftPreIcon");
         addChild(_itemBg);
         addChild(_boxBtn);
         addChild(_boxMc);
         _boxMc.gotoAndStop(1);
         _boxMc.mouseChildren = _boxMc.mouseEnabled = false;
      }
      
      public function init() : void
      {
         _boxMc.gotoAndStop(1);
         _boxBtn.mouseEnabled = true;
         _boxBtn.buttonMode = true;
         ObjectUtils.removeChildAllChildrenFromStage(_boxMc.icon);
      }
      
      public function playOrShow(param1:Array, param2:Boolean) : void
      {
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = int(param1[1]);
         _loc3_.count = int(param1[2]);
         _icon.data = _loc3_;
         if(param2)
         {
            _boxMc.gotoAndPlay(1);
         }
         else
         {
            _boxMc.gotoAndStop(44);
            _boxMc.icon.addChild(_icon);
            _boxBtn.mouseEnabled = false;
            _boxBtn.buttonMode = false;
         }
      }
      
      private function initEvent() : void
      {
         _boxBtn.addEventListener("click",boxClickHandler);
         _boxMc.addFrameScript(14,addIconFun);
      }
      
      private function addIconFun() : void
      {
         _boxMc.icon.addChild(_icon);
      }
      
      private function removeEvent() : void
      {
         _boxBtn.removeEventListener("click",boxClickHandler);
      }
      
      private function boxClickHandler(param1:MouseEvent) : void
      {
         YearActiveManager.ins.doSomething(7,pos);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeViolentMc(_boxBtn);
         _boxBtn = null;
         ObjectUtils.disposeViolentMc(_boxMc);
         _boxMc = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

