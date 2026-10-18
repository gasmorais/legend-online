package map.outercity.view.mapphysics
{
   import avatar.data.AvatarStaticData;
   import avatar.view.Avatar;
   import avatar.view.HeroAvatar;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.IManualTipTargetSize;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.internals.data.MapPhysics;
   import map.internals.data.PhysicsEvent;
   import map.internals.data.WildLand;
   import map.internals.event.OuterCityEvent;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.internals.view.hero.HeroAvatarView;
   import map.outercity.manager.OuterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class OuterCityNpcView extends HeroAvatarView implements IBaseMouseEvent, IManualTipTargetSize
   {
      
      private var _nodeInfo:MapPhysics;
      
      protected var _attacking:MovieClip;
      
      protected var _toAttackBtn:BaseButton;
      
      private var _nameText:FilterFrameText;
      
      public function OuterCityNpcView()
      {
         super();
         this.mouseChildren = false;
         tipStyle = "tips.MapPhysicsTip";
         tipDirctions = "4,6,5,7";
         isFollowMouse = false;
         startPoint = new Point(-30,-40);
      }
      
      override public function set avatarView(param1:Avatar) : void
      {
         super.avatarView = param1;
         avatarView.scaleX = _nodeInfo.info.size / 10;
         avatarView.scaleY = _nodeInfo.info.size / 10;
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:int = getCurrentPixels();
         if(_loc2_ < 50)
         {
            return false;
         }
         NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",_nodeInfo));
         return true;
      }
      
      private function showInfo() : void
      {
         OuterFrameManager.getInstance().open(4,_nodeInfo);
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:int = getCurrentPixels();
         if(_loc2_ < 50)
         {
            mouseOutHandler(param1);
            return false;
         }
         return mouseOverHandler(param1);
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:int = getCurrentPixels();
         if(_loc2_ < 50)
         {
            return false;
         }
         if(_avatar)
         {
            _filter.setGlowFilter(_avatar.contentBitmap);
         }
         return true;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         if(_avatar)
         {
            _filter.setNormalFilter(_avatar.contentBitmap);
            return true;
         }
         return false;
      }
      
      public function set nodeInfo(param1:MapPhysics) : void
      {
         var _loc2_:Object = null;
         var _loc4_:String = null;
         _nodeInfo = param1;
         var _loc3_:int = int((_nodeInfo as WildLand).tempInfo.SonType);
         avatarView = new HeroAvatar(true,_loc3_.toString(),2,0,false);
         updateDirection(45);
         showNameText();
         _loc4_ = PathManager.getAvatarResourcePath(_loc3_.toString(),-1,1,"body",-1,2);
         _loc2_ = createResourceLoadInfo(_loc4_,AvatarStaticData.getBaseNumByType("Stand","body"),AvatarStaticData.getBaseNumByType("Walk","body"),"body");
         LoaderManagerII.instance.load(_loc4_,4,7,loaderCompleteHandler,null,null,_loc2_);
         _avatar.state = 3;
         _nodeInfo.info.addEventListener("UP_STATE",__upStateHandler);
         _nodeInfo.info.state = param1.info.state;
      }
      
      private function onAttackClick(param1:MouseEvent) : void
      {
         NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",_nodeInfo));
      }
      
      private function removeNameTxt() : void
      {
         if(_nameText)
         {
            if(_nameText.parent)
            {
               _nameText.parent.removeChild(_nameText);
            }
         }
         _nameText = null;
      }
      
      private function showNameText() : void
      {
         _nameText = _nameText ? _nameText : ComponentFactory.Instance.creatComponentByStylename("outercity.OutercityNameText");
         _nameText.text = LanguageMgr.GetTranslation("public.level.name",wildLandInfo.tempInfo.MapPhysicsTempName,wildLandInfo.info.grade);
         _nameText.setFrame(5);
         _nameText.x = -_nameText.width / 2;
         _nameText.height = _nameText.textHeight + 20;
         _nameText.y = -120 - 20 * (_nameText.numLines - 1);
         if(_isPlaying)
         {
            addChild(_nameText);
         }
      }
      
      private function layouTextView(param1:String) : void
      {
         if(!_nameText)
         {
            return;
         }
         var _loc2_:int = -120;
         var _loc3_:Object = LoaderHeaderList.avatarShowNamePos[param1];
         if(_loc3_ && _loc3_.showNamePosY)
         {
            _loc2_ = int(_loc3_.showNamePosY);
         }
         _nameText.y = _loc2_;
      }
      
      private function __upStateHandler(param1:PhysicsEvent) : void
      {
         var _loc2_:int = int(wildLandInfo.info.state);
         if(_loc2_ == 1)
         {
            clearFireView();
         }
         else if(_loc2_ == 4)
         {
            setFireView();
         }
         else if(_loc2_ == 0)
         {
            dispose();
         }
      }
      
      private function setFireView() : void
      {
         if(!_attacking)
         {
            _attacking = ComponentFactory.Instance.creatCustomObject("asset.outercity.AttackingAsset");
            _attacking.y = -70;
            _toAttackBtn = ComponentFactory.Instance.creatComponentByStylename("outercity.npc.AttackImgButton");
            _toAttackBtn.addEventListener("click",onAttackClick);
            _toAttackBtn.x += this.x;
            _toAttackBtn.y = this.y - _toAttackBtn.y - 230;
         }
         if(_isPlaying)
         {
            addChild(_attacking);
            _attacking.play();
            if(this.parent != null)
            {
               this.parent.addChild(_toAttackBtn);
            }
            else
            {
               this.addEventListener("addedToStage",onAddToStage);
            }
         }
      }
      
      private function onAddToStage(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onAddToStage);
         _toAttackBtn.x += this.x;
         _toAttackBtn.y += this.y;
         this.parent.addChild(_toAttackBtn);
      }
      
      private function clearFireView() : void
      {
         if(_attacking)
         {
            if(_attacking.parent)
            {
               _attacking.parent.removeChild(_attacking);
            }
            _attacking.stop();
         }
         _attacking = null;
         if(_toAttackBtn)
         {
            if(_toAttackBtn.parent)
            {
               _toAttackBtn.parent.removeChild(_toAttackBtn);
            }
            _toAttackBtn = null;
         }
      }
      
      public function get wildLandInfo() : WildLand
      {
         return _nodeInfo as WildLand;
      }
      
      public function get nodeInfo() : MapPhysics
      {
         return _nodeInfo;
      }
      
      override public function get tipData() : Object
      {
         var _loc2_:MultipleDictionaryInfo = new MultipleDictionaryInfo();
         var _loc1_:String = LanguageMgr.GetTranslation("public.playerInfo.ap");
         _loc2_.addItem(LanguageMgr.GetTranslation("public.level.name",wildLandInfo.tempInfo.MapPhysicsTempName,wildLandInfo.tempInfo.Grades),null);
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         if(_nodeInfo)
         {
            _nodeInfo.nodeView = null;
         }
         resetSelectMovie();
         clearFireView();
         removeNameTxt();
         _nodeInfo.info.removeEventListener("UP_STATE",__upStateHandler);
         if(_toAttackBtn)
         {
            if(_toAttackBtn.parent)
            {
               _toAttackBtn.parent.removeChild(_toAttackBtn);
            }
            _toAttackBtn = null;
         }
         super.dispose();
      }
      
      public function get manualHeight() : Number
      {
         return 90;
      }
      
      public function get manualWidth() : Number
      {
         return 60;
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         super.isPlaying = param1;
         if(!param1)
         {
            if(_attacking && _attacking.parent)
            {
               _attacking.parent.removeChild(_attacking);
            }
            if(_nameText && _nameText.parent)
            {
               _nameText.parent.removeChild(_nameText);
            }
            if(_toAttackBtn && _toAttackBtn.parent)
            {
               _toAttackBtn.parent.removeChild(_toAttackBtn);
            }
         }
         else
         {
            if(_attacking)
            {
               addChild(_attacking);
            }
            if(_nameText)
            {
               addChild(_nameText);
            }
            if(_toAttackBtn)
            {
               this.parent.addChild(_toAttackBtn);
            }
         }
      }
   }
}

