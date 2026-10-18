package thessbox.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.ThessboxFightInfo;
   import thessbox.ui.ThessBoxLeftUI;
   import yishi.datas.templates.ThessBoxMapInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   
   public class ThessBoxLeftView extends ThessBoxLeftUI
   {
      
      private var _simpleTitle:SimpleTileList;
      
      private var _itemList:Array = [];
      
      private var _switchBtn:Sprite;
      
      private var _isShow:Boolean = true;
      
      public function ThessBoxLeftView()
      {
         super();
         _simpleTitle = ComponentFactory.Instance.creatCustomObject("ui.thessbox.leftRewardList",[3]);
         addChild(_simpleTitle);
         _ftmg.setFrame(1);
         _switchBtn = ComponentFactory.Instance.creatCustomObject("ui.thessbox.SwitchBtn");
         _switchBtn.graphics.beginFill(16711680,0);
         _switchBtn.graphics.drawRect(0,0,28,89);
         _switchBtn.graphics.endFill();
         _switchBtn.buttonMode = true;
         addChild(_switchBtn);
         initEvent();
      }
      
      private function initEvent() : void
      {
         TheseussoulManager.Instance.addEventListener("EVENT_BOX_FIGHT",updateViewHandler);
         _leftBagBtn.addEventListener("click",bagClickHandler);
         _switchBtn.addEventListener("click",__switchBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         TheseussoulManager.Instance.removeEventListener("EVENT_BOX_FIGHT",updateViewHandler);
         _leftBagBtn.removeEventListener("click",bagClickHandler);
         _switchBtn.removeEventListener("click",__switchBtnClickHandler);
      }
      
      private function __switchBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _isShow = !_isShow;
         if(_isShow)
         {
            doShow();
         }
         else
         {
            doHide();
         }
      }
      
      private function doShow() : void
      {
         _ftmg.setFrame(1);
         _ArrowImg.scaleX = 1;
         _ArrowImg.x = 213;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":0});
      }
      
      private function doHide() : void
      {
         _ftmg.setFrame(2);
         _ArrowImg.scaleX = -1;
         _ArrowImg.x = 228;
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":-212});
      }
      
      private function bagClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("thessbox","ThessBoxSkillBagFrame");
      }
      
      public function show() : void
      {
         updateViewHandler();
         LayerManager.Instance.addToLayer(this,4,false,false);
      }
      
      private function updateViewHandler(param1:Event = null) : void
      {
         var _loc7_:Array = null;
         var _loc4_:int = 0;
         var _loc2_:ThessBoxDropItem = null;
         var _loc6_:int = 0;
         var _loc3_:ThessboxFightInfo = TheseussoulManager.Instance.thessboxInInfo;
         _levelTxt.text = LanguageMgr.GetTranslation("thessbox.dx",_loc3_.curLevel);
         var _loc5_:ThessBoxMapInfo = TempleteManager.instance.thessBoxMapCate.getTempByChapterIdAndMapId(_loc3_.mapId,_loc3_.chapterId);
         if(_loc5_)
         {
            if(!_loc5_.Award)
            {
               _desTxt.visible = true;
               _desTxt.text = LanguageMgr.GetTranslation("thessbox.empetyTip");
            }
            else
            {
               _desTxt.visible = false;
               _loc7_ = _loc5_.Award.split("|");
               _loc4_ = int(_loc7_.length);
               _simpleTitle.beginChanges();
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  if(_loc6_ >= _itemList.length)
                  {
                     _loc2_ = new ThessBoxDropItem();
                     _itemList.push(_loc2_);
                  }
                  else
                  {
                     _loc2_ = _itemList[_loc6_];
                  }
                  _loc2_.data = _loc7_[_loc6_];
                  _simpleTitle.addChild(_loc2_);
                  _loc6_++;
               }
               _simpleTitle.commitChanges();
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_switchBtn);
         _switchBtn = null;
         ObjectUtils.disposeObject(_simpleTitle);
         _simpleTitle = null;
         super.dispose();
      }
   }
}

