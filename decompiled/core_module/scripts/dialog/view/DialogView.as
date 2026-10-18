package dialog.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import dialog.DialogControl;
   import dialog.DialogWordView;
   import dialog.data.DialogMessageInfo;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import manager.LanguageMgr;
   import yishi.datas.PathInfo;
   import yishi.scene.SceneManager;
   
   public class DialogView extends Sprite implements Disposeable
   {
      
      private static const MAX_TIME_OUT:int = 120000;
      
      private var _headWide:int;
      
      private var _whiteBg:Shape;
      
      private var _continueBtn:MovieClip;
      
      private var _topBg:ScaleBitmapImage;
      
      private var _bottomBg:ScaleBitmapImage;
      
      private var _leftImage:DialogRoleImage;
      
      private var _rightImage:DialogRoleImage;
      
      private var _dialogWordView:DialogWordView;
      
      private var _parentObj:DisplayObject;
      
      private var _isAuto:Boolean;
      
      private var _control:DialogControl;
      
      private var _showBg:Boolean;
      
      private var _timerId:int;
      
      private var _count:int;
      
      private var _isPlay:Boolean;
      
      public function DialogView(param1:DialogControl, param2:DisplayObject, param3:Boolean = true, param4:Boolean = true)
      {
         _parentObj = param2;
         _isAuto = param3;
         _control = param1;
         _showBg = param4;
         super();
         init();
      }
      
      private function init() : void
      {
         _whiteBg = new Shape();
         _whiteBg.graphics.beginFill(0,0);
         _whiteBg.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _whiteBg.graphics.endFill();
         addChild(_whiteBg);
         _topBg = ComponentFactory.Instance.creatComponentByStylename("core.novice.DialogUpBg");
         _topBg.alpha = 0;
         _topBg.width = 400;
         _topBg.height = 15;
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("core.novice.DialogBg");
         _bottomBg.alpha = 0;
         _bottomBg.height = 150;
         if(_showBg)
         {
            addChild(_bottomBg);
            addChild(_topBg);
         }
         if(_leftImage)
         {
            _leftImage.dispose();
            ObjectUtils.disposeObject(_leftImage);
            _leftImage = null;
         }
         _leftImage = new DialogRoleImage();
         _leftImage.alpha = 0;
         addChild(_leftImage);
         if(_rightImage)
         {
            _rightImage.dispose();
            ObjectUtils.disposeObject(_rightImage);
            _rightImage = null;
         }
         _rightImage = new DialogRoleImage();
         _rightImage.scaleX = -1;
         _rightImage.alpha = 0;
         addChild(_rightImage);
         refreshHeadWide();
         _dialogWordView = new DialogWordView();
         _dialogWordView.x = _headWide;
         _continueBtn = ComponentFactory.Instance.creatCustomObject("core.novice.ContinueBtnMc");
         _continueBtn.visible = false;
         addChild(_dialogWordView);
         addChild(_continueBtn);
         StageReferance.stage.addEventListener("resize",__onResizeHandler);
         StageReferance.stage.addEventListener("keyDown",__onKeyDownHandler,false,101);
         addEventListener("click",__onClickHandler);
         __onResizeHandler();
      }
      
      public function setRoles(param1:Dictionary, param2:Dictionary) : void
      {
         _rightImage.loadImages(param1);
         _leftImage.loadImages(param2);
      }
      
      private function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __onResizeHandler(param1:Event = null) : void
      {
         _whiteBg.width = StageReferance.stageWidth;
         _whiteBg.height = StageReferance.stageHeight;
         var _loc2_:Number = StageReferance.stageWidth;
         var _loc3_:Number = StageReferance.stageHeight;
         if(_parentObj != StageReferance.stage)
         {
            if(_parentObj.x >= 0)
            {
               this.x = _parentObj.x;
            }
            if(_parentObj.y >= 0)
            {
               this.y = _parentObj.y;
            }
            if(SceneManager.instance.currentType == "BATTLE_SCENE")
            {
               if(_parentObj["sceneWidth"] < StageReferance.stageWidth)
               {
                  _loc2_ = Number(_parentObj["sceneWidth"]);
               }
               if(_parentObj["sceneHeight"] < StageReferance.stageHeight)
               {
                  _loc3_ = Number(_parentObj["sceneHeight"]);
               }
            }
            else
            {
               if(_parentObj.width < StageReferance.stageWidth)
               {
                  _loc2_ = _parentObj.width;
               }
               if(_parentObj.height < StageReferance.stageHeight)
               {
                  _loc3_ = _parentObj.height;
               }
            }
         }
         if(_loc2_ < PathInfo.GAME_WIDTH)
         {
            _loc2_ = PathInfo.GAME_WIDTH;
         }
         if(_loc3_ < PathInfo.GAME_HEIGHT)
         {
            _loc3_ = PathInfo.GAME_HEIGHT;
         }
         this.scrollRect = new Rectangle(0,0,_loc2_,_loc3_);
         _bottomBg.width = _loc2_;
         _bottomBg.y = _loc3_ - _bottomBg.displayHeight + 26;
         _topBg.x = (_bottomBg.width - _topBg.width) / 2;
         _topBg.y = _bottomBg.y - 6;
         _leftImage.x = -5;
         _leftImage.y = _bottomBg.y - 165;
         _rightImage.x = _loc2_ + 10;
         _rightImage.y = _leftImage.y;
         refreshHeadWide();
         _dialogWordView.y = _bottomBg.y + 5;
         _dialogWordView.refreshSize(_loc2_ - _headWide * 2 + 20);
         _dialogWordView.x = _headWide;
         _continueBtn.x = _loc2_ - _continueBtn.width - _headWide;
         _continueBtn.y = _dialogWordView.y + 85;
      }
      
      private function refreshHeadWide() : void
      {
         if(StageReferance.stageWidth < 1000)
         {
            _headWide = 300;
         }
         else if(StageReferance.stageWidth > 1500)
         {
            _headWide = 400;
         }
         else
         {
            _headWide = (StageReferance.stageWidth - 1000) / 500 * 100 + 300;
         }
      }
      
      private function swapHeadImg(param1:DialogMessageInfo) : void
      {
         var _loc2_:DialogRoleImage = null;
         if(!param1)
         {
            return;
         }
         if(param1.direction == 0)
         {
            _loc2_ = _leftImage;
            TweenMax.to(_rightImage,0,{"alpha":0});
         }
         else
         {
            _loc2_ = _rightImage;
            TweenMax.to(_leftImage,0,{"alpha":0});
         }
         TweenMax.to(_loc2_,0.5,{
            "alpha":1,
            "colorTransform":{
               "tint":0,
               "tintAmount":0.01
            }
         });
         _loc2_.swapToRoleById(param1.roleId);
      }
      
      public function showMessage(param1:DialogMessageInfo) : void
      {
         var _loc2_:int = 0;
         if(_timerId > 0)
         {
            clearInterval(_timerId);
         }
         _timerId = 0;
         _isPlay = true;
         TweenMax.to(_topBg,0.5,{"alpha":1});
         TweenMax.to(_bottomBg,0.5,{"alpha":1});
         swapHeadImg(param1);
         _continueBtn.visible = false;
         _dialogWordView.setSentence(param1.txt,speakEndHandler,param1.roleName);
         if(_isAuto)
         {
            _loc2_ = int(param1.delayTime ? param1.delayTime : 10);
            _count = _loc2_;
            _timerId = setInterval(onTimerUpdate,1000);
         }
      }
      
      private function onTimerUpdate() : void
      {
         _count = _count - 1;
         if(_continueBtn && _continueBtn["txt"])
         {
            _continueBtn["txt"].text = LanguageMgr.GetTranslation("dialog.view.DialogView.continueBtn.Text",_count);
         }
         if(_count <= 0)
         {
            __onClickHandler();
         }
      }
      
      private function speakEndHandler() : void
      {
         _isPlay = false;
         _continueBtn.visible = true;
      }
      
      private function __onClickHandler(param1:Event = null) : void
      {
         if(!parent)
         {
            return;
         }
         if(!_dialogWordView)
         {
            return;
         }
         if(_dialogWordView.completeSpeak())
         {
            return;
         }
         if(_timerId > 0)
         {
            clearInterval(_timerId);
         }
         _timerId = 0;
         _control.gotoAndNextMessage();
      }
      
      private function __onKeyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 32)
         {
            __onClickHandler();
         }
      }
      
      public function dispose() : void
      {
         StageReferance.stage.removeEventListener("resize",__onResizeHandler);
         StageReferance.stage.removeEventListener("keyDown",__onKeyDownHandler,false);
         removeEventListener("click",__onClickHandler);
         if(_whiteBg)
         {
            _whiteBg.graphics.clear();
            if(_whiteBg.parent)
            {
               _whiteBg.parent.removeChild(_whiteBg);
            }
         }
         _whiteBg = null;
         if(_continueBtn)
         {
            _continueBtn.stop();
            if(_continueBtn.parent)
            {
               _continueBtn.parent.removeChild(_continueBtn);
            }
         }
         _continueBtn = null;
         ObjectUtils.disposeObject(_topBg);
         _topBg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_leftImage);
         _leftImage = null;
         ObjectUtils.disposeObject(_rightImage);
         _rightImage = null;
         ObjectUtils.disposeObject(_dialogWordView);
         _dialogWordView = null;
         _parentObj = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

