package bag.helper
{
   import bag.events.BagEvent;
   import bag.view.BaseBagListView;
   import bag.view.SpliteItemFrame;
   import cell.view.bag.BaseBagCell;
   import cell.view.playerequip.HonorCell;
   import cell.view.playerequip.PlayerEquipCell;
   import cell.view.starbag.StarBagCell;
   import cell.view.storebag.StoreJewelCell;
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mainBar.vicePassword.VicePasswordUtil;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.controler.ConsortiaControler;
   import mvc.module.armyII.ArmyModel;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.events.NotificationEvent;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManager;
   import yishi.manager.StarManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class BagHelper extends EventDispatcher
   {
      
      private static var _instance:BagHelper;
      
      public var isSelling:Boolean;
      
      public var isVpLock:Boolean = false;
      
      private var callBack:Function;
      
      public function BagHelper()
      {
         super();
      }
      
      public static function get instance() : BagHelper
      {
         if(!_instance)
         {
            _instance = new BagHelper();
         }
         return _instance;
      }
      
      public static function checkCanUseGoods(param1:int) : Boolean
      {
         switch(param1)
         {
            case 201:
            case 203:
            case 206:
            case 209:
            case 211:
            case 298:
            case 213:
            case 289:
            case 294:
            case 217:
            case 218:
            case 302:
            case 306:
            case 308:
            case 311:
            case 219:
            case 313:
            case 314:
            case 315:
            case 316:
            case 600:
            case 320:
            case 322:
            case 221:
            case 331:
            case 601:
            case 292:
            case 222:
            case 278:
            case 622:
            case 602:
            case 606:
            case 603:
            case 604:
            case 226:
            case 296:
            case 201:
            case 237:
            case 399:
            case 340:
            case 607:
            case 608:
            case 609:
            case 280:
            case 282:
            case 277:
            case 621:
            case 624:
            case 625:
            case 626:
            case 800:
            case 801:
            case 510:
            case 710:
               break;
            default:
               return false;
         }
         return true;
      }
      
      public static function checkCanUseGoods2(param1:int) : Boolean
      {
         switch(param1)
         {
            case 2100038:
            case 3101011:
            case 3101021:
            case 3101031:
            case 3101041:
            case 208001:
            case 208044:
            case 208009:
               break;
            default:
               return false;
         }
         return true;
      }
      
      public static function checkisOnlyMove(param1:int) : Boolean
      {
         switch(param1)
         {
            case 317:
            case 202:
            case 204:
            case 207:
            case 205:
            case 228:
            case 208:
            case 210:
            case 299:
            case 211:
            case 212:
            case 214:
            case 297:
            case 215:
            case 296:
            case 295:
            case 293:
            case 216:
            case 290:
            case 279:
            case 307:
            case 303:
            case 304:
            case 310:
            case 312:
            case 319:
            case 321:
            case 318:
            case 323:
            case 324:
            case 325:
            case 326:
            case 327:
            case 328:
            case 329:
            case 343:
            case 344:
            case 605:
            case 605:
            case 605:
            case 227:
            case 223:
            case 224:
            case 225:
            case 236:
            case 234:
            case 238:
            case 619:
            case 620:
            case 283:
            case 281:
            case 276:
            case 693:
            case 623:
            case 398:
            case 760:
            case 761:
            case 762:
            case 763:
            case 1000:
            case 1001:
               break;
            default:
               return false;
         }
         return true;
      }
      
      public function stopSelling() : void
      {
         isSelling = false;
         CursorManagerII.instance.resetCursor();
         StageReferance.stage.removeEventListener("click",__sellClickHandler,true);
         StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
         StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
      }
      
      public function onSellButtonClickHandler(param1:Object) : void
      {
         if(!isSelling)
         {
            CursorManagerII.instance.showCursorByType("SELL_CIRSOR");
            isSelling = !isSelling;
            StageReferance.stage.addEventListener("click",__sellClickHandler,true);
            StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
         }
         else
         {
            CursorManagerII.instance.resetCursor();
            isSelling = !isSelling;
            StageReferance.stage.removeEventListener("click",__sellClickHandler,true);
            StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
         }
      }
      
      public function vpLockBtnClickHandler(param1:Object) : void
      {
         if(!isVpLock)
         {
            CursorManagerII.instance.showCursorByType("VICE_PASSWORD_LOCK");
            isVpLock = !isVpLock;
            StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
            StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
         }
         else
         {
            CursorManagerII.instance.resetCursor();
            isVpLock = !isVpLock;
            StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
            StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
         }
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get model() : ArmyModel
      {
         return control.model;
      }
      
      protected function __vpLockClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:BaseBagCell = null;
         var _loc4_:PlayerEquipCell = null;
         var _loc3_:StarBagCell = null;
         var _loc2_:String = "";
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         var _loc5_:Array = StageReferance.stage.getObjectsUnderPoint(new Point(param1.stageX,param1.stageY));
         _loc5_.pop();
         var _loc7_:DisplayObject = _loc5_.pop();
         if(MessageTipManager.instance().enable)
         {
            _loc7_ = _loc5_.pop();
         }
         while(_loc7_)
         {
            if(_loc7_ && _loc7_ is SelectedIconButton && (_loc7_.x > 350 || inConsortiaCase))
            {
               StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
               StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
               (_loc7_ as SelectedIconButton).dispatchEvent(new MouseEvent("click"));
               StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
               StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
               return;
            }
            _loc6_ = _loc7_ as BaseBagCell;
            if(_loc6_ && _loc6_.data)
            {
               CursorManagerII.instance.resetCursor();
               StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
               StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
               if(model.selectedStroeBag)
               {
                  VicePasswordUtil.vpLockOp(5,_loc6_.data.pos);
               }
               else if(_loc6_.bagType == 401)
               {
                  VicePasswordUtil.vpLockOp(7,_loc6_.data.pos);
               }
               else
               {
                  VicePasswordUtil.vpLockOp(1,_loc6_.data.pos);
               }
               isVpLock = true;
               CursorManagerII.instance.showCursorByType("VICE_PASSWORD_LOCK");
               StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
               StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
               return;
            }
            if(_loc7_ is PlayerEquipCell)
            {
               _loc4_ = _loc7_ as PlayerEquipCell;
               if(_loc4_ && _loc4_.data)
               {
                  CursorManagerII.instance.resetCursor();
                  StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
                  if(_loc7_ is HonorCell)
                  {
                     VicePasswordUtil.vpLockOp(4,_loc4_.data.pos);
                  }
                  else
                  {
                     VicePasswordUtil.vpLockOp(3,_loc4_.data.pos);
                  }
                  isVpLock = true;
                  CursorManagerII.instance.showCursorByType("VICE_PASSWORD_LOCK");
                  StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
            }
            if(_loc7_ is StarBagCell)
            {
               _loc3_ = _loc7_ as StarBagCell;
               if(_loc3_ && _loc3_.data)
               {
                  CursorManagerII.instance.resetCursor();
                  StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
                  StarManager.instance.sendStarComposeLock(_loc3_.data.bagType,_loc3_.data.pos);
                  isVpLock = true;
                  CursorManagerII.instance.showCursorByType("VICE_PASSWORD_LOCK");
                  StageReferance.stage.addEventListener("click",__vpLockClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
            }
            _loc7_ = _loc7_.parent;
         }
         isVpLock = false;
         CursorManagerII.instance.resetCursor();
         StageReferance.stage.removeEventListener("click",__vpLockClickHandler,true);
         StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
         StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
      }
      
      private function __sellClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:BaseBagCell = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc8_:* = null;
         var _loc2_:String = "";
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         var _loc5_:Array = StageReferance.stage.getObjectsUnderPoint(new Point(param1.stageX,param1.stageY));
         _loc5_.pop();
         var _loc7_:DisplayObject = _loc5_.pop();
         if(MessageTipManager.instance().enable)
         {
            _loc7_ = _loc5_.pop();
         }
         while(_loc7_)
         {
            if(_loc7_ && _loc7_ is SelectedIconButton && (_loc7_.x > 350 || inConsortiaCase))
            {
               StageReferance.stage.removeEventListener("click",__sellClickHandler,true);
               StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
               (_loc7_ as SelectedIconButton).dispatchEvent(new MouseEvent("click"));
               StageReferance.stage.addEventListener("click",__sellClickHandler,true);
               StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
               return;
            }
            _loc6_ = _loc7_ as BaseBagCell;
            if(_loc6_ && _loc6_.data)
            {
               CursorManagerII.instance.resetCursor();
               StageReferance.stage.removeEventListener("click",__sellClickHandler,true);
               StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
               _loc3_ = GoodsCheck.getSellGold(_loc6_.data) * _loc6_.data.count;
               if(_loc3_ == 0)
               {
                  isSelling = false;
                  _loc2_ = LanguageMgr.GetTranslation("bag.helper.BagHelper.command01");
                  MessageTipManager.instance().show(_loc2_);
                  CursorManagerII.instance.showCursorByType("SELL_CIRSOR");
                  StageReferance.stage.addEventListener("click",__sellClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
               if(_loc6_.data.existJewel())
               {
                  isSelling = false;
                  if(_loc6_.data.templateInfo.SonType >= 113 && _loc6_.data.templateInfo.SonType <= 116)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("bag.helper.BagHelper.command03");
                  }
                  else
                  {
                     _loc2_ = LanguageMgr.GetTranslation("bag.helper.BagHelper.command02");
                  }
                  MessageTipManager.instance().show(_loc2_);
                  CursorManagerII.instance.showCursorByType("SELL_CIRSOR");
                  StageReferance.stage.addEventListener("click",__sellClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
               if(_loc6_.data.isLock)
               {
                  isSelling = false;
                  _loc4_ = LanguageMgr.GetTranslation("vicepassword.description2");
                  MessageTipManager.instance().show(_loc4_);
                  CursorManagerII.instance.showCursorByType("SELL_CIRSOR");
                  StageReferance.stage.addEventListener("click",__sellClickHandler,true);
                  StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
                  StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
                  return;
               }
               isSelling = true;
               dispatchEvent(new BagEvent("SELL_GOODS",_loc6_.data));
               CursorManagerII.instance.showCursorByType("SELL_CIRSOR");
               StageReferance.stage.addEventListener("click",__sellClickHandler,true);
               StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
               return;
            }
            _loc7_ = _loc7_.parent;
         }
         isSelling = false;
         CursorManagerII.instance.resetCursor();
         StageReferance.stage.removeEventListener("click",__sellClickHandler,true);
         StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
         StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
      }
      
      private function __alertResponse(param1:Boolean, param2:Object) : void
      {
         CursorManagerII.instance.showCursorByType("SELL_CIRSOR");
         StageReferance.stage.addEventListener("click",__sellClickHandler,true);
         StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
         StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
         if(param1)
         {
            if(param2.data)
            {
               sendSellItem(param2.data.pos);
            }
         }
      }
      
      public function __onMouseDownHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      public function __onMouseUpHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("asset.core.cursor.SpliteIconAsset");
         _loc1_.mouseEnabled = _loc1_.mouseChildren = true;
         return _loc1_;
      }
      
      public function onSplitHandler(param1:Object) : void
      {
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(param1,{"icon":_loc3_});
         _loc2_.dropChecks = [BaseBagCell,Stage];
         _loc2_.onDrop = onSpliteDrop;
         CursorManagerII.instance.hide();
      }
      
      private function onSpliteDrop(param1:GameDrag) : void
      {
         var _loc3_:SpliteItemFrame = null;
         param1.stopImmediatePropagation();
         CursorManagerII.instance.show();
         var _loc2_:BaseBagCell = param1.dropTarget as BaseBagCell;
         if(!_loc2_ || !_loc2_.icon.content)
         {
            return;
         }
         if(_loc2_.data && _loc2_.data.templateInfo.MaxCount > 1 && _loc2_.data.count > 1)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("core.SpliteItemFrame");
            _loc3_.data = _loc2_;
            _loc3_.show();
         }
      }
      
      public function onTidyHandler(param1:BaseBagListView, param2:int = 0) : void
      {
         var _loc5_:Date = null;
         var _loc8_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc6_:Boolean = true;
         var _loc3_:Date = SharedManager.instance.domesticateAlertDate;
         if(_loc3_)
         {
            _loc5_ = new Date();
            if(_loc5_.fullYear == _loc3_.fullYear && _loc5_.month == _loc3_.month && _loc5_.date == _loc3_.date)
            {
               _loc6_ = false;
            }
         }
         armyModel.currentBag = param1;
         armyModel.currentSortType = param2;
         if(_loc6_)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
            _loc7_ = LanguageMgr.GetTranslation("bag.helper.BagHelper.content02");
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc4_,__todayNotAlertTidy,null,"center",2,true);
         }
         else
         {
            tidyBag();
         }
      }
      
      private function __todayNotAlertTidy(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.domesticateAlertDate = new Date();
            SharedManager.instance.saveDomesticateAlert();
         }
         tidyBag();
      }
      
      private function tidyBag() : void
      {
         armyModel.currentBag.sort(true,armyModel.currentSortType);
         if(armyModel.currentBag.currentBagType == 6)
         {
            return;
         }
         NotificationManager.instance.sendNotification("BAG_SORT_CHANGE",armyModel.currentSortType);
      }
      
      private function get armyModel() : ArmyModel
      {
         return FrameControllerManager.instance.armyController.model;
      }
      
      public function removeJewel() : void
      {
         if(!isSelling)
         {
            CursorManagerII.instance.showCursorByType("REMOVE_CURSOR_UP");
            isSelling = !isSelling;
            StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
            StageReferance.stage.addEventListener("click",__clickHandler,true);
         }
         else
         {
            CursorManagerII.instance.resetCursor();
            isSelling = !isSelling;
            StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
            StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
            StageReferance.stage.removeEventListener("click",__clickHandler,true);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc5_:StoreJewelCell = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         param1.stopImmediatePropagation();
         param1.stopPropagation();
         var _loc4_:Array = StageReferance.stage.getObjectsUnderPoint(new Point(param1.stageX,param1.stageY));
         var _loc6_:DisplayObject = _loc4_.pop();
         if(MessageTipManager.instance().enable)
         {
            _loc6_ = _loc4_.pop();
         }
         while(_loc6_)
         {
            _loc5_ = _loc6_ as StoreJewelCell;
            if(_loc5_ && _loc5_.data)
            {
               StageReferance.stage.removeEventListener("click",__clickHandler,true);
               StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
               StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
               CursorManagerII.instance.resetCursor();
               SimpleAlertHelper.instance.data = [__removeJewelCallBack,_loc5_.pos,_loc5_.data.templateInfo.Property3];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc7_ = LanguageMgr.GetTranslation("public.prompt");
               _loc8_ = LanguageMgr.GetTranslation("bag.helper.BagHelper.content03",_loc5_.data.templateInfo.Property3);
               SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc2_,_loc3_);
               return;
            }
            _loc6_ = _loc6_.parent;
         }
         isSelling = false;
         CursorManagerII.instance.resetCursor();
         StageReferance.stage.removeEventListener("mouseDown",__onMouseDownHandler,true);
         StageReferance.stage.removeEventListener("mouseUp",__onMouseUpHandler,true);
         StageReferance.stage.removeEventListener("click",__clickHandler,true);
      }
      
      private function __removeJewelCallBack(param1:Boolean, param2:Boolean, param3:int, param4:Number) : void
      {
         if(isSelling)
         {
            CursorManagerII.instance.showCursorByType("REMOVE_CURSOR_UP");
         }
         else
         {
            CursorManagerII.instance.resetCursor();
         }
         StageReferance.stage.addEventListener("click",__clickHandler,true);
         StageReferance.stage.addEventListener("mouseDown",__onMouseDownHandler,true);
         StageReferance.stage.addEventListener("mouseUp",__onMouseUpHandler,true);
         if(param1)
         {
            if(param4 > goldResource.count)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.gold"));
               return;
            }
            sendPunch(param3,false);
         }
      }
      
      private function get goldResource() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      public function canSplite(param1:GoodsInfo) : Boolean
      {
         if(param1.count > 1)
         {
            return true;
         }
         return false;
      }
      
      public function checkCanMulUse(param1:GoodsInfo) : Boolean
      {
         return param1.count >= 1 ? true : false;
      }
      
      public function playNewGoodsEffect(param1:GoodsInfo, param2:Function = null) : void
      {
         callBack = param2;
         var _loc3_:BaseIconView = ComponentFactory.Instance.creatCustomObject("core.BaseIcon",[iconComplete]);
         if(_loc3_.isDie)
         {
            return;
         }
         _loc3_.icon = IconFactory.getGoodsIconByTID(param1.templateId);
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            if(param1)
            {
               param1.dispose();
            }
            param1 = null;
            return;
         }
         var _loc2_:MovieClip = ComponentFactory.Instance.creatCustomObject("core.GetGoodsEffect");
         _loc2_.gotoAndStop(1);
         _loc2_["contain"].addChild(param1);
         _loc2_.x = StageReferance.stageWidth / 2;
         _loc2_.y = StageReferance.stageHeight / 2;
         _loc2_.gotoAndPlay(1);
         StageReferance.stage.addChild(_loc2_);
         _loc2_.addEventListener("complete",__complete);
      }
      
      private function __complete(param1:Event) : void
      {
         (param1.currentTarget as MovieClip).removeEventListener("complete",__complete);
         var _loc4_:BaseIconView = param1.currentTarget["contain"].getChildAt(0) as BaseIconView;
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            if(_loc4_)
            {
               _loc4_.dispose();
            }
            _loc4_ = null;
            return;
         }
         var _loc5_:Point = _loc4_.parent.localToGlobal(new Point(_loc4_.x,_loc4_.y));
         _loc4_.x = _loc5_.x;
         _loc4_.y = _loc5_.y;
         _loc4_.mouseChildren = _loc4_.mouseEnabled = false;
         StageReferance.stage.addChild(_loc4_);
         ObjectUtils.disposeObject(param1.currentTarget);
         var _loc2_:DisplayObject = MainToolBar.instance.getButtnByType(2) as DisplayObject;
         var _loc3_:Point = _loc2_.parent.localToGlobal(new Point(_loc2_.getBounds(_loc2_.parent).x,_loc2_.getBounds(_loc2_.parent).y));
         TweenMax.to(_loc4_,2,{
            "bezierThrough":[{
               "x":_loc5_.x + 200,
               "y":_loc5_.y
            },{
               "x":_loc3_.x,
               "y":_loc3_.y
            }],
            "scaleX":0.6,
            "scaleY":0.6,
            "orientToBezier":false,
            "ease":Quart.easeOut,
            "onComplete":_moveComplete,
            "onCompleteParams":[_loc4_]
         });
      }
      
      private function _moveComplete(param1:BaseIconView) : void
      {
         TweenMax.to(param1,0.5,{
            "alpha":0,
            "onComplete":disapearComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function disapearComplete(param1:BaseIconView) : void
      {
         if(callBack != null)
         {
            callBack();
         }
         callBack = null;
         ObjectUtils.disposeObject(param1);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function sendSellItem(param1:int) : void
      {
         SocketSendManager.instance.sendSellItem(param1);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("BEHAVIOR_ANALYSIS",param1));
      }
      
      private function get armyControl() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get consortiaController() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      private function get inConsortiaCase() : Boolean
      {
         return consortiaController && !consortiaController.frameIsDie;
      }
      
      public function sendPunch(param1:int, param2:Boolean) : void
      {
         SocketSendManager.instance.sendPunch(param1,param2);
      }
   }
}

