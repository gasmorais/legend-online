package armyII.viewII.rune
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.RuneInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.GameDrag;
   import yishi.utils.GoodsHelp;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class RuneItemView extends Sprite implements Disposeable
   {
      
      private var _iconBack:Bitmap;
      
      private var _itemLock:Bitmap;
      
      private var _baseIcon:BaseIconView;
      
      private var _effectBack:ScaleFrameImage;
      
      private var _levelBack:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _nameBack:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _studyBtn:TextButton;
      
      private var _data:RuneInfo;
      
      private var _filter:IFilterFormat;
      
      private var _runeGInfo:GoodsInfo;
      
      private var _equipedTip:StripView;
      
      private var _canAdd:Boolean;
      
      private var _studyTip:StripView;
      
      private var _promotBtn:BaseButton;
      
      private var _stoneBtn:TextButton;
      
      private var _runeCarryTwoLevel:int = 40;
      
      private var _runeOpenLevel:int = 35;
      
      private var _hitAreaSp:Sprite;
      
      private var _vbox:VBox;
      
      private var _stoneBtnState:int;
      
      private var _notFirst:Boolean = true;
      
      private const OP_ACTIVE_1:int = 1;
      
      private const OP_ACTIVE_2:int = 2;
      
      private const STONE_LV:int = 10;
      
      public function RuneItemView()
      {
         super();
         initView();
         initEvent();
         _runeCarryTwoLevel = int(TempleteManager.instance.getConfigInfoByConfigName("CarryTwoRune").ConfigValue);
         _runeOpenLevel = int(TempleteManager.instance.getConfigInfoByConfigName("OpenRuneGrade").ConfigValue);
      }
      
      private function initView() : void
      {
         _iconBack = ComponentFactory.Instance.creatBitmap("asset.army.rune.IconBack");
         _itemLock = ComponentFactory.Instance.creatBitmap("asset.army.rune.ItemLockAsset");
         _baseIcon = ComponentFactory.Instance.creatCustomObject("army.rune.EquipedIcon");
         _effectBack = ComponentFactory.Instance.creatComponentByStylename("army.rune.RuneItemEffectBack");
         _levelBack = ComponentFactory.Instance.creatBitmap("asset.army.rune.LevelBack");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("army.rune.LevelTxt");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("army.rune.RuneAddBtn");
         _nameBack = ComponentFactory.Instance.creatBitmap("asset.army.rune.TextBack1");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("army.rune.NameTxt");
         _studyBtn = ComponentFactory.Instance.creatComponentByStylename("army.rune.StudyBtn");
         _equipedTip = ComponentFactory.Instance.creatCustomObject("army.rune.EquipedTip");
         _studyTip = ComponentFactory.Instance.creatCustomObject("army.rune.StudyTip");
         _promotBtn = ComponentFactory.Instance.creatComponentByStylename("army.rune.promotBtn2");
         _stoneBtn = ComponentFactory.Instance.creatComponentByStylename("army.rune.stoneBtn");
         _vbox = ComponentFactory.Instance.creatCustomObject("army.rune.vbox");
         addChild(_iconBack);
         addChild(_itemLock);
         addChild(_nameBack);
         _hitAreaSp = new Sprite();
         _hitAreaSp.mouseEnabled = false;
         _hitAreaSp.graphics.beginFill(0,0);
         _hitAreaSp.graphics.drawRect(0,0,74,128);
         _hitAreaSp.graphics.endFill();
         this.hitArea = _hitAreaSp;
         addChild(_hitAreaSp);
         addChild(_baseIcon);
         addChild(_effectBack);
         addChild(_levelBack);
         addChild(_levelTxt);
         addChild(_addBtn);
         addChild(_nameTxt);
         addChild(_studyBtn);
         addChild(_equipedTip);
         addChild(_studyTip);
         addChild(_promotBtn);
         if(VersionSwitch.RUNE_STONE)
         {
            addChild(_stoneBtn);
            addChild(_vbox);
         }
         _stoneBtn.visible = false;
         _effectBack.setFrame(3);
         _effectBack.mouseChildren = false;
         _effectBack.mouseEnabled = false;
         _studyBtn.text = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneItemView.StudyBtnTxt");
         _equipedTip.addChild(createShape());
         _equipedTip.tipData = LanguageMgr.GetTranslation("armyII.viewII.rune.FastRuneItem.OpenTipTxt1");
         _studyTip.addChild(createShape(55,28));
         _filter = new UIFilter();
      }
      
      private function createShape(param1:int = 65, param2:int = 65) : Shape
      {
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(16711680,0);
         _loc3_.graphics.drawRect(0,0,param1,param2);
         _loc3_.graphics.endFill();
         return _loc3_;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         _studyBtn.addEventListener("click",__studyHandler);
         _addBtn.addEventListener("click",__addHandler);
         _stoneBtn.addEventListener("click",stoneClickhandler);
         _baseIcon.addEventListener("mouseDown",__downHandler);
         _promotBtn.addEventListener("click",__onPromotBtnClickHandler);
         NotificationManager.instance.addEventListener("RUNE_UPGRADE",__runeRefreshHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         if(_studyBtn)
         {
            _studyBtn.removeEventListener("click",__studyHandler);
         }
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addHandler);
         }
         if(_stoneBtn)
         {
            _stoneBtn.removeEventListener("click",stoneClickhandler);
         }
         if(_baseIcon)
         {
            _baseIcon.removeEventListener("mouseDown",__downHandler);
         }
         if(_promotBtn)
         {
            _promotBtn.removeEventListener("click",__onPromotBtnClickHandler);
         }
         NotificationManager.instance.removeEventListener("RUNE_UPGRADE",__runeRefreshHandler);
      }
      
      private function stoneClickhandler(param1:MouseEvent) : void
      {
         if(_stoneBtnState == 1)
         {
            ArmySocketOutManager.sendActiveRuneStone(_data.runeId);
         }
         else if(_stoneBtnState == 2)
         {
            FrameControllerManager.instance.armyController.model.currentOpenPanel = ArmyPanelEnum.FUWEN_EQUI;
            FrameControllerManager.instance.openControllerByInfo("army",null,[_data,false]);
         }
      }
      
      private function __onPromotBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         if(_loc2_.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("runeitemView.tip02"));
            return;
         }
         if(canPrompt)
         {
            showPromptFrame(_data);
         }
         else
         {
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback2);
         }
      }
      
      private function quickUIcallback2() : void
      {
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(3021001);
         var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(_loc3_.TemplateId);
         _loc1_.data(_loc2_,10);
         _loc1_.show();
         _loc1_.callback = shopBuyBack2;
      }
      
      private function shopBuyBack2(param1:Boolean, param2:Object = null) : void
      {
         if(param1)
         {
            if(canPrompt)
            {
               ArmySocketOutManager.sendPromotRune(_data.runeId);
            }
         }
      }
      
      private function showPromptFrame(param1:RuneInfo) : void
      {
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(3021001);
         var _loc5_:String = "";
         if(_loc4_)
         {
            _loc5_ = StringHelper.format("<font color={0}>{1}</font>",GoodsHelp.getGoodColorString(_loc4_.Profile),_loc4_.TemplateName);
         }
         var _loc6_:RuneInfo = getPromotRuneInfo(param1);
         if(!_loc6_)
         {
            return;
         }
         var _loc8_:String = LanguageMgr.GetTranslation("armyController.promotRuneTip",10,_loc5_,_loc6_.templateInfo.TemplateName);
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [showPromptFrameBack,param1];
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc2_,_loc3_,true,true);
      }
      
      private function showPromptFrameBack(param1:Boolean, param2:Boolean, param3:RuneInfo) : void
      {
         if(!parent)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         ArmySocketOutManager.sendPromotRune(param3.runeId);
      }
      
      private function get canPrompt() : Boolean
      {
         var _loc1_:int = int(GoodsManager.instance.getGoodsNumByTempId(3021001));
         return _loc1_ >= 10;
      }
      
      private function __runeRefreshHandler(param1:NotificationEvent) : void
      {
         var _loc3_:RuneInfo = param1.data as RuneInfo;
         if(!_data)
         {
            return;
         }
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.templateInfo.RuneType != _data.templateInfo.RuneType)
         {
            return;
         }
         if(!_notFirst && _loc3_.runeHole != null)
         {
            FrameControllerManager.instance.armyController.model.currentOpenPanel = ArmyPanelEnum.FUWEN_EQUI;
            FrameControllerManager.instance.openControllerByInfo("army",null,[_data,true]);
            return;
         }
         if(_data.grade != 1)
         {
            return;
         }
         if(_data.runeCurGp != 0)
         {
            return;
         }
         if(thane.runeCate.hasCarryed(_data.templateInfo.RuneType))
         {
            return;
         }
         if(thane.runeCate.runeScriptLength >= 2)
         {
            return;
         }
         var _loc2_:Point = parent.localToGlobal(new Point(x,y));
         NotificationManager.instance.sendNotification("FAST_KEY_MOVE",{
            "data":_data,
            "point":_loc2_,
            "icon":getDragIconObj()
         });
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(!_canAdd)
         {
            return;
         }
         if(_data.grade == 0)
         {
            _effectBack.setFrame(2);
         }
         else
         {
            _effectBack.setFrame(1);
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _effectBack.setFrame(3);
      }
      
      private function __studyHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(canStudy)
         {
            SimpleAlertHelper.instance.data = [studyRune];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("map.campaign.view.frame.SubmitResourcesFrame.titleTextTip");
            _loc5_ = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneStudyConfirmTxt",_data.templateInfo.TemplateName);
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true);
         }
         else
         {
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
         }
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonTypeAndProperty1(302,_data.templateInfo.RuneType);
         var _loc3_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(_loc2_.TemplateId);
         _loc1_.data(_loc3_);
         _loc1_.show();
         _loc1_.callback = shopBuyBack;
      }
      
      private function shopBuyBack(param1:Boolean, param2:Object = null) : void
      {
         if(param1)
         {
            if(canStudy)
            {
               studyRune(true,true);
            }
         }
      }
      
      private function get getHaveNum() : int
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         var _loc1_:Array = GoodsManager.instance.getGeneralBagGoodsBySonType(302);
         var _loc4_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as GoodsInfo;
            if(_loc3_.templateInfo.Property1 == _data.templateInfo.RuneType)
            {
               _loc4_ += _loc3_.count;
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      private function studyRune(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SoundManager.instance.play("022");
            controler.sendStudyRune(_data.runeId,_runeGInfo.pos);
         }
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         thane.runeInfo = _data;
         var _loc2_:RuneUpgradeView = ComponentFactory.Instance.creatComponentByStylename("army.rune.RuneUpgradeView");
         _loc2_.data = _data;
         _loc2_.show();
      }
      
      private function __downHandler(param1:MouseEvent) : void
      {
         if(!_data || _data.grade == 0)
         {
            return;
         }
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.onDrop = onDragStop;
         _loc2_.dropChecks = [FastRuneItem,Frame,Stage];
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:FastRuneItem = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is FastRuneItem)
            {
               if(thane.runeCate.hasCarryed(_data.templateInfo.RuneType))
               {
                  param1.stopImmediatePropagation();
                  return;
               }
               _loc2_ = param1.dropTarget as FastRuneItem;
               if(!_loc2_.isLock)
               {
                  _loc2_.data = _data;
                  _loc2_.refreshView();
                  NotificationManager.instance.sendNotification("SET_FAST_KEY",null);
               }
               else
               {
                  param1.stopImmediatePropagation();
               }
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
      }
      
      private function getDragIconObj() : DisplayObject
      {
         if(_baseIcon.iconWidth == 0)
         {
            return new Bitmap(new BitmapData(30,30,true,285212672));
         }
         var _loc1_:BitmapData = new BitmapData(_baseIcon.iconWidth / _baseIcon.scaleX,_baseIcon.iconHeight / _baseIcon.scaleY,true,0);
         _filter.setNormalFilter(_baseIcon);
         _loc1_.draw(_baseIcon);
         var _loc3_:Bitmap = new Bitmap(_loc1_);
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      public function set data(param1:RuneInfo) : void
      {
         _data = param1;
         _levelBack.visible = false;
         _levelTxt.visible = false;
         _addBtn.visible = false;
         _nameBack.visible = false;
         _nameTxt.visible = false;
         _studyBtn.visible = false;
         _itemLock.visible = true;
         _equipedTip.visible = true;
         _promotBtn.visible = false;
         _filter.setGrayFilter(_iconBack);
         _notFirst = _data ? _data.runeHole != null : true;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc7_:Array = null;
         var _loc12_:Array = null;
         var _loc3_:Array = null;
         var _loc13_:int = 0;
         var _loc10_:SimpleDictionary = null;
         var _loc1_:Bitmap = null;
         var _loc8_:int = 0;
         var _loc11_:GoodsInfo = null;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         _loc6_ = 10;
         var _loc14_:int = 0;
         var _loc4_:int = 0;
         if(!_data)
         {
            return;
         }
         var _loc5_:Array = TempleteManager.instance.getRuneTemplateByTypeAndLevel(_data.templateInfo.RuneType,_data.templateInfo.Level);
         if(_loc5_.length == 0 || _data.templateInfo == _loc5_[_loc5_.length - 1])
         {
            _levelTxt.text = "Max";
         }
         else
         {
            _levelTxt.text = _data.grade + "/" + _loc5_.length;
         }
         var _loc2_:Boolean = _data.grade >= 10;
         if(_data.templateInfo.Level >= 1)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            if(_data.runeHole == null || _data.runeHole.length == 0)
            {
               _stoneBtnState = 1;
               _stoneBtn.visible = true;
               _stoneBtn.text = LanguageMgr.GetTranslation("army.rune.active");
            }
            else
            {
               _stoneBtnState = 2;
               _stoneBtn.visible = true;
               _stoneBtn.text = LanguageMgr.GetTranslation("army.rune.kong");
               _loc7_ = _data.runeHole.split("|");
               _loc12_ = _loc7_ ? _loc7_[0].split(",") : [];
               _loc3_ = _loc7_ ? _loc7_[1].split(",") : [];
               _loc13_ = int(_data.templateInfo.RuneType);
               _loc10_ = GoodsManager.instance.getRuneEquipBagList(_loc13_);
               _vbox.removeAllChild();
               _vbox.beginChanges();
               _loc8_ = int(_loc3_.length);
               _loc4_ = 0;
               while(_loc4_ < _loc8_)
               {
                  _loc9_ = (_loc13_ - 1) * _loc6_ + _loc4_;
                  _loc11_ = _loc10_[_loc9_];
                  if(_loc11_)
                  {
                     _loc14_ = int(_loc11_.templateInfo.Profile);
                     _loc1_ = ComponentFactory.Instance.creatBitmap("asset.army.stone.icon" + _loc14_);
                  }
                  else
                  {
                     _loc1_ = ComponentFactory.Instance.creatBitmap("asset.army.stone.icon0");
                  }
                  _vbox.addChild(_loc1_);
                  _loc4_++;
               }
               _vbox.commitChanges();
            }
         }
         else
         {
            _stoneBtn.visible = false;
         }
         _nameTxt.text = _data.templateInfo.TemplateName;
         _baseIcon.icon = IconFactory.getTecIconByIcon(_data.templateInfo.Icon);
         checkCondition();
         _baseIcon.tipData = _data;
         _studyBtn.tipData = _data;
         _studyTip.tipData = _data;
         _promotBtn.tipData = getPromotRuneInfo(_data);
      }
      
      private function getPromotRuneInfo(param1:RuneInfo) : RuneInfo
      {
         var _loc4_:RuneInfo = null;
         if(param1.nextTemplateInfo)
         {
            return null;
         }
         var _loc2_:RuneTemplateInfo = param1.templateInfo;
         var _loc3_:RuneTemplateInfo = TempleteManager.instance.getMaxRuneTemplateInfoByRuneType(_loc2_.RuneType,_loc2_.Level + 1);
         if(_loc3_)
         {
            _loc4_ = new RuneInfo();
            _loc4_.grade = 0;
            _loc4_.runeId = _loc3_.TemplateId;
            return _loc4_;
         }
         return null;
      }
      
      private function get isMax() : Boolean
      {
         if(!_data)
         {
            return false;
         }
         return _data.nextTemplateInfo == null;
      }
      
      public function checkCondition() : void
      {
         if(!_data)
         {
            return;
         }
         _levelBack.visible = true;
         _levelTxt.visible = true;
         _addBtn.visible = true;
         _nameBack.visible = true;
         _nameTxt.visible = true;
         _studyBtn.visible = true;
         _itemLock.visible = false;
         _equipedTip.visible = false;
         _studyTip.visible = false;
         _promotBtn.visible = false;
         _filter.setNormalFilter(_iconBack);
         _canAdd = false;
         if(_data.grade == 0)
         {
            _levelBack.visible = false;
            _levelTxt.visible = false;
            _addBtn.visible = false;
            _nameBack.visible = false;
            _nameTxt.visible = false;
            _studyBtn.visible = true;
            _filter.setGrayFilter(_baseIcon);
            _studyBtn.enable = true;
            if(canStudy)
            {
               _studyBtn.backStyle = "asset.army.WashBtnBack2";
            }
            else
            {
               _studyBtn.backStyle = "asset.army.WashBtnBack";
            }
            _studyTip.visible = !_studyBtn.enable;
         }
         _addBtn.visible = needShowAddBtn();
         _promotBtn.visible = needShowPromotBtn();
         if(_stoneBtn.visible && Boolean(VersionSwitch.RUNE_STONE))
         {
            _nameTxt.y = 105;
            _nameBack.y = 100;
         }
         else
         {
            _nameBack.y = 75;
            _nameTxt.y = 78;
         }
         if(_data.grade > 0)
         {
            _levelBack.visible = true;
            _levelTxt.visible = true;
            _nameBack.visible = true;
            _nameTxt.visible = true;
            _studyBtn.visible = false;
            _filter.setNormalFilter(_baseIcon);
            _canAdd = true;
         }
         _filter.setNormalFilter(_addBtn.backgound);
      }
      
      private function needShowAddBtn() : Boolean
      {
         if(_data.grade == 0)
         {
            return false;
         }
         if(_data.nextTemplateInfo == null)
         {
            return false;
         }
         var _loc1_:RuneTemplateInfo = _data.templateInfo;
         var _loc2_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         if(_loc1_.Level == 0)
         {
            if(thane.grades >= _data.nextTemplateInfo.NeedGrade)
            {
               return true;
            }
         }
         else if(_loc2_.isChangeJob || _loc2_.vocationGrades >= _data.nextTemplateInfo.NeedGrade)
         {
            return true;
         }
         return false;
      }
      
      private function needShowPromotBtn() : Boolean
      {
         if(!_data.templateInfo)
         {
            return false;
         }
         var _loc1_:Array = TempleteManager.instance.getRuneTemplateByTypeAndLevel(_data.templateInfo.RuneType,_data.templateInfo.Level + 1);
         if(_loc1_ && _loc1_.length > 0 && _data.nextTemplateInfo == null)
         {
            return true;
         }
         return false;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get canStudy() : Boolean
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = 0;
         var _loc1_:Array = GoodsManager.instance.getGeneralBagGoodsBySonType(302);
         _loc1_.sortOn("pos",16);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as GoodsInfo;
            if(_loc3_.templateInfo.Property1 == _data.templateInfo.RuneType)
            {
               if(_loc3_.isBinds)
               {
                  _runeGInfo = _loc3_;
                  return true;
               }
               if(!_runeGInfo)
               {
                  _runeGInfo = _loc3_;
               }
            }
            _loc2_++;
         }
         if(_runeGInfo)
         {
            return true;
         }
         return false;
      }
      
      private function hasRuneGoods() : Boolean
      {
         var _loc1_:Array = GoodsManager.instance.getGeneralBagGoodsBySonType(302);
         return _loc1_.length > 0 ? true : false;
      }
      
      private function get controler() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      override public function get width() : Number
      {
         return 70;
      }
      
      override public function get height() : Number
      {
         return 125;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_iconBack);
         _iconBack = null;
         ObjectUtils.disposeObject(_itemLock);
         _itemLock = null;
         ObjectUtils.disposeObject(_baseIcon);
         _baseIcon = null;
         ObjectUtils.disposeObject(_effectBack);
         _effectBack = null;
         ObjectUtils.disposeObject(_levelBack);
         _levelBack = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_nameBack);
         _nameBack = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_studyBtn);
         _studyBtn = null;
         ObjectUtils.disposeObject(_promotBtn);
         _promotBtn = null;
         ObjectUtils.disposeObject(_equipedTip);
         _equipedTip = null;
         ObjectUtils.disposeObject(_studyTip);
         _studyTip = null;
         ObjectUtils.disposeObject(_stoneBtn);
         _stoneBtn = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         if(_hitAreaSp)
         {
            _hitAreaSp.graphics.clear();
            ObjectUtils.disposeObject(_hitAreaSp);
            _hitAreaSp = null;
         }
         _filter = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

