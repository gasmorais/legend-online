package child.emblem
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import mvc.module.children.EmblemInfo;
   import yishi.filter.UIFilter;
   import yishi.utils.MsgMan;
   
   public class ChildEmblemItemView extends Component
   {
      
      private static var starConfig:Array = [[0,0,0],[1,0,0],[1,1,0],[1,1,1],[2,0,0],[2,2,0],[2,2,2],[3,0,0],[3,3,0],[3,3,3]];
      
      private var _pos:int;
      
      private var _data:EmblemInfo;
      
      private var _btn:IconButton;
      
      private var _bottomBg:Image;
      
      private var _ballLock:Image;
      
      private var _filter:UIFilter;
      
      private var _buttonMc1:MovieClip;
      
      private var _ball:Image;
      
      private var _star1:Image;
      
      private var _star2:Image;
      
      private var _star3:Image;
      
      public function ChildEmblemItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _filter = new UIFilter();
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.BallBg");
         _buttonMc1 = ComponentFactory.Instance.creatCustomObject("ChildEmblemBallView.shineMc");
         _btn = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.BallBtn");
         _ballLock = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.BallLock");
         _buttonMc1.gotoAndStop(1);
         addChild(_bottomBg);
         addChild(_buttonMc1);
         addChild(_ballLock);
         _ballLock.visible = false;
      }
      
      private function uintView() : void
      {
         _filter = null;
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         removeAllStars();
         isFollowMouse = false;
         tipStyle = "yishi.view.tips.OneLineTip";
         _data = model.selectedChild.emblemList[int(_pos / 3) + 2];
         _ball && _ball.parent && _ball.parent.removeChild(_ball);
         if(_data)
         {
            if(!_btn.parent)
            {
               _buttonMc1["pos"].addChild(_btn);
            }
            _btn.addEventListener("click",__ballBtnHandler);
            _ballLock.visible = false;
            if(_pos % 3 == 0)
            {
               _loc2_ = int(_data.resi1);
               _loc1_ = int(_data.grade1);
            }
            else if(_pos % 3 == 1)
            {
               _loc2_ = int(_data.resi2);
               _loc1_ = int(_data.grade2);
            }
            else if(_pos % 3 == 2)
            {
               _loc2_ = int(_data.resi3);
               _loc1_ = int(_data.grade3);
            }
            if(_loc2_ > 0)
            {
               tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemBallView.ballTip" + _loc2_,_data.getValueByIndex(_pos % 3 + 1));
               _ball = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.resi" + _loc2_ + "2");
               _ball.mouseEnabled = false;
               _ball.mouseChildren = false;
               _buttonMc1["pos"].addChild(_ball);
               _buttonMc1.gotoAndStop(1);
               refreshStars(_loc1_);
            }
            else
            {
               tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemBallView.seledtedAttribute");
               _buttonMc1.gotoAndPlay(1);
            }
            tipDirctions = "2,1";
         }
         else
         {
            if(_btn.parent)
            {
               _btn.parent.removeChild(_btn);
            }
            _btn.removeEventListener("click",__ballBtnHandler);
            _buttonMc1.gotoAndStop(1);
            _ballLock.visible = true;
            tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemTabView.openTip",int(_pos / 3) + 1);
            tipDirctions = "2,1";
         }
      }
      
      public function stopShining() : void
      {
         _buttonMc1.gotoAndStop(1);
      }
      
      private function refreshStars(param1:int) : void
      {
         _star1 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.star" + starConfig[param1 - 1][0]);
         _star2 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.star" + starConfig[param1 - 1][1]);
         _star3 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.star" + starConfig[param1 - 1][2]);
         _star2.x = _star3.x + 11;
         _star3.x += 22;
         addChild(_star1);
         addChild(_star2);
         addChild(_star3);
      }
      
      private function removeAllStars() : void
      {
         _star1 && _star1.parent && _star1.parent.removeChild(_star1);
         _star2 && _star2.parent && _star2.parent.removeChild(_star2);
         _star3 && _star3.parent && _star3.parent.removeChild(_star3);
      }
      
      private function __ballBtnHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         MsgMan.notifyObserver("ChildEvent.EMBLEM_BALL_CLICK",this);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function set pos(param1:int) : void
      {
         if(param1 < 0 || param1 > 14)
         {
            return;
         }
         _pos = param1;
         refreshView();
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      private function __ballClickHandler(param1:String, param2:Object) : void
      {
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_ballLock);
         _ballLock = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         ObjectUtils.disposeViolentMc(_buttonMc1);
         _buttonMc1 = null;
         ObjectUtils.disposeObject(_ball);
         _ball = null;
         ObjectUtils.disposeObject(_star1);
         _star1 = null;
         ObjectUtils.disposeObject(_star2);
         _star2 = null;
         ObjectUtils.disposeObject(_star3);
         _star3 = null;
         _data = null;
         super.dispose();
      }
   }
}

