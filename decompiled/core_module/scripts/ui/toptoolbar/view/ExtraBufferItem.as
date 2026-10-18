package ui.toptoolbar.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.controler.BuildingControler;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.card.MagicCardBuffInfo;
   import mvc.module.consortia.ConsortiaTemplete;
   import mvc.module.pvp.TransportBufferInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MagicCardManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   
   public class ExtraBufferItem extends Sprite implements Disposeable, IManualSize
   {
      
      private var _effect:MovieClip;
      
      private var _icon:BaseIconView;
      
      private var _border:Bitmap;
      
      private var _type:int;
      
      private var _delay:uint = 0;
      
      public function ExtraBufferItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("resourceBar.ExtraBuffer.ItemIcon");
         _icon.buttonMode = true;
         _border = ComponentFactory.Instance.creatBitmap("asset.resourceBar.BufferBorder");
         _effect = ComponentFactory.Instance.creatCustomObject("resourceBar.buffer.Effect");
         addChild(_icon);
         addChild(_border);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BuildInfo = null;
         SoundManager.instance.play("022");
         switch(_type)
         {
            case 1:
               if(checkScene())
               {
                  FrameControllerManager.instance.openControllerByInfo("consortia");
               }
               break;
            case 2:
               if(checkScene())
               {
                  _loc2_ = BuildingManager.instance.getBuildingInfoBySonType(501);
                  FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_loc2_),null,_loc2_);
               }
               break;
            case 3:
               if(checkScene())
               {
                  FrameControllerManager.instance.openControllerByInfo("seminarybless");
               }
               break;
            case 4:
               break;
            case 5:
               cancelTransport();
               break;
            case 6:
               break;
            case 21:
               FrameControllerManager.instance.openControllerByInfo("appell");
               break;
            case 20000:
               FrameControllerManager.instance.openControllerByInfo("fashion",1);
         }
      }
      
      private function cancelTransport() : void
      {
         SimpleAlertHelper.instance.data = [cancelTransportBack];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("mainBar.TopToolsBar.TransportCancelTip");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true);
      }
      
      private function cancelTransportBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendCancelTransport();
         }
      }
      
      private function checkScene() : Boolean
      {
         var _loc1_:String = SceneManager.instance.currentType;
         switch(_loc1_)
         {
            case "CASTLE_SCENE":
            case "SPACE_SCENE":
               break;
            default:
               return false;
         }
         return true;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function setData(param1:int, param2:Array) : void
      {
         var _loc11_:Array = null;
         var _loc6_:String = null;
         var _loc9_:int = 0;
         var _loc8_:String = null;
         var _loc15_:String = null;
         var _loc3_:String = null;
         var _loc16_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc7_:Object = {};
         var _loc10_:Object = {};
         var _loc13_:Object = {};
         var _loc12_:Object = {};
         var _loc14_:Object = {};
         var _loc18_:Boolean = false;
         var _loc20_:Array = [];
         _loc20_.push(21);
         _loc20_.push(40003);
         _loc20_.push(20000);
         _loc20_.push(30000);
         _loc20_.push(40001);
         _loc20_.push(40002);
         _loc20_.push(40008);
         _type = param1;
         _icon.icon = ComponentFactory.Instance.creatBitmap("asset.resourceBar.ExtraBufferIcon_" + _type);
         _loc7_["title1"] = LanguageMgr.GetTranslation("yishi.view.resourceBar.ExtraBufferTitle" + _type);
         _loc7_["content1"] = "";
         _loc7_["content2"] = "";
         if(_type == 40002 || _type == 40001)
         {
            _loc7_["isChild"] = true;
         }
         else
         {
            _loc7_["isChild"] = false;
         }
         if(_type == 6)
         {
            _loc7_["content1"] = LanguageMgr.GetTranslation("yishi.view.resourceBar.ExtraBufferContent6",param2[0]);
         }
         else if(_type == 11)
         {
            _loc7_["content1"] = LanguageMgr.GetTranslation("yishi.view.resourceBar.ExtraBufferContent11");
         }
         else if(_type == 30)
         {
            _loc7_["content1"] = LanguageMgr.GetTranslation("yishi.view.resourceBar.ExtraBufferContent30");
         }
         else if(_type == 40008)
         {
            _loc15_ = GodDessManager.instance.model.doubleOpenString;
            _loc3_ = GodDessManager.instance.model.doubleEndString;
            _loc7_["content1"] = LanguageMgr.GetTranslation("yishi.view.resourceBar.ExtraBufferContent40008",_loc15_,_loc3_);
         }
         else if(_loc20_.indexOf(_type) != -1)
         {
            _loc7_["content1"] = param2[0];
         }
         else
         {
            _loc16_ = "";
            _loc4_ = LanguageMgr.GetTranslation("resourceBar.ExtraBufferitem.masterTitle");
            _loc5_ = "";
            for each(var _loc17_:Object in param2)
            {
               if(_loc17_ is ConsortiaTemplete)
               {
                  if((_loc17_ as ConsortiaTemplete).Types < 13)
                  {
                     _loc16_ += (_loc17_ as ConsortiaTemplete).Description + "\n";
                  }
                  else if(hasHighConsortiaSkill && (_loc17_ as ConsortiaTemplete).Types >= 13 && (_loc17_ as ConsortiaTemplete).Types < 22)
                  {
                     _loc7_["title2"] = LanguageMgr.GetTranslation("yishi.view.resourceBar.ExtraBuffer.hightConsortiaTitle");
                     _loc5_ += (_loc17_ as ConsortiaTemplete).Description + "\n";
                  }
                  else if((_loc17_ as ConsortiaTemplete).Types >= 22 && (_loc17_ as ConsortiaTemplete).Types <= 25)
                  {
                     _loc4_ += "\n" + (_loc17_ as ConsortiaTemplete).Description;
                  }
               }
               else if(_loc17_ is BuildInfo)
               {
                  _loc11_ = (_loc17_ as BuildInfo).templeteInfo.Activity.split("+");
                  _loc6_ = _loc11_[0];
                  if((_loc11_[1] as String).indexOf("/") != -1)
                  {
                     _loc11_ = (_loc11_[1] as String).split("/");
                     _loc9_ = int(_loc11_[0]);
                     _loc8_ = "/" + _loc11_[1] + "\n";
                  }
                  else
                  {
                     _loc9_ = int(_loc11_[1]);
                     _loc8_ = "\n";
                  }
                  if(!_loc10_[_loc6_])
                  {
                     _loc10_[_loc6_] = true;
                     _loc13_[_loc6_] = _loc6_;
                     _loc12_[_loc6_] = _loc9_;
                     _loc14_[_loc6_] = _loc8_;
                  }
                  else
                  {
                     var _loc21_:String = _loc6_;
                     var _loc22_:* = _loc12_[_loc21_] + _loc9_;
                     _loc12_[_loc21_] = _loc22_;
                  }
                  if(!_loc18_)
                  {
                     _loc18_ = true;
                  }
               }
               else if(_loc17_ is TransportBufferInfo)
               {
                  _loc22_ = "content1";
                  _loc21_ = _loc7_[_loc22_] + ((_loc17_ as TransportBufferInfo).infoContent + "\n");
                  _loc7_[_loc22_] = _loc21_;
               }
               else if(_loc17_ is MagicCardBuffInfo)
               {
                  _loc21_ = "content1";
                  _loc22_ = _loc7_[_loc21_] + (MagicCardManager.Instance.cardModel.buffContent(_loc17_ as MagicCardBuffInfo) + "\n");
                  _loc7_[_loc21_] = _loc22_;
               }
               else if(_loc17_ == 0)
               {
                  _loc22_ = "content1";
                  _loc21_ = _loc7_[_loc22_] + (LanguageMgr.GetTranslation("yishi.view.resourceBar.ExtraBufferSeminary",playerInfo.seminaryEffect) + "\n");
                  _loc7_[_loc22_] = _loc21_;
               }
               else
               {
                  _loc21_ = "content1";
                  _loc22_ = _loc7_[_loc21_] + ("\n" + LanguageMgr.GetTranslation("yishi.view.resourceBar.ExtraBufferSeminaryTips"));
                  _loc7_[_loc21_] = _loc22_;
               }
            }
         }
         if(_loc18_)
         {
            for(var _loc19_:String in _loc13_)
            {
               _loc7_["content1"] += _loc13_[_loc19_] + "+" + _loc12_[_loc19_] + _loc14_[_loc19_];
            }
         }
         if(_type == 1)
         {
            _loc7_["content1"] = hasConsortiaMasterSkill ? _loc16_ + "\n" + _loc4_ : _loc16_;
            if(hasHighConsortiaSkill)
            {
               _loc7_["content2"] = _loc5_;
            }
         }
         _icon.tipData = _loc7_;
         if(_type == 40002 || _type == 40001)
         {
            addChild(_effect);
            _effect.gotoAndStop(1);
            _effect["content"].addChild(_icon);
            _effect["content"].addChild(_border);
            _delay = setTimeout(timeCallFunc,20000);
         }
      }
      
      private function timeCallFunc() : void
      {
         if(_delay > 0)
         {
            clearTimeout(_delay);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_border)
         {
            addChild(_border);
         }
         if(_effect)
         {
            ObjectUtils.disposeViolentMc(_effect);
         }
         _effect = null;
      }
      
      public function setButtonMode(param1:Boolean) : void
      {
         buttonMode = param1;
         if(_icon)
         {
            _icon.buttonMode = param1;
         }
      }
      
      private function get hasHighConsortiaSkill() : Boolean
      {
         return playerInfo.newPowerLv > 0 || playerInfo.newAgilityLv > 0 || playerInfo.newIntellectLv > 0 || playerInfo.newPhysiqueLv > 0 || playerInfo.famGpLv > 0 || playerInfo.medalLv > 0 || playerInfo.honorLv > 0 || playerInfo.propertyLv > 0;
      }
      
      private function get hasConsortiaMasterSkill() : Boolean
      {
         return playerInfo.masterPowerLv > 0 || playerInfo.masterAgilityLv > 0 || playerInfo.masterIntellectLv > 0 || playerInfo.masterPhysiqueLv > 0;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         if(_delay)
         {
            clearTimeout(_delay);
         }
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,36,50);
      }
   }
}

