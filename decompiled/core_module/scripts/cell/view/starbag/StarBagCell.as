package cell.view.starbag
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import mvc.module.star.StarInfo;
   import mvc.module.star.StarTroughInfo;
   import org.aswing.KeyboardManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.interfaces.IDragTarget;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.StarManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StarHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.ConfirmSellFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class StarBagCell extends Component implements IManualSize
   {
      
      public static const P_backgroundStyle:String = "backgroundStyle";
      
      public static const P_iconStyle:String = "iconStyle";
      
      public static const P_iconX:String = "iconX";
      
      public static const P_iconY:String = "iconY";
      
      public static const P_iconWidth:String = "iconWidth";
      
      public static const P_iconHeight:String = "iconHeight";
      
      public static const P_nameStyle:String = "nameStyle";
      
      public static const P_levelStyle:String = "levelStyle";
      
      public static const P_lockStyle:String = "lockStyle";
      
      public static const P_equipStyle:String = "equipStyle";
      
      public static const P_composeLockStyle:String = "composeLockStyle";
      
      public static const P_addBtnStyle:String = "addBtnStyle";
      
      private var _effect:MainToolBtnGlowEffect;
      
      private const STAR_MASTER_TASK:int = 1802;
      
      public var _addBtnStyle:String;
      
      private var _backgroundStyle:String;
      
      private var _iconStyle:String;
      
      private var _iconViewX:int;
      
      private var _iconViewY:int;
      
      private var _iconViewWidth:int;
      
      private var _iconViewHeight:int;
      
      private var _nameStyle:String;
      
      private var _levelStyle:String;
      
      private var _lockStyle:String;
      
      private var _equipStyle:String;
      
      private var _composeLockStyle:String;
      
      private var _back:DisplayObject;
      
      private var _icon:BaseIconView;
      
      private var _iconOffX:Number;
      
      private var _iconOffY:Number;
      
      private var _name:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _lockImg:Image;
      
      private var _equipImg:Image;
      
      private var _composeLockImg:DisplayObject;
      
      private var _data:StarInfo;
      
      private var _isLock:Boolean;
      
      private var _isComposeLock:Boolean;
      
      private var _canEquip:Boolean;
      
      private var _addBtn:BaseButton;
      
      private var _maxBtn:BaseButton;
      
      private var _tipBtn:BaseButton;
      
      private var _troughInfo:StarTroughInfo;
      
      private var _troughSprite:Sprite;
      
      public var bagType:int = 0;
      
      public var areaType:int = 0;
      
      public var bagPos:int;
      
      private var _eatStar:StarBagCell;
      
      private var _beEatenStar:StarBagCell;
      
      protected var _acceptDrop:Boolean;
      
      public function StarBagCell()
      {
         super();
      }
      
      public function set addBtnStyle(param1:String) : void
      {
         _addBtnStyle = param1;
         onPropertiesChanged("addBtnStyle");
      }
      
      public function set backgroundStyle(param1:String) : void
      {
         _backgroundStyle = param1;
         onPropertiesChanged("backgroundStyle");
      }
      
      public function set iconStyle(param1:String) : void
      {
         _iconStyle = param1;
         onPropertiesChanged("iconStyle");
      }
      
      public function set iconX(param1:int) : void
      {
         _iconViewX = param1;
         onPropertiesChanged("iconX");
      }
      
      public function set iconY(param1:int) : void
      {
         _iconViewY = param1;
         onPropertiesChanged("iconY");
      }
      
      public function set iconWidth(param1:int) : void
      {
         _iconViewWidth = param1;
         onPropertiesChanged("iconWidth");
      }
      
      public function set iconHeight(param1:int) : void
      {
         _iconViewHeight = param1;
         onPropertiesChanged("iconHeight");
      }
      
      public function set nameStyle(param1:String) : void
      {
         _nameStyle = param1;
         onPropertiesChanged("nameStyle");
      }
      
      public function set levelStyle(param1:String) : void
      {
         _levelStyle = param1;
         onPropertiesChanged("levelStyle");
      }
      
      public function set lockStyle(param1:String) : void
      {
         _lockStyle = param1;
         onPropertiesChanged("lockStyle");
      }
      
      public function set equipStyle(param1:String) : void
      {
         _equipStyle = param1;
         onPropertiesChanged("equipStyle");
      }
      
      public function set composeLockStyle(param1:String) : void
      {
         _composeLockStyle = param1;
         onPropertiesChanged("composeLockStyle");
      }
      
      public function addGlowFilter() : void
      {
         var _loc1_:Array = ComponentFactory.Instance.creatFrameFilters("core.DefaultFilter,core.LightFilter");
         this._lockImg.filters = _loc1_[1];
         _effect = new MainToolBtnGlowEffect(_lockImg);
         _effect.play();
         this.addEventListener("click",_clearGowFilter);
      }
      
      private function _clearGowFilter(param1:MouseEvent) : void
      {
         param1.target.removeEventListener("click",_clearGowFilter);
         this.lock = false;
         this._effect.stop();
         param1.stopPropagation();
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["backgroundStyle"])
         {
            _back = ComponentFactory.Instance.creat(_backgroundStyle);
         }
         if(_changedPropeties["iconStyle"])
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
            _icon = ComponentFactory.Instance.creatCustomObject(_iconStyle);
         }
         if(_changedPropeties["iconHeight"] || _changedPropeties["iconWidth"] || _changedPropeties["iconX"] || _changedPropeties["iconY"])
         {
            _icon.beginChanges();
            _icon.x = _iconViewX;
            _icon.y = _iconViewY;
            _icon.iconHeight = _iconViewHeight;
            _icon.iconWidth = _iconViewWidth;
            _icon.isFollowMouse = false;
            _icon.tipDirctions = "7,5,4,6,3,2,0,1";
            _icon.tipGapH = 0;
            _icon.tipGapV = 0;
            _icon.commitChanges();
         }
         if(_changedPropeties["nameStyle"])
         {
            _name = ComponentFactory.Instance.creatComponentByStylename(_nameStyle);
            _name.mouseEnabled = false;
         }
         if(_changedPropeties["levelStyle"])
         {
            _level = ComponentFactory.Instance.creatComponentByStylename(_levelStyle);
            _level.mouseEnabled = false;
         }
         if(_changedPropeties["lockStyle"])
         {
            _lockImg = ComponentFactory.Instance.creat(_lockStyle);
            _lockImg.mouseEnabled = false;
            _lockImg.mouseChildren = false;
         }
         if(_changedPropeties["equipStyle"])
         {
            _equipImg = ComponentFactory.Instance.creat(_equipStyle);
            _equipImg.mouseEnabled = false;
            _equipImg.mouseChildren = false;
            _equipImg.visible = false;
         }
         if(_changedPropeties["composeLockStyle"])
         {
            _composeLockImg = ComponentFactory.Instance.creat("asset.common.vp.icon");
            _composeLockImg.x = 6;
            _composeLockImg.y = 31;
         }
         if(_changedPropeties["addBtnStyle"])
         {
            _troughSprite = new Sprite();
            _addBtn = ComponentFactory.Instance.creatComponentByStylename(_addBtnStyle);
            _maxBtn = ComponentFactory.Instance.creatComponentByStylename("star.maxButton");
            _tipBtn = ComponentFactory.Instance.creatComponentByStylename("star.tipButton");
            addChild(_troughSprite);
            _troughSprite.addChild(_addBtn);
            _troughSprite.addChild(_maxBtn);
            _troughSprite.addChild(_tipBtn);
         }
      }
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_lockImg)
         {
            addChild(_lockImg);
         }
         if(_equipImg)
         {
            addChild(_equipImg);
         }
      }
      
      private function initEvent() : void
      {
         DoubleClickManager.Instance.enableDoubleClick(_icon);
         _icon.addEventListener("interactive_click",__clickHandler);
         _icon.addEventListener("interactive_double_click",__doubleClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_icon)
         {
            _icon.removeEventListener("interactive_click",__clickHandler);
            _icon.removeEventListener("interactive_double_click",__doubleClickHandler);
            DoubleClickManager.Instance.disableDoubleClick(_icon);
         }
      }
      
      private function __addBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.starController._info = troughInfo;
         FrameControllerManager.instance.openControllerByInfo("star",2);
      }
      
      public function set acceptDrop(param1:Boolean) : void
      {
         _acceptDrop = param1;
         buttonMode = param1;
      }
      
      public function get acceptDrop() : Boolean
      {
         return _acceptDrop;
      }
      
      private function __clickHandler(param1:Event) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:GameDrag = null;
         var _loc4_:Boolean = KeyboardManager.isDown(16);
         if(_loc4_ && acceptDrop)
         {
            NotificationManager.instance.sendNotification("SEND_STAR",_data);
            return;
         }
         if(_acceptDrop && _data && !DragManager.getInstance().isDraging)
         {
            SoundManager.instance.play("028",true);
            _loc3_ = getDragIconObj();
            if(!_loc3_)
            {
               return;
            }
            _loc2_ = DragManager.getInstance().starDrag(this,{"icon":_loc3_},true);
            _loc2_.data = _data;
            _loc2_.onDrop = beDropHitCallBack;
            _loc2_.dropChecks = [StarBagCell,IDragTarget,Stage];
         }
      }
      
      public function getDragIconObj() : DisplayObject
      {
         var _loc1_:Sprite = new Sprite();
         _iconOffX = _icon.x;
         _iconOffY = _icon.y;
         setOriginPos(true);
         _loc1_.addChild(_icon);
         _loc1_.addChild(_name);
         _loc1_.addChild(_level);
         if(_composeLockImg.parent)
         {
            _loc1_.addChild(_composeLockImg);
         }
         _loc1_.mouseChildren = false;
         return _loc1_;
      }
      
      public function beDropHitCallBack(param1:GameDrag) : void
      {
         var _loc5_:StarBagCell = null;
         var _loc9_:String = null;
         var _loc8_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc12_:String = null;
         var _loc7_:String = null;
         var _loc10_:SimpleDictionary = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is StarBagCell)
            {
               _loc5_ = param1.dropTarget as StarBagCell;
               if(_loc5_.lock == true || !_loc5_.acceptDrop)
               {
                  addIconBack();
                  return;
               }
               if(_loc5_.data != null)
               {
                  if(_loc5_.data.template.Profile == 8 || this.data.template.Profile == 8)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.HigStarDragTips1"));
                     addIconBack();
                     return;
                  }
                  if(_loc5_.data.template.Profile == 6)
                  {
                     _beEatenStar = _loc5_;
                     _eatStar = this;
                  }
                  else
                  {
                     _beEatenStar = this;
                     _eatStar = _loc5_;
                  }
                  if(_beEatenStar.composeLock)
                  {
                     _loc9_ = LanguageMgr.GetTranslation("vicepassword.description11");
                     MessageTipManager.instance().show(_loc9_);
                     addIconBack();
                     return;
                  }
                  _loc8_ = StarHelper.getStarHtmlName(_eatStar.data.template);
                  _loc3_ = StarHelper.getStarTotalExp(_beEatenStar.data);
                  _loc4_ = StarHelper.checkCanUpGrade(_loc3_,_eatStar.data);
                  _loc11_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.tempStr",_loc8_,_loc3_);
                  if(_loc4_ > _eatStar.data.grade)
                  {
                     _loc11_ += LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.tempLevel",_loc4_);
                  }
                  _loc6_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc2_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc12_ = LanguageMgr.GetTranslation("public.prompt");
                  SimpleAlertHelper.instance.data = [__composeResponse,_loc5_];
                  SimpleAlertHelper.instance.popAlerFrame(_loc12_,_loc11_,_loc6_,_loc2_,true,true,true);
                  addIconBack();
               }
               else
               {
                  _loc7_ = "";
                  if(areaType == 1)
                  {
                     if(_loc5_.bagType == 3)
                     {
                        if(_data.tempId == 107)
                        {
                           MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.HigStarDragTips3"));
                           addIconBack();
                        }
                        else if(_data.template.Profile == 7)
                        {
                           if(_data.grade == 10)
                           {
                              starManager.starMove(_data.pos,_data.bagType,0,3);
                           }
                           else
                           {
                              MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.HigStarDragTips2"));
                              addIconBack();
                           }
                        }
                        else if(_data.template.Profile < 8)
                        {
                           MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.HigStarDragTips2"));
                           addIconBack();
                        }
                        else
                        {
                           starManager.starMove(_data.pos,_data.bagType,0,3);
                        }
                     }
                     else if(_data.bagType == 3)
                     {
                        if(_data.oldBagType == 1)
                        {
                           _canEquip = starManager.moveToBag(_data);
                           SoundManager.instance.play("028",true);
                        }
                        else if(_data.oldBagType == 2)
                        {
                           starManager.starMove(_data.pos,_data.bagType,0,2);
                           SoundManager.instance.play("028",true);
                        }
                        else
                        {
                           addIconBack();
                        }
                     }
                     else
                     {
                        addIconBack();
                     }
                     return;
                  }
                  if(_data.bagType == 1 && _loc5_.bagType == 2)
                  {
                     if(_data.template.Profile == 6)
                     {
                        _loc7_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command01");
                        MessageTipManager.instance().show(_loc7_);
                        addIconBack();
                        return;
                     }
                     if(_loc5_.troughInfo && _loc5_.troughInfo.pos < 8 && (_data.template.MasterType == 17 || _data.template.MasterType == 18 || _data.template.MasterType == 19))
                     {
                        _loc7_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command06");
                        MessageTipManager.instance().show(_loc7_);
                        addIconBack();
                        return;
                     }
                     _loc10_ = starManager.getStarListByBagType(2);
                     for each(var _loc13_:StarInfo in _loc10_)
                     {
                        if(_loc13_.template.MasterType == _data.template.MasterType)
                        {
                           _loc7_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command02");
                           MessageTipManager.instance().show(_loc7_);
                           addIconBack();
                           return;
                        }
                     }
                  }
                  if(_loc5_.troughInfo && _loc5_.troughInfo.pos < 8 && (_data.template.MasterType == 17 || _data.template.MasterType == 18 || _data.template.MasterType == 19))
                  {
                     _loc7_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command06");
                     MessageTipManager.instance().show(_loc7_);
                     addIconBack();
                     return;
                  }
                  SoundManager.instance.play("028",true);
                  starManager.starMove(_data.pos,_data.bagType,_loc5_.bagPos,_loc5_.bagType);
               }
               param1.stopImmediatePropagation();
               return;
            }
            if(param1.dropTarget is IDragTarget)
            {
               if((param1.dropTarget as IDragTarget).type == "PLAYER_STARLISTVIEW")
               {
                  if(_data.bagType == 2)
                  {
                     __doubleClickHandler(null);
                     if(_canEquip)
                     {
                        return;
                     }
                  }
               }
               else if(_data.bagType == 1)
               {
                  __doubleClickHandler(null);
                  if(_canEquip)
                  {
                     return;
                  }
               }
            }
         }
         addIconBack();
         param1.stopImmediatePropagation();
         if(_troughSprite && _icon)
         {
            if(getChildIndex(_icon) > getChildIndex(_troughSprite))
            {
               swapChildren(_icon,_troughSprite);
            }
         }
      }
      
      private function addIconBack() : void
      {
         setOriginPos(false);
         addChild(_icon);
         addChild(_name);
         addChild(_level);
         addChild(_equipImg);
         if(_composeLockImg.parent)
         {
            addChild(_composeLockImg);
         }
      }
      
      private function setOriginPos(param1:Boolean) : void
      {
         if(param1)
         {
            _icon.x = 0;
            _icon.y = 0;
            _name.x -= _iconOffX;
            _name.y -= _iconOffY;
            _level.x -= _iconOffX;
            _level.y -= _iconOffY;
            _composeLockImg.x -= _iconOffX;
            _composeLockImg.y -= _iconOffY;
         }
         else
         {
            _icon.x = _iconOffX;
            _icon.y = _iconOffY;
            _name.x += _iconOffX;
            _name.y += _iconOffY;
            _level.x += _iconOffX;
            _level.y += _iconOffY;
            _composeLockImg.x += _iconOffX;
            _composeLockImg.y += _iconOffY;
         }
      }
      
      private function __composeResponse(param1:Boolean, param2:Boolean, param3:StarBagCell) : void
      {
         var _loc5_:StarBagCell = null;
         var _loc6_:StarBagCell = null;
         var _loc7_:int = 0;
         var _loc4_:String = null;
         var _loc9_:ConfirmSellFrame = null;
         var _loc8_:String = null;
         if(param1 && _data && param3 && param3.data)
         {
            if(param3.data.template.Profile == 6)
            {
               _loc5_ = this;
               _loc6_ = param3;
            }
            else
            {
               _loc5_ = param3;
               _loc6_ = this;
            }
            _loc7_ = StarHelper.getStarMaxGradeByProfile(_eatStar.data.template.Profile);
            if(_loc5_.data.grade >= _loc7_)
            {
               _loc4_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command03");
               MessageTipManager.instance().show(_loc4_);
               return;
            }
            if(_beEatenStar.data.template.Profile >= 5 && _beEatenStar.data.template.Profile != 6)
            {
               _loc9_ = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmSellFrame");
               _loc8_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.confirmComposeTip",StarHelper.getStarHtmlName(_beEatenStar.data.template)) + "\n" + LanguageMgr.GetTranslation("yishi.view.ConfirmSellFrame.content.htmlText02") + "<font color=\'#01ccff\'>[YES]</font>" + LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.confirmComposeTip2");
               _loc9_.show(_loc8_,_eatStar,composeCall);
               return;
            }
            composeCall(param1,true,_eatStar);
         }
      }
      
      private function composeCall(param1:Boolean, param2:Boolean, param3:Object) : void
      {
         if(param1 && _data && param3)
         {
            SoundManager.instance.play("027",true);
            starManager.starMove(_beEatenStar.data.pos,_beEatenStar.data.bagType,_eatStar.bagPos,_eatStar.bagType,true);
         }
      }
      
      private function __doubleClickHandler(param1:Event) : void
      {
         if(_data && _acceptDrop)
         {
            if(areaType == 1)
            {
               switch(_data.bagType - 1)
               {
                  case 0:
                  case 1:
                     starManager.moveToSub(_data);
                     SoundManager.instance.play("028",true);
                     break;
                  case 2:
                     if(_data.oldBagType == 1)
                     {
                        _canEquip = starManager.moveToBag(_data);
                        SoundManager.instance.play("028",true);
                        break;
                     }
                     if(_data.oldBagType == 2)
                     {
                        starManager.starMove(_data.pos,_data.bagType,0,2);
                        SoundManager.instance.play("028",true);
                     }
               }
            }
            else
            {
               switch(_data.bagType - 1)
               {
                  case 0:
                     _canEquip = starManager.moveToEquip(_data);
                     SoundManager.instance.play("028",true);
                     break;
                  case 1:
                     _canEquip = starManager.moveToBag(_data);
                     SoundManager.instance.play("028",true);
               }
            }
         }
      }
      
      public function get data() : StarInfo
      {
         return _data;
      }
      
      public function set data(param1:StarInfo) : void
      {
         var _loc2_:Boolean = false;
         if(_addBtn)
         {
            if(troughInfo && troughInfo.pos <= 7 && troughInfo.pos < playerInfo.vocationLevel)
            {
               _addBtn.removeEventListener("click",__addBtnHandler);
               _addBtn.addEventListener("click",__addBtnHandler);
               _addBtn.visible = true;
               _tipBtn.visible = false;
               _maxBtn.visible = false;
               if(_troughInfo.grade >= 10)
               {
                  _addBtn.visible = false;
                  _tipBtn.visible = true;
                  _maxBtn.visible = true;
               }
               else
               {
                  _addBtn.visible = true;
                  _tipBtn.visible = false;
                  _maxBtn.visible = false;
               }
            }
            else
            {
               _addBtn.removeEventListener("click",__addBtnHandler);
               _addBtn.visible = false;
               _tipBtn.visible = false;
               _maxBtn.visible = false;
            }
         }
         _data = param1;
         if(!param1)
         {
            clean();
            return;
         }
         mouseEnabled = true;
         mouseChildren = true;
         initEvent();
         buttonMode = _acceptDrop;
         if(_icon)
         {
            _icon.buttonMode = _acceptDrop;
            _icon.icon = IconFactory.getCommonIconPath(_data.template.Icon);
            _icon.tipData = {
               "starData":_data,
               "troughInfo":_troughInfo
            };
            _loc2_ = !(_icon.parent is StarBagCell);
            if(_loc2_)
            {
               setOriginPos(false);
               addChildAt(_icon,1);
            }
         }
         if(_name)
         {
            _level.y = 3;
            addChild(_name);
            _name.text = _data.template.TemplateName;
            if(_name.numLines > 2)
            {
               _name.y = 8;
               _name.height = 60;
               _level.y = -4;
            }
            else if(_name.numLines > 1)
            {
               _name.y = 23;
               _name.height = 40;
            }
            else
            {
               _name.y = 35;
               _name.height = 20;
            }
            _name.setFrame(_data.template.Profile);
         }
         if(_level)
         {
            addChild(_level);
            if(_data.grade > 0)
            {
               _level.text = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.level",_data.grade);
            }
            else
            {
               _level.text = "";
            }
            _level.setFrame(_data.template.Profile);
         }
         composeLock = _data.composeLock;
         if(_troughSprite && _icon)
         {
            if(getChildIndex(_icon) > getChildIndex(_troughSprite))
            {
               swapChildren(_icon,_troughSprite);
            }
         }
         if(_equipImg)
         {
            if(_data.bagType == 2)
            {
               _equipImg.visible = true;
            }
            else
            {
               _equipImg.visible = false;
            }
         }
      }
      
      public function get troughInfo() : StarTroughInfo
      {
         return _troughInfo;
      }
      
      public function set troughInfo(param1:StarTroughInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _troughInfo = param1;
         if(_addBtn)
         {
            _addBtn.tipData = LanguageMgr.GetTranslation("public.level2",troughInfo.grade) + ":" + LanguageMgr.GetTranslation("yishi.cell.view.starbag.troughInfo.effect",troughInfo.grade);
            _tipBtn.tipData = LanguageMgr.GetTranslation("public.level2",troughInfo.grade) + ":" + LanguageMgr.GetTranslation("yishi.cell.view.starbag.troughInfo.effect",troughInfo.grade);
         }
      }
      
      private function clean() : void
      {
         removeEvent();
         buttonMode = false;
         _name.text = "";
         _level.text = "";
         _icon.tipData = null;
         _icon.icon = null;
         if(_equipImg)
         {
            _equipImg.visible = false;
         }
         composeLock = false;
      }
      
      public function setScaleCell() : void
      {
         _icon.scaleX = 0.8;
         _icon.scaleY = 0.8;
         _icon.x = 29;
         _icon.y = 27;
         _name.x = -9;
         _name.y *= 0.8;
         _level.x *= 0.8;
         _level.y = _level.y;
         _composeLockImg.x = 31;
         _composeLockImg.y = 11;
      }
      
      public function set lock(param1:Boolean) : void
      {
         _isLock = param1;
         if(_lockImg)
         {
            _lockImg.visible = _isLock;
            if(_addBtn)
            {
               if(troughInfo.grade < 10 && !_isLock && troughInfo.pos <= 7)
               {
                  _addBtn.visible = true;
                  _tipBtn.visible = false;
                  _maxBtn.visible = false;
               }
               else
               {
                  _addBtn.visible = false;
                  _tipBtn.visible = false;
                  _maxBtn.visible = false;
               }
            }
         }
      }
      
      public function get lock() : Boolean
      {
         return _isLock;
      }
      
      public function set btnState(param1:Boolean) : void
      {
         if(_addBtn && _troughInfo)
         {
            if(param1)
            {
               if(_troughInfo.pos <= 7)
               {
                  _addBtn.visible = true;
                  _tipBtn.visible = false;
                  _maxBtn.visible = false;
                  if(_troughInfo.grade < 10)
                  {
                     _addBtn.visible = true;
                     _tipBtn.visible = false;
                     _maxBtn.visible = false;
                  }
                  else
                  {
                     _addBtn.visible = false;
                     _tipBtn.visible = true;
                     _maxBtn.visible = true;
                  }
               }
               else
               {
                  _addBtn.visible = false;
                  _tipBtn.visible = false;
                  _maxBtn.visible = false;
               }
            }
            else
            {
               _addBtn.visible = false;
               _tipBtn.visible = false;
               _maxBtn.visible = false;
            }
         }
      }
      
      public function set composeLock(param1:Boolean) : void
      {
         _isComposeLock = param1;
         if(_composeLockImg)
         {
            if(_isComposeLock)
            {
               addChild(_composeLockImg);
            }
            else if(_composeLockImg.parent)
            {
               _composeLockImg.parent.removeChild(_composeLockImg);
            }
         }
      }
      
      public function get composeLock() : Boolean
      {
         return _isComposeLock;
      }
      
      public function set backVisible(param1:Boolean) : void
      {
         if(_back)
         {
            param1 ? (_back.alpha = 1) : (_back.alpha = 0);
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,60,60);
      }
      
      private function get starManager() : StarManager
      {
         return StarManager.instance;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addBtnHandler);
         }
         this.removeEventListener("click",_clearGowFilter);
         _data = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         _eatStar = null;
         _beEatenStar = null;
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         if(_name)
         {
            _name.dispose();
         }
         _name = null;
         if(_level)
         {
            _level.dispose();
         }
         _level = null;
         if(_lockImg)
         {
            _lockImg.dispose();
         }
         _lockImg = null;
         if(_composeLockImg)
         {
            ObjectUtils.disposeObject(_composeLockImg);
            _composeLockImg = null;
         }
         if(_maxBtn)
         {
            ObjectUtils.disposeObject(_maxBtn);
         }
         _maxBtn = null;
         if(_addBtn)
         {
            ObjectUtils.disposeObject(_addBtn);
         }
         _addBtn = null;
         if(_tipBtn)
         {
            ObjectUtils.disposeObject(_tipBtn);
         }
         _tipBtn = null;
         if(_troughSprite)
         {
            ObjectUtils.disposeObject(_troughSprite);
         }
         _troughSprite = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

