package ui.maintoolbar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tools.SimpleMovie;
   
   public class PlayerExperenceView extends Component
   {
      
      private static var _isFirstRender:Boolean = true;
      
      private var _progress:MovieImage;
      
      private var _offlineBar:MovieImage;
      
      private var _vocationProgress:MovieImage;
      
      private var _vocationOfflineBar:MovieImage;
      
      public function PlayerExperenceView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _progress = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.PlayerExpProgress");
         _offlineBar = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.PlayerOfflineExpProgress");
         _vocationProgress = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.VocationExpProgress");
         _vocationOfflineBar = ComponentFactory.Instance.creatComponentByStylename("mainToolBar.VocationOfflineExpProgress");
         addChild(_offlineBar);
         addChild(_progress);
         addChild(_vocationOfflineBar);
         addChild(_vocationProgress);
         _progress.movie.gotoAndStop(1);
         _offlineBar.movie.gotoAndStop(1);
         _vocationProgress.movie.gotoAndStop(1);
         _vocationOfflineBar.movie.gotoAndStop(1);
         this.graphics.beginFill(0);
         this.graphics.drawRect(0,0,563,10);
         this.graphics.endFill();
      }
      
      private function initEvent() : void
      {
         thane.addEventListener("THANE_EXP_UPDATE",__updateHandler);
         thane.addEventListener("THANE_LEVEL_UPDATE",__updateHandler);
         playerInfo.addEventListener("VOCATION_GRADES",__playerVocationUpdateHandler);
         playerInfo.addEventListener("VOCATION_GP",__playerVocationUpdateHandler);
         playerInfo.addEventListener("VOCATION_INDEX",__playerVocationUpdateHandler);
         if(VersionSwitch.LEAVE_GP && _isFirstRender)
         {
            addEventListener("addedToStage",__onAddToStage);
            _isFirstRender = false;
         }
      }
      
      private function removeEvent() : void
      {
         thane.removeEventListener("THANE_EXP_UPDATE",__updateHandler);
         thane.removeEventListener("THANE_LEVEL_UPDATE",__updateHandler);
         playerInfo.removeEventListener("VOCATION_GRADES",__playerVocationUpdateHandler);
         playerInfo.removeEventListener("VOCATION_GP",__playerVocationUpdateHandler);
         playerInfo.removeEventListener("VOCATION_INDEX",__playerVocationUpdateHandler);
      }
      
      private function __onAddToStage(param1:Event) : void
      {
         var componentStyle:String;
         var _growmc:MovieClip;
         var self:Component;
         var mc:SimpleMovie;
         var e:Event = param1;
         removeEventListener("addedToStage",__onAddToStage);
         if(thane.offlineGp > 0)
         {
            if(playerInfo.vocationGrades > 0)
            {
               componentStyle = "mainToolBar.VocationGrow";
            }
            else
            {
               componentStyle = "mainToolBar.Grow";
            }
            _growmc = ComponentFactory.Instance.creat(componentStyle);
            self = this;
            mc = new SimpleMovie(_growmc,function():void
            {
               if(self)
               {
                  self.isFollowMouse = true;
                  self.startPoint = new Point();
                  ShowTipManager.Instance.hideTip(self);
                  self = null;
               }
            },8,1,function():void
            {
               if(self)
               {
                  self.isFollowMouse = false;
                  ShowTipManager.Instance.showTip(self);
               }
            });
            addChild(mc);
            _growmc = null;
            mc = null;
         }
      }
      
      private function __updateHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function __playerVocationUpdateHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function refreshView() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:String = null;
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc2_:int = 0;
         if(playerInfo.vocationGrades > 0)
         {
            _progress.visible = false;
            _offlineBar.visible = false;
            _vocationProgress.visible = true;
            _vocationOfflineBar.visible = true;
            if(playerInfo.isHoly)
            {
               _loc4_ = getNextGradeTemp(playerInfo.vocationGrades + 1,158);
            }
            else if(playerInfo.isAvenger)
            {
               _loc4_ = getNextGradeTemp(playerInfo.vocationGrades + 1,152);
            }
            else if(playerInfo.isChangeJob)
            {
               _loc4_ = getNextGradeTemp(playerInfo.vocationGrades + 1,110);
            }
            else
            {
               _loc4_ = getNextGradeTemp(playerInfo.vocationGrades + 1,105);
            }
            _loc2_ = playerInfo.vocationGp;
         }
         else
         {
            _progress.visible = true;
            _offlineBar.visible = true;
            _vocationProgress.visible = false;
            _vocationOfflineBar.visible = false;
            _loc4_ = getNextGradeTemp(thane.grades + 1,3);
            _loc2_ = thane.gp;
         }
         if(_loc4_)
         {
            _loc5_ = _loc2_ / _loc4_.Data * 100;
            _loc3_ = (_loc2_ + thane.offlineGp) * 100 / _loc4_.Data;
            if(VersionSwitch.LEAVE_GP)
            {
               _loc1_ = LanguageMgr.GetTranslation("mainBar.PlayerExperenceView.msg2",toArialBold(_loc2_ + " / " + _loc4_.Data),_loc5_,thane.offlineGp);
            }
            else
            {
               _loc1_ = toArialBold(String(_loc2_) + " / " + String(_loc4_.Data)) + "(" + String(_loc5_) + "%)";
            }
         }
         else
         {
            _loc5_ = 100;
            _loc3_ = 1;
            _loc1_ = LanguageMgr.GetTranslation("mainBar.PlayerExperenceView.msg");
         }
         _progress.movie.gotoAndStop(_loc5_);
         _offlineBar.movie.gotoAndStop(_loc3_);
         _vocationProgress.movie.gotoAndStop(_loc5_);
         _vocationOfflineBar.movie.gotoAndStop(_loc3_);
         tipData = _loc1_;
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      private function getNextGradeTemp(param1:int, param2:int) : UpgradeTemplateInfo
      {
         return TempleteManager.instance.getTemplateByLevelAndType(param1,param2);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_offlineBar);
         _offlineBar = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_vocationProgress);
         _vocationProgress = null;
         ObjectUtils.disposeObject(_vocationOfflineBar);
         _vocationOfflineBar = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

