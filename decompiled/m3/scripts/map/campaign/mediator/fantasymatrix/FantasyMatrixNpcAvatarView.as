package map.campaign.mediator.fantasymatrix
{
   import avatar.data.AvatarStaticData;
   import avatar.view.HeroAvatar;
   import avatar.view.HumanAvatar;
   import avatar.view.SimpleAvatarView;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.FantasyMatrixNodeInfo;
   import map.internals.view.hero.HeroAvatarView;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.ai.NpcAiInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.manager.CursorManagerII;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class FantasyMatrixNpcAvatarView extends HeroAvatarView
   {
      
      private var _attackView:SimpleAvatarView;
      
      private var hasSetHitArea:Boolean = false;
      
      private var _nodeInfo:FantasyMatrixNodeInfo;
      
      public var showNamePosY:int = -110;
      
      public function FantasyMatrixNpcAvatarView()
      {
         super();
         this.mouseEnabled = false;
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         super.showName(param1,param2,param3,param4,param5);
         _npcName.text = param1;
         if(param2 > 0)
         {
            _npcName.appendText(" " + LanguageMgr.GetTranslation("public.level2",param2));
         }
         _npcName.setFrame(5);
         _npcName.y = -130;
      }
      
      override public function set info(param1:AIBaseInfo) : void
      {
         super.info = param1;
      }
      
      public function set nodeInfo(param1:FantasyMatrixNodeInfo) : void
      {
         removeEvent();
         _nodeInfo = param1;
         refreshAvatarView();
         updateNpcView();
         addEvent();
      }
      
      public function get nodeInfo() : FantasyMatrixNodeInfo
      {
         return _nodeInfo;
      }
      
      protected function refreshAvatarView() : void
      {
         var _loc2_:PawnTemplate = TempleteManager.instance.pawnTemplateCate.getTemplateByID(nodeInfo.pawnTempId);
         if(!_loc2_)
         {
            return;
         }
         avatarView = new HeroAvatar(true,nodeInfo.pawnSonType.toString(),2,0,true);
         avatarView.noShadow = true;
         updateDirection(90);
         showName(_loc2_.Name,nodeInfo.pawnLevel,0,0,5);
         var _loc3_:String = PathManager.getAvatarResourcePath(nodeInfo.pawnSonType.toString(),-1,1,"body",-1,2);
         var _loc1_:Object = createResourceLoadInfo(_loc3_,AvatarStaticData.getBaseNumByType("Stand","body"),AvatarStaticData.getBaseNumByType("Walk","body"),"body");
         LoaderManagerII.instance.load(_loc3_,4,7,loaderCompleteHandler,null,null,_loc1_);
      }
      
      override protected function addEvent() : void
      {
         if(nodeInfo && _avatar)
         {
            _avatar.addEventListener("mouseMove",__mouseMoveHandler);
            _avatar.addEventListener("rollOut",__mouseOutHandler);
            _avatar.addEventListener("click",__mouseClickHandler);
         }
      }
      
      override protected function removeEvent() : void
      {
         if(_avatar)
         {
            _avatar.removeEventListener("mouseMove",__mouseMoveHandler);
            _avatar.removeEventListener("rollOut",__mouseOutHandler);
            _avatar.removeEventListener("click",__mouseClickHandler);
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         displayVisible = param1;
      }
      
      public function updateNpcView() : void
      {
         removeFireView();
         var _loc1_:PawnTemplate = TempleteManager.instance.pawnTemplateCate.getTemplateByID(nodeInfo.pawnTempId);
         if(_loc1_)
         {
            showName(_loc1_.Name,nodeInfo.pawnLevel,0,0,5);
         }
         switch(int(nodeInfo.state))
         {
            case 0:
            case 2:
               _info.isLiving = false;
               this.visible = false;
               break;
            case 1:
               _info.isLiving = true;
               this.visible = true;
               if(nodeInfo.isFighting)
               {
                  setFireView();
               }
               break;
            default:
               _info.isLiving = true;
               this.visible = true;
               if(nodeInfo.isFighting)
               {
                  setFireView();
               }
         }
      }
      
      private function setFireView() : void
      {
         if(!_attackView)
         {
            _attackView = new SimpleAvatarView(110,110,PathManager.fightStatePath,10);
         }
         _attackView.scaleX = _attackView.scaleY = 0.6;
         _attackView.drawFrame = 2;
         addChild(_attackView);
         _attackView.x = -55;
         _attackView.y = -150;
      }
      
      private function set displayVisible(param1:Boolean) : void
      {
         if(param1)
         {
            if(_avatar)
            {
               addChild(_avatar);
            }
            if(_npcName)
            {
               addChild(_npcName);
            }
         }
         else
         {
            if(_avatar && _avatar.parent)
            {
               _avatar.parent.removeChild(_avatar);
            }
            if(_npcName && _npcName.parent)
            {
               _npcName.parent.removeChild(_npcName);
            }
         }
      }
      
      private function removeFireView() : void
      {
         if(_attackView)
         {
            ObjectUtils.disposeObject(_attackView);
         }
         _attackView = null;
      }
      
      override public function execute() : void
      {
         super.execute();
         if(_avatar)
         {
            _avatar.state = 3;
         }
         if(_attackView && nodeInfo.isFighting)
         {
            _attackView.draw();
         }
         if(!hasSetHitArea && _avatar && _avatar.contentBitmap && _avatar.contentBitmap.bitmapData)
         {
            setHitArea();
            hasSetHitArea = true;
         }
      }
      
      override protected function nextWalk(param1:Point) : void
      {
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         standImp();
         npcAiInfo.moveState = 3;
      }
      
      override protected function loaderCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(_avatar)
         {
            (_avatar as HumanAvatar).loaderCompleteHandler(param1.args as ResourceLoaderInfo,param2);
            hasSetHitArea = false;
         }
         if(param1.url.indexOf("body") >= 0 || param1.url.indexOf("npc") >= 0)
         {
            layouTextView(param1.url);
         }
      }
      
      private function setHitArea() : void
      {
         var _loc2_:Sprite = null;
         if(!_avatar || !_avatar.contentBitmap)
         {
            return;
         }
         var _loc1_:BitmapData = new BitmapData(_avatar.contentBitmap.width,_avatar.contentBitmap.height,true,0);
         _loc1_.draw(_avatar.contentBitmap);
         _loc2_ = DisplayUtils.getHitArea(_loc1_,5);
         _loc2_.x = _avatar.contentBitmap.x;
         _loc2_.y = _avatar.contentBitmap.y;
         _avatar.hitArea = _loc2_;
         _avatar.addChild(_loc2_);
         _avatar.mouseChildren = false;
      }
      
      private function layouTextView(param1:String) : void
      {
         if(!_npcName)
         {
            return;
         }
         var _loc2_:Object = LoaderHeaderList.avatarShowNamePos[param1];
         if(_loc2_)
         {
            if(_loc2_.showNamePosY)
            {
               showNamePosY = _loc2_.showNamePosY;
            }
            if(_loc2_.hasOwnProperty("noShadow"))
            {
               _avatar.noShadow = true;
            }
            if(_loc2_.hasOwnProperty("curTotalFrameX"))
            {
               _avatar.curTotalFrameX = _loc2_.curTotalFrameX;
            }
         }
         _npcName.y = showNamePosY + 20;
         _avatar.scaleX = _avatar.scaleY = 0.8;
         NotificationManager.instance.sendNotification("NPC_LOAD_COMPLETE",this);
      }
      
      public function get npcAiInfo() : NpcAiInfo
      {
         return _info as NpcAiInfo;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         removeFireView();
         removeEvent();
         super.dispose();
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:uint = uint(getCurrentPixels());
         if(_loc2_ > 50)
         {
            if(nodeInfo.isFighting)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("fantasyMatrix.FantasyMatrixNpcAvatarView.fightAlert"));
               return;
            }
            CampaignSocketOutManager.instance.sendFantasyMatrixFight(nodeInfo.posX,nodeInfo.posY);
         }
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         if(_avatar)
         {
            if(!param1)
            {
               _filter.setGlowFilter(_avatar.contentBitmap);
               if(!nodeInfo.isFighting && CursorManagerII.instance.currentState != "ATTACK_CURSOR")
               {
                  CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
                  return;
               }
            }
            else if((_avatar as HumanAvatar).getCurrentPixels() > 50)
            {
               _filter.setGlowFilter(_avatar.contentBitmap);
               if(!nodeInfo.isFighting && CursorManagerII.instance.currentState != "ATTACK_CURSOR")
               {
                  CursorManagerII.instance.showCursorByType("ATTACK_CURSOR");
                  return;
               }
            }
            else
            {
               _filter.setNormalFilter(_avatar.contentBitmap);
            }
            CursorManagerII.instance.showCursorByType("DEFAULT_CURSOR");
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _filter.setNormalFilter(_avatar.contentBitmap);
         CursorManagerII.instance.resetCursor();
      }
   }
}

