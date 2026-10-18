package mediators
{
   import cell.view.playerequip.PlayerEquipCell;
   import cell.view.storebag.StoreIntensifyCell;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import utils.NewbieUtils;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tools.BaseMovie;
   
   public class NewbieSpecialActionMediator
   {
      
      public function NewbieSpecialActionMediator()
      {
         super();
      }
      
      private static function tweenCompleteCall(param1:Object, param2:Boolean, param3:Function, param4:Array) : void
      {
         TweenMax.killTweensOf(param1);
         if(param2)
         {
            ObjectUtils.disposeObject(param1);
            param1 = null;
         }
         NewbieUtils.execFunc(param3,param4);
      }
      
      public static function getWorldMapMovie(param1:Function, param2:Array) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:Frame = FrameControllerManager.instance.worldMapController.frame;
         var _loc5_:SimpleButton = _loc4_["mapAreaContainer"].movie["map1"];
         _loc3_ = ComponentFactory.Instance.creatCustomObject("novice.NoviceWorld");
         _loc3_.x = 298;
         _loc3_.y = 438;
         _loc4_["addChild"](_loc3_);
         NewbieUtils.execFunc(param1,param2);
      }
      
      public static function weaponEquipGuild(param1:Function, param2:Array) : void
      {
         var flag:int;
         var weaponItem:PlayerEquipCell;
         var itemView:BaseItemView;
         var callback:Function = param1;
         var callArgs:Array = param2;
         var gotoGoodsItem:* = function():void
         {
            flag = 1;
            itemView = bagFrame["equipBag"].getBaseBagItemByType(101);
            if(!itemView)
            {
               NewbieBaseActionMediator.setKeyboardState(null,null,"1",2);
               NewbieUtils.execFunc(callback,callArgs);
               return;
            }
            bagFrame["equipBag"].addChild(itemView);
            NewbieBaseActionMediator.cleanAll();
            NewbieBaseActionMediator.showMask();
            NewbieBaseActionMediator.createGuildFrame1("",-144,7,4201,"1",4,0,0,itemView);
            NewbieBaseActionMediator.drawTargetOnMask(null,null,"","1",-1,0,0,null,itemView);
            StageReferance.stage.addEventListener("enterFrame",pawnEnterFrame);
         };
         var gotoPlayItem:* = function():void
         {
            flag = 2;
            if(bagFrame)
            {
               bagFrame.escEnable = false;
            }
            NewbieBaseActionMediator.cleanAll();
            NewbieBaseActionMediator.createGuildFrame1("",-155,5,4202,"0",4,0,0,weaponItem);
         };
         var pawnEnterFrame:* = function(param1:Event):void
         {
            if(weaponItem.data)
            {
               StageReferance.stage.removeEventListener("enterFrame",pawnEnterFrame);
               NewbieBaseActionMediator.cleanAll();
               StageReferance.stage.addEventListener("enterFrame",closeBagFrame);
               return;
            }
            if(DragManager.getInstance().isDraging && flag == 1)
            {
               gotoPlayItem();
            }
            else if(DragManager.getInstance().isDraging == false && flag == 1)
            {
               if(!itemView.data)
               {
                  StageReferance.stage.removeEventListener("enterFrame",pawnEnterFrame);
                  gotoGoodsItem();
               }
            }
            else if(DragManager.getInstance().isDraging == false && flag == 2)
            {
               StageReferance.stage.removeEventListener("enterFrame",pawnEnterFrame);
               gotoGoodsItem();
            }
         };
         var closeBagFrame:* = function(param1:Event):void
         {
            if(!bagFrame || !bagFrame["closeButton"])
            {
               StageReferance.stage.removeEventListener("enterFrame",closeBagFrame);
               NewbieBaseActionMediator.setKeyboardState(null,null,"1",2);
               NewbieBaseActionMediator.cleanAll();
               NewbieUtils.execFunc(callback,callArgs);
            }
         };
         var bagFrame:Frame = FrameControllerManager.instance.armyController.frame;
         bagFrame["equipBag"].showEffectBySontype(292);
         flag = 0;
         weaponItem = bagFrame["heroEquip"].weapon;
         itemView = bagFrame["equipBag"].getBaseBagItemByType(101);
         if(!itemView)
         {
            NewbieUtils.execFunc(callback,callArgs);
            return;
         }
         NewbieBaseActionMediator.setKeyboardState(null,null,"0",1);
         gotoGoodsItem();
      }
      
      public static function pawnAllocateGuild(param1:Function, param2:Array) : void
      {
         var gongPawnCell:BaseIconView;
         var soldierPawnCell:DisplayObject;
         var callback:Function = param1;
         var callArgs:Array = param2;
         var iconFrame:* = function(param1:Event):void
         {
            if(allocateFrame == null || allocateFrame["allocateView"] == null)
            {
               NewbieBaseActionMediator.setKeyboardState(null,null,"1",2);
               NewbieUtils.execFunc(callback,callArgs);
               return;
            }
            if(allocateFrame["allocateView"].getPawnDragCellByMasterType(1) == null || allocateFrame["allocateView"].getPawnDragCellByMasterType(1)["icon"] == null)
            {
               NewbieBaseActionMediator.setKeyboardState(null,null,"1",2);
               NewbieUtils.execFunc(callback,callArgs);
               return;
            }
            gongPawnCell = allocateFrame["allocateView"].getPawnDragCellByMasterType(1)["icon"];
            if(gongPawnCell.displayWidth > 50 && gongPawnCell.stage)
            {
               soldierPawnCell = allocateFrame["allocateView"].SoldierPawn;
               StageReferance.stage.removeEventListener("enterFrame",iconFrame);
               pawnBtnClick();
            }
         };
         var pawnBtnClick:* = function():void
         {
            flag = 1;
            NewbieBaseActionMediator.cleanAll();
            NewbieBaseActionMediator.showMask();
            NewbieBaseActionMediator.createGuildFrame1("",-171,20,4301,"1",4,0,0,gongPawnCell);
            NewbieBaseActionMediator.drawTargetOnMask(null,null,"","1",-1,0,0,null,gongPawnCell);
            StageReferance.stage.addEventListener("enterFrame",pawnEnterFrame);
         };
         var gotoSoldierPawn:* = function():void
         {
            flag = 2;
            if(allocateFrame)
            {
               allocateFrame.escEnable = false;
            }
            NewbieBaseActionMediator.cleanAll();
            NewbieBaseActionMediator.createGuildFrame1("",-135,60,4302,"1",4,0,0,soldierPawnCell);
         };
         var pawnEnterFrame:* = function(param1:Event):void
         {
            var _loc2_:int = int(ArmyManager.instance.army.countAllArmyPawnNmber());
            if(_loc2_ > 0)
            {
               StageReferance.stage.removeEventListener("enterFrame",pawnEnterFrame);
               NewbieBaseActionMediator.setKeyboardState(null,null,"1",2);
               NewbieBaseActionMediator.cleanAll();
               allocateFrame.dispose();
               NewbieUtils.execFunc(callback,callArgs);
               return;
            }
            if(DragManager.getInstance().isDraging && flag == 1)
            {
               gotoSoldierPawn();
            }
            else if(DragManager.getInstance().isDraging == false && flag == 2)
            {
               if(!FrameControllerManager.instance.armyController.isAdjustPawn)
               {
                  StageReferance.stage.removeEventListener("enterFrame",pawnEnterFrame);
                  if(!gongPawnCell || !gongPawnCell.stage)
                  {
                     NewbieBaseActionMediator.setKeyboardState(null,null,"1",2);
                     NewbieBaseActionMediator.cleanAll();
                     allocateFrame.dispose();
                     NewbieUtils.execFunc(callback,callArgs);
                     return;
                  }
                  pawnBtnClick();
               }
               else
               {
                  NewbieBaseActionMediator.cleanAll();
               }
            }
         };
         var flag:int = 0;
         var allocateFrame:Frame = FrameControllerManager.instance.armyController.frame;
         var prevNumber:int = int(ArmyManager.instance.army.countAllArmyPawnNmber());
         if(prevNumber > 0)
         {
            allocateFrame.dispose();
            NewbieUtils.execFunc(callback,callArgs);
            return;
         }
         NewbieBaseActionMediator.setKeyboardState(null,null,"0",1);
         StageReferance.stage.addEventListener("enterFrame",iconFrame);
      }
      
      public static function weaponIntensifyGuild(param1:Function, param2:Array) : void
      {
         var flag:int;
         var callback:Function = param1;
         var callArgs:Array = param2;
         var __storeFrame:* = function(param1:Event):void
         {
            if(!storeFrame || !storeFrame["intensifyView"])
            {
               StageReferance.stage.removeEventListener("enterFrame",__storeFrame);
               NewbieBaseActionMediator.setKeyboardState(null,null,"1",2);
               NewbieUtils.execFunc(callback,callArgs);
               return;
            }
            if(flag == 0)
            {
               setFlag(1);
            }
            if(DragManager.getInstance().isDraging == true && flag == 1)
            {
               setFlag(2);
            }
            if(DragManager.getInstance().isDraging == false && flag == 2 && !storeFrame["intensifyView"].equip1.data)
            {
               setFlag(1);
            }
            if(storeFrame["intensifyView"].equip1.data)
            {
               StageReferance.stage.removeEventListener("enterFrame",__storeFrame);
               setFlag(3);
            }
         };
         var gotoOneItem:* = function(param1:BaseItemView, param2:int):void
         {
            if(param1.data.strengthenGrade > 1)
            {
               StageReferance.stage.removeEventListener("enterFrame",__storeFrame);
               NewbieBaseActionMediator.setKeyboardState(null,null,"1",2);
               NewbieBaseActionMediator.cleanAll();
               NewbieUtils.execFunc(callback,callArgs);
               return;
            }
            storeFrame["storeBag"].addChild(param1);
            if(param1.y % 48 == 0)
            {
               param1.y += 2;
            }
            NewbieBaseActionMediator.cleanAll();
            NewbieBaseActionMediator.showMask();
            NewbieBaseActionMediator.createGuildFrame1("",-186,6,param2,"1",4,0,0,param1);
            NewbieBaseActionMediator.drawTargetOnMask(null,null,"","1",-1,0,0,null,param1);
         };
         var gotoEquip:* = function():void
         {
            if(storeFrame)
            {
               storeFrame["escEnable"] = false;
            }
            var _loc1_:StoreIntensifyCell = storeFrame["intensifyView"].equip1;
            NewbieBaseActionMediator.cleanAll();
            NewbieBaseActionMediator.createGuildFrame1("",-156,40,4401,"0",4,0,0,_loc1_);
         };
         var gotoIntenBtn:* = function():void
         {
            var btnClick:* = function(param1:MouseEvent):void
            {
               btn.removeEventListener("click",btnClick);
               storeFrame = null;
               NewbieBaseActionMediator.setKeyboardState(null,null,"1",2);
               NewbieBaseActionMediator.cleanAll();
               NewbieUtils.execFunc(callback,callArgs);
            };
            var btn:BaseButton = storeFrame["intensifyView"].intensifyBtn;
            btn.addEventListener("click",btnClick);
            NewbieBaseActionMediator.cleanAll();
            NewbieBaseActionMediator.showMask();
            NewbieBaseActionMediator.createGuildFrame1("",-405,-112,4402,"1",1,0,0,btn);
            NewbieBaseActionMediator.drawTargetOnMask(null,null,"","1",-1,0,0,null,btn);
         };
         var setFlag:* = function(param1:int):void
         {
            var _loc2_:BaseItemView = null;
            if(flag == param1)
            {
               return;
            }
            flag = param1;
            switch(flag - 1)
            {
               case 0:
                  _loc2_ = getWeaponItem(storeFrame["storeBag"].itemList);
                  if(_loc2_ == null)
                  {
                     flag = 0;
                     StageReferance.stage.removeEventListener("enterFrame",__storeFrame);
                     NewbieBaseActionMediator.setKeyboardState(null,null,"1",2);
                     NewbieBaseActionMediator.cleanAll();
                     NewbieUtils.execFunc(callback,callArgs);
                     return;
                  }
                  gotoOneItem(_loc2_,4403);
                  break;
               case 1:
                  gotoEquip();
                  break;
               case 2:
                  gotoIntenBtn();
            }
         };
         var getWeaponItem:* = function(param1:Vector.<BaseItemView>):BaseItemView
         {
            for each(var _loc2_:BaseItemView in param1)
            {
               if(_loc2_.data && _loc2_.data.templateInfo.SonType == 101)
               {
                  return _loc2_;
               }
            }
            return null;
         };
         var storeFrame:Frame = FrameControllerManager.instance.storeController.frame;
         setFlag(1);
         NewbieBaseActionMediator.setKeyboardState(null,null,"0",1);
         StageReferance.stage.addEventListener("enterFrame",__storeFrame);
      }
      
      public static function enterSceneAfterPlayMovie(param1:Function, param2:Array, param3:String, param4:int = 2, param5:int = 0, param6:int = 0) : void
      {
         if(!StringHelper.isNullOrEmpty(param3))
         {
            switch(param3)
            {
               case "jump":
                  playJump(param1,param2,param3,param4);
                  break;
               case "flytovillage":
                  playFlyToVillage(param1,param2,param3,param4);
                  break;
               case "flytocastle":
                  playFlyToCastle(param1,param2,param3,param4);
                  break;
               default:
                  playNormal(param1,param2,param3,param4,param5,param6);
            }
         }
         else
         {
            enterSceneCall(param1,param2,param5,param6);
         }
      }
      
      private static function enterSceneCall(param1:Function, param2:Array, param3:int = 0, param4:int = 0) : void
      {
         if(param3 > 0)
         {
            switch(param3 - 102)
            {
               case 0:
                  NewbieBaseActionMediator.sendNodeArrive(1000211);
                  break;
               case 1:
                  NewbieBaseActionMediator.sendNodeArrive(1000211);
                  CampaignSocketOutManager.instance.sendReturnCampaignRoom(0);
                  break;
               default:
                  NewbieBaseActionMediator.sendEnterScene(param3,param4);
            }
         }
         NewbieUtils.execFunc(param1,param2);
      }
      
      private static function playNormal(param1:Function, param2:Array, param3:String, param4:int = 2, param5:int = 0, param6:int = 0) : void
      {
         var _loc7_:Sprite = CampaignManager.instance.mapView;
         var _loc8_:BaseMovie = new BaseMovie(PathManager.getNewbieMovieByJob(param3,PlayerManager.instance.currentPlayerModel.playerInfo.job),enterSceneCall,[param1,param2,param5,param6]);
         if(_loc7_)
         {
            if(_loc7_["walkLayer"])
            {
               _loc7_["walkLayer"].visible = false;
            }
            _loc7_.addChild(_loc8_);
         }
      }
      
      private static function playJump(param1:Function, param2:Array, param3:String, param4:int = 2) : void
      {
         var callback:Function = param1;
         var callArgs:Array = param2;
         var path:String = param3;
         var showLayer:int = param4;
         var onMoviePlayOver:* = function():void
         {
            if(mapView)
            {
               mapView["isLockMove"] = true;
               NewbieBaseActionMediator.setNPC(0,1370,1390,270);
               mapView["isLockMove"] = false;
               setSelfArmyViewVisible(true);
            }
            enterSceneCall(callback,callArgs);
         };
         var onMoviePlaying:* = function():void
         {
            if(mov.content && mov.content.currentFrame == 1)
            {
               setSelfArmyViewVisible(false);
            }
            if(mapView && mov.content && mov.content["map"])
            {
               mapView.x = mov.content["map"].x;
               mapView.y = mov.content["map"].y;
               mapView.scaleX = mov.content["map"].scaleX;
               mapView.scaleY = mov.content["map"].scaleY;
            }
         };
         var mapView:Sprite = CampaignManager.instance.mapView;
         var mov:BaseMovie = new BaseMovie(PathManager.getNewbieMovieByJob(path,PlayerManager.instance.currentPlayerModel.playerInfo.job),onMoviePlayOver,null,onMoviePlaying);
         LayerManager.Instance.addToLayer(mov,showLayer,false,false);
      }
      
      private static function playFlyToVillage(param1:Function, param2:Array, param3:String, param4:int = 2) : void
      {
         var mapView:Sprite;
         var mov:BaseMovie;
         var callback:Function = param1;
         var callArgs:Array = param2;
         var path:String = param3;
         var showLayer:int = param4;
         var onMoviePlayOver:* = function():void
         {
            var onMoveOver:* = function():void
            {
               NewbieBaseActionMediator.setNPC(0,-1,-1,270);
               NewbieBaseActionMediator.hideMask();
               NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_ENTER_SCENE"));
               enterSceneCall(callback,callArgs);
            };
            if(mapView)
            {
               if(mapView["walkLayer"])
               {
                  mapView["walkLayer"].visible = true;
               }
               mapView["isLockMove"] = true;
               NewbieBaseActionMediator.setNPC(0,1010,750,350);
               mapView["isLockMove"] = false;
            }
            NewbieBaseActionMediator.showMask(0);
            NewbieBaseActionMediator.moveNPC(onMoveOver,null,0,-1,-1,101,60,"1");
         };
         var onMoviePlaying:* = function():void
         {
            if(mov.content && mov.content.currentFrame == 1)
            {
               NewbieBaseActionMediator.showMask(0);
            }
            if(mapView && mov.content && mov.content["map"])
            {
               mapView.x = mov.content["map"].x;
               mapView.y = mov.content["map"].y;
               mapView.scaleX = mov.content["map"].scaleX;
               mapView.scaleY = mov.content["map"].scaleY;
            }
         };
         NewbieBaseActionMediator.showMask(1,2);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_OUT_SCENE"));
         mapView = CampaignManager.instance.mapView as Sprite;
         if(mapView["walkLayer"])
         {
            mapView["walkLayer"].visible = false;
         }
         mov = new BaseMovie(PathManager.getNewbieMovieByJob(path,PlayerManager.instance.currentPlayerModel.playerInfo.job),onMoviePlayOver,null,onMoviePlaying);
         LayerManager.Instance.addToLayer(mov,showLayer,false,false);
      }
      
      private static function playFlyToCastle(param1:Function, param2:Array, param3:String, param4:int = 2) : void
      {
         var mapView:Sprite;
         var mov:BaseMovie;
         var callback:Function = param1;
         var callArgs:Array = param2;
         var path:String = param3;
         var showLayer:int = param4;
         var onMoviePlayOver:* = function():void
         {
            NewbieBaseActionMediator.sendEnterCollectionBattle();
            NewbieBaseActionMediator.hideMask();
            NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_ENTER_SCENE"));
            enterSceneCall(callback,callArgs);
         };
         var onDialogOver:* = function():void
         {
            if(mov)
            {
               mov.dispose();
            }
            else
            {
               onMoviePlayOver();
            }
         };
         var onMoviePlaying:* = function():void
         {
            if(mov.content)
            {
               if(mov.content.currentFrame == 1)
               {
                  NewbieBaseActionMediator.showMask(0);
               }
               if(mov.content.currentFrame == 190)
               {
                  mov.stop();
                  NewbieBaseActionMediator.showDialog(onDialogOver,null,"16");
               }
            }
            if(mapView && mov.content && mov.content["map"])
            {
               mapView.x = mov.content["map"].x;
               mapView.y = mov.content["map"].y;
               mapView.scaleX = mov.content["map"].scaleX;
               mapView.scaleY = mov.content["map"].scaleY;
            }
         };
         NewbieBaseActionMediator.showMask(1,2);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_OUT_SCENE"));
         mapView = BuildingManager.instance.castleMap as Sprite;
         mov = new BaseMovie(PathManager.getNewbieMovieByJob(path,PlayerManager.instance.currentPlayerModel.playerInfo.job),onMoviePlayOver,null,onMoviePlaying);
         LayerManager.Instance.addToLayer(mov,showLayer,false,false);
      }
      
      private static function setSelfArmyViewVisible(param1:Boolean) : void
      {
         var _loc2_:DisplayObject = null;
         if(CampaignManager.instance.controller && CampaignManager.instance.mapModel)
         {
            _loc2_ = CampaignManager.instance.controller.getArmyView(CampaignManager.instance.mapModel.selfMemberData) as DisplayObject;
         }
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
      }
   }
}

