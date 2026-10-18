package star.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.StarEvent;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import managers.VIPManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import mvc.module.star.StarInfo;
   import mvc.module.star.StarModel;
   import org.events.DictionaryEvent;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManager;
   import yishi.manager.StarManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StarHelper;
   import yishi.view.frame.ConfirmSellFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class DisplayStarView extends Sprite implements Disposeable
   {
      
      public static const MAX_DISPLAY_STAR:int = 18;
      
      private var _target:StarInfo;
      
      private var _displayStarContainer:SimpleTileList;
      
      private var _displayStarDic:SimpleDictionary;
      
      private var _quickStarBtn:IconButton;
      
      private var _quickComposeBtn:IconButton;
      
      private var _quickPickupBtn:IconButton;
      
      private var _quickSellBtn:IconButton;
      
      private var _quickSellComBox:ComboBox;
      
      private var _mask:Shape;
      
      private var _tempSprite:Sprite;
      
      private var _autoStarBtn:IconButton;
      
      private var _setStarBtn:IconButton;
      
      private var _levelPrams:Array = [];
      
      public function DisplayStarView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("astrology_free_function_level");
         if(_loc1_)
         {
            _levelPrams = _loc1_.ConfigValue.split(",");
         }
         _displayStarContainer = ComponentFactory.Instance.creatCustomObject("star.DisplayStarContainer",[6]);
         _autoStarBtn = ComponentFactory.Instance.creatComponentByStylename("star.AutoStarBtn");
         _setStarBtn = ComponentFactory.Instance.creatComponentByStylename("star.SetStarBtn");
         _quickStarBtn = ComponentFactory.Instance.creatComponentByStylename("star.QuickStarBtn");
         _quickStarBtn.tipData = LanguageMgr.GetTranslation("star.view.DisplayStarView.quickStarBtnTip");
         _quickComposeBtn = ComponentFactory.Instance.creatComponentByStylename("star.DisplayViewQuickComposeBtn");
         _quickComposeBtn.tipData = LanguageMgr.GetTranslation("star.view.DisplayStarView.quickComposeTipData");
         _quickPickupBtn = ComponentFactory.Instance.creatComponentByStylename("star.QuickPickupBtn");
         _quickPickupBtn.tipData = LanguageMgr.GetTranslation("star.view.DisplayStarView.quickPickupBtnTip");
         _quickSellBtn = ComponentFactory.Instance.creatComponentByStylename("star.QuickSellBtn");
         _quickSellBtn.tipData = LanguageMgr.GetTranslation("star.view.DisplayStarView.quickSellBtnTip");
         _quickSellComBox = ComponentFactory.Instance.creatComponentByStylename("star.QuickSellComBox");
         _tempSprite = new Sprite();
         _tempSprite.x = _displayStarContainer.x;
         _tempSprite.y = _displayStarContainer.y;
         _mask = new Shape();
         _mask.graphics.beginFill(0,0.6);
         _mask.graphics.drawRect(-39,-46,595,399);
         _mask.graphics.endFill();
         _mask.alpha = 0;
         addChildAt(_mask,0);
         if(starManager.tempStarList.getList().length > 0)
         {
            TweenMax.to(_mask,1,{"alpha":1});
         }
         _quickSellComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.view.DisplayStarView.quickSell",LanguageMgr.GetTranslation("star.view.DisplayStarView.white")));
         _quickSellComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.view.DisplayStarView.quickSell",LanguageMgr.GetTranslation("star.view.DisplayStarView.green")));
         _quickSellComBox.listPanel.vectorListModel.append(LanguageMgr.GetTranslation("star.view.DisplayStarView.quickSell",LanguageMgr.GetTranslation("star.view.DisplayStarView.blue")));
         _quickSellComBox.listPanel.list.defaultSelectItemByCellValue = _quickSellComBox.listPanel.vectorListModel.getElementAt(starModel.starQuickSellType - 1);
         initStarListView();
         addChild(_autoStarBtn);
         addChild(_setStarBtn);
         addChild(_quickStarBtn);
         addChild(_quickComposeBtn);
         addChild(_quickPickupBtn);
         addChild(_quickSellBtn);
         addChild(_quickSellComBox);
         addChild(_displayStarContainer);
         addChild(_tempSprite);
      }
      
      private function initStarListView() : void
      {
         var _loc2_:StarIconView = null;
         _displayStarDic = new SimpleDictionary();
         for each(var _loc1_:StarInfo in starManager.tempStarList)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("star.StarIconView");
            _loc2_.data = _loc1_;
            _displayStarDic.add(_loc1_.pos,_loc2_);
            _displayStarContainer.addChild(_loc2_);
         }
      }
      
      private function addEvent() : void
      {
         starManager.tempStarList.addEventListener("addDictionary",__addDisplayStar);
         starManager.tempStarList.addEventListener("deleteDictionary",__delDisplayStar);
         starManager.addEventListener("COMPOSE_STAR",__starComposeHandler);
         _autoStarBtn.addEventListener("click",__antoStarClick);
         _setStarBtn.addEventListener("click",__setStarClick);
         _quickStarBtn.addEventListener("click",__quickStarClick);
         _quickComposeBtn.addEventListener("click",__quickComposeClick);
         _quickPickupBtn.addEventListener("click",__quickPickupClick);
         _quickSellBtn.addEventListener("click",__quickSellClick);
         _quickSellComBox.listPanel.list.addEventListener("listItemClick",__onQuickSellItemClick);
      }
      
      private function removeEvent() : void
      {
         starManager.tempStarList.removeEventListener("addDictionary",__addDisplayStar);
         starManager.tempStarList.removeEventListener("deleteDictionary",__delDisplayStar);
         starManager.removeEventListener("COMPOSE_STAR",__starComposeHandler);
         _autoStarBtn.removeEventListener("click",__antoStarClick);
         _setStarBtn.removeEventListener("click",__setStarClick);
         _quickStarBtn.removeEventListener("click",__quickStarClick);
         _quickComposeBtn.removeEventListener("click",__quickComposeClick);
         _quickPickupBtn.removeEventListener("click",__quickPickupClick);
         _quickSellBtn.removeEventListener("click",__quickSellClick);
         _quickSellComBox.listPanel.list.removeEventListener("listItemClick",__onQuickSellItemClick);
      }
      
      private function __onQuickSellItemClick(param1:ListItemEvent) : void
      {
         starModel.starQuickSellType = quickSellType;
      }
      
      private function __starComposeHandler(param1:StarEvent) : void
      {
         var _loc2_:StarInfo = param1.starInfo;
         if(_loc2_ && _loc2_.bagType == 0 && _displayStarDic[_loc2_.pos])
         {
            _displayStarDic[_loc2_.pos].data = _loc2_;
         }
      }
      
      private function __addDisplayStar(param1:DictionaryEvent) : void
      {
         if(_mask.alpha != 1)
         {
            TweenMax.to(_mask,1,{"alpha":1});
         }
         var _loc3_:StarInfo = param1.newData as StarInfo;
         var _loc2_:String = LanguageMgr.GetTranslation("star.view.DisplayStarView.addStarTip01",_loc3_.template.TemplateName,_loc3_.grade);
         if(starModel.openCrystal > 0 && starManager.randomPosList[starModel.openCrystal] == 1)
         {
            _loc2_ += LanguageMgr.GetTranslation("star.view.DisplayStarView.addStarTip02",starModel.getNameByIndex(starModel.openCrystal));
         }
         MessageTipManager.instance().show(_loc2_);
         var _loc4_:StarIconView = ComponentFactory.Instance.creatCustomObject("star.StarIconView");
         _loc4_.data = _loc3_;
         _displayStarDic.add(_loc3_.pos,_loc4_);
         _displayStarContainer.addChild(_loc4_);
      }
      
      private function __delDisplayStar(param1:DictionaryEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc5_:int = 0;
         var _loc2_:MagicSpringSlotInfo = null;
         var _loc6_:int = 0;
         var _loc8_:FilterFrameText = null;
         var _loc4_:StarInfo = param1.oldData as StarInfo;
         var _loc7_:StarIconView = _displayStarDic[_loc4_.pos];
         _displayStarDic.del(_loc4_.pos);
         _tempSprite.addChild(_loc7_);
         _loc7_.removeAllButIcon();
         if(starModel.delWay == 1)
         {
            _loc3_ = Point.distance(new Point(_loc7_.x,_loc7_.y),new Point(481,355)) / Point.distance(new Point(0,0),new Point(481,355));
            TweenMax.to(_loc7_,1.5 * _loc3_,{
               "x":481,
               "y":355,
               "onComplete":__moveComplete,
               "onCompleteParams":[_loc7_]
            });
         }
         else if(starModel.delWay == 2)
         {
            _loc5_ = int(_loc4_.template.SellGold);
            _loc2_ = MagicSpringManager.instance.model.checkIsExistBuffer(5);
            if(_loc2_)
            {
               _loc6_ = Math.floor(_loc2_.tempInfo.AddValue * _loc4_.template.SellGold / 100);
               _loc5_ += _loc6_;
            }
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("star.StarSellTip");
            _loc8_.text = LanguageMgr.GetTranslation("star.view.DisplayStarView.starSellTip",_loc5_);
            _loc8_.x = _loc7_.x - int(_loc8_.width / 2) + 5;
            _loc8_.y = _loc7_.y - int(_loc8_.height / 2);
            _tempSprite.addChild(_loc8_);
            TweenMax.to(_loc8_,1,{
               "y":"-30",
               "alpha":0
            });
            TweenMax.to(_loc7_,1,{
               "scaleX":2,
               "scaleY":2,
               "alpha":0,
               "onComplete":__moveComplete,
               "onCompleteParams":[_loc7_,_loc8_]
            });
         }
         else
         {
            __moveComplete(_loc7_);
         }
      }
      
      private function __moveComplete(param1:StarIconView, param2:FilterFrameText = null) : void
      {
         _displayStarContainer.refreshChildPos();
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         param1.dispose();
         if(param2)
         {
            if(param2.parent)
            {
               param2.parent.removeChild(param2);
            }
            param2.dispose();
         }
         var _loc3_:int = int(starManager.tempStarList.getList().length);
         if(_loc3_ == 0 && _mask.alpha != 0)
         {
            TweenMax.to(_mask,1,{"alpha":0});
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __antoStarClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc10_:String = null;
         var _loc4_:String = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         SoundManager.instance.play("022");
         if(int(_levelPrams[1]) > thane.grades)
         {
            if(!VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt || VIPManager.Instance.model.vipInfo.VipGrade < 2)
            {
               SimpleAlertHelper.instance.data = [__antoStarHandler];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc10_ = LanguageMgr.GetTranslation("public.prompt");
               _loc4_ = LanguageMgr.GetTranslation("vip.newVipOpenView.alert2",_levelPrams[1]);
               SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc4_,_loc2_,_loc3_,true,true);
               return;
            }
         }
         var _loc11_:int = int(SharedManager.instance.autoStarCostGold);
         var _loc9_:int = int(SharedManager.instance.autoStarSell);
         var _loc6_:int = int(SharedManager.instance.autoStarCompose);
         if(_loc11_ == 1)
         {
            _loc7_ = 100000;
         }
         if(_loc11_ == 2)
         {
            _loc7_ = 1000000;
         }
         if(_loc11_ == 3)
         {
            _loc7_ = 10000000;
         }
         _loc5_ = _loc9_;
         _loc8_ = _loc6_ + 3;
         if(ResourceManager.instance.gold.count < _loc7_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("star.view.MakeStarView.command01"));
            return;
         }
         starManager.sendAutoStar(_loc7_,_loc5_,_loc8_);
      }
      
      private function __antoStarHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("vip");
         }
      }
      
      private function __setStarClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("star",3);
      }
      
      private function __quickStarClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         if(int(_levelPrams[0]) > thane.grades)
         {
            if(!VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt || VIPManager.Instance.model.vipInfo.VipGrade < 1)
            {
               SimpleAlertHelper.instance.data = [__quickStarHandler];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc5_ = LanguageMgr.GetTranslation("public.prompt");
               _loc4_ = LanguageMgr.GetTranslation("vip.newVipOpenView.alert1",_levelPrams[0]);
               SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc2_,_loc3_,true,true);
               return;
            }
         }
         if(starManager.tempStarList.getList().length >= 18)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("star.view.DisplayStarView.command01"));
            return;
         }
         if(ResourceManager.instance.gold.count < 20000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("star.view.MakeStarView.command01"));
            return;
         }
         starManager.sendRandomStar(-1);
      }
      
      private function __quickStarHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("vip");
         }
      }
      
      private function __quickPickupClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         starModel.quickPickupClick();
      }
      
      public function quickPickByOuter() : void
      {
         __quickPickupClick(null);
      }
      
      private function __quickSellClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = quickSellType;
         if(_loc2_ > 0 && Boolean(starModel.checkAction(2,_loc2_)))
         {
            starModel.delWay = 2;
            starManager.sendStarPick(-1,_loc2_);
         }
      }
      
      private function __quickComposeClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc9_:StarInfo = null;
         var _loc11_:TodayNotAlertFrame = null;
         var _loc8_:String = null;
         var _loc3_:String = null;
         SoundManager.instance.play("022");
         if(starManager.tempStarList.getList().length <= 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.horoscope.HoroscopeView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc7_:int = 0;
         var _loc6_:SimpleDictionary = starManager.tempStarList;
         for each(var _loc10_:StarInfo in _loc6_)
         {
            if(_loc10_.template.Profile > 1 && !_loc10_.composeLock)
            {
               _loc7_ += StarHelper.getStarTotalExp(_loc10_);
               if(_loc10_.grade < StarHelper.getStarMaxGradeByProfile(_loc10_.template.Profile))
               {
                  if(_loc10_.template.Profile != 6)
                  {
                     if(!_loc9_)
                     {
                        _loc9_ = _loc10_;
                     }
                     else
                     {
                        _loc9_ = _loc10_;
                        _loc9_.template.Profile < _loc10_.template.Profile ? _loc9_ : _loc9_;
                     }
                  }
               }
            }
         }
         if(!_loc9_ || (_loc7_ -= StarHelper.getStarTotalExp(_loc9_)) <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.horoscope.HoroscopeView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc5_:String = StarHelper.getStarHtmlName(_loc9_.template);
         var _loc4_:int = int(StarHelper.checkCanUpGrade(_loc7_,_loc9_));
         _loc2_ = _loc5_ + LanguageMgr.GetTranslation("armyII.viewII.horoscope.HoroscopeView.command04",_loc7_);
         _loc2_ += LanguageMgr.GetTranslation("armyII.viewII.horoscope.HoroscopeView.command03",_loc4_);
         _loc4_ > _loc9_.grade ? _loc2_ : _loc2_;
         _target = _loc9_;
         if(!StarManager.isNotAlert)
         {
            _loc11_ = ComponentFactory.Instance.creatComponentByStylename("star.composeNotAlert");
            _loc8_ = _loc2_;
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc11_.show(_loc8_,_loc3_,__quickComposeResponse,null,"center",2,true);
            return;
         }
         __quickComposeResponse(true);
      }
      
      private function __quickComposeResponse(param1:Boolean) : void
      {
         var _loc8_:ConfirmSellFrame = null;
         var _loc6_:String = null;
         var _loc4_:String = null;
         var _loc3_:StarInfo = _target;
         var _loc2_:Array = [];
         var _loc5_:Array = starManager.tempStarList.getList();
         if(param1)
         {
            StarManager.isNotAlert = true;
         }
         for each(var _loc7_:StarInfo in _loc5_)
         {
            if(_loc7_ != _loc3_ && !_loc7_.composeLock && _loc7_.template.Profile >= 5 && _loc7_.template.Profile != 6)
            {
               _loc2_.push(_loc7_);
            }
         }
         if(_loc2_.length > 0)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmSellFrame");
            _loc6_ = "";
            _loc4_ = "";
            for each(_loc7_ in _loc2_)
            {
               _loc4_ += StarHelper.getStarHtmlName(_loc7_.template);
            }
            _loc6_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.confirmComposeTip",_loc4_) + "\n" + LanguageMgr.GetTranslation("yishi.view.ConfirmSellFrame.content.htmlText02") + "<font color=\'#01ccff\'>[YES]</font>" + LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.confirmComposeTip2");
            _loc8_.show(_loc6_,_loc3_,quickComposeCall);
            return;
         }
         quickComposeCall(true);
      }
      
      private function quickComposeCall(param1:Boolean, param2:Boolean = false, param3:* = null) : void
      {
         var _loc4_:StarInfo = null;
         if(param1)
         {
            _loc4_ = _target;
            starManager.starModel.delWay = 3;
            starManager.sendQuickCompose(_loc4_.pos,0);
         }
      }
      
      public function get quickSellType() : int
      {
         return _quickSellComBox ? _quickSellComBox.currentSelectedIndex + 1 : 0;
      }
      
      private function get starManager() : StarManager
      {
         return StarManager.instance;
      }
      
      private function get starModel() : StarModel
      {
         return StarManager.instance.starModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         TweenMax.killChildTweensOf(this,true);
         for each(var _loc1_:StarIconView in _displayStarDic)
         {
            if(_loc1_.data)
            {
               _displayStarDic.del(_loc1_.data.pos);
            }
            _loc1_.dispose();
         }
         _loc1_ = null;
         if(_displayStarDic)
         {
            _displayStarDic.clear();
         }
         _displayStarDic = null;
         ObjectUtils.disposeObject(_autoStarBtn);
         _autoStarBtn = null;
         ObjectUtils.disposeObject(_setStarBtn);
         _setStarBtn = null;
         ObjectUtils.disposeObject(_quickStarBtn);
         _quickStarBtn = null;
         ObjectUtils.disposeObject(_quickComposeBtn);
         _quickComposeBtn = null;
         ObjectUtils.disposeObject(_quickPickupBtn);
         _quickPickupBtn = null;
         ObjectUtils.disposeObject(_quickSellBtn);
         _quickSellBtn = null;
         ObjectUtils.disposeObject(_quickSellComBox);
         _quickSellComBox = null;
         ObjectUtils.disposeObject(_displayStarContainer);
         _displayStarContainer = null;
         ObjectUtils.disposeViolentMc(_tempSprite);
         _tempSprite = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

