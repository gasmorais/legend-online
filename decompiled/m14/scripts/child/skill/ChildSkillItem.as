package child.skill
{
   import bag.view.MulItemUseFrame;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MsgMan;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildSkillItem extends Component
   {
      
      public static const ADVANCED_SKILL_ITEM_ID:uint = 2260001;
      
      public static const ADVANCED_SKILL_LEVEL:uint = 5;
      
      public static const ADVANCED_COST_LIST:Vector.<uint> = new <uint>[1000,2000,4000];
      
      private var _data:SkillTempInfo;
      
      private var _bg:ScaleFrameImage;
      
      private var _skillItemBg:Bitmap;
      
      private var _skillItem:ChildSkillItemView;
      
      private var _learnBtn:IconButton;
      
      private var _upgradeBtn:IconButton;
      
      private var _skillName:FilterFrameText;
      
      private var _skillCoolDown:FilterFrameText;
      
      private var _skillNeedBook:FilterFrameText;
      
      private var _isLearn:Boolean;
      
      private var _maxGrade:int;
      
      private var battleSkillList:Array;
      
      private var _skillProBg:Bitmap;
      
      private var _skillProbg2:Bitmap;
      
      private var _skillPro:Bitmap;
      
      private var _proTxt:FilterFrameText;
      
      private var _proMask:Shape;
      
      private var useNum:int = 0;
      
      public var CHILD_SKILL_UPDATE:String = "childSkillUpdate";
      
      private var mc:MovieClip;
      
      public function ChildSkillItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private static function buyCallBack(param1:Boolean, param2:Object = null) : void
      {
         MsgMan.notifyObserver("ChildEvent.CHILD_INFO");
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("child.childSkillItem.back");
         _skillItemBg = ComponentFactory.Instance.creatBitmap("asset.childSkill.skillItemBg");
         _skillItem = ComponentFactory.Instance.creatCustomObject("child.childSkillItemView");
         _learnBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.ChildSkillItem.learnBtn");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.ChildSkillItem.upgradeBtn");
         _skillName = ComponentFactory.Instance.creatComponentByStylename("ChildItemView.ChildSkillNameTxt");
         _skillCoolDown = ComponentFactory.Instance.creatComponentByStylename("ChildItemView.ChildSkillCoolDownTxt");
         _skillNeedBook = ComponentFactory.Instance.creatComponentByStylename("ChildItemView.needBookTxt");
         _proTxt = ComponentFactory.Instance.creatComponentByStylename("child.ChildSkillItem.proTxt");
         _skillProBg = ComponentFactory.Instance.creatBitmap("asset.childSkill.proBg01");
         _skillProbg2 = ComponentFactory.Instance.creatBitmap("asset.childSkill.proBg02");
         _skillPro = ComponentFactory.Instance.creatBitmap("asset.childSkill.pro");
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_skillItemBg);
         addChild(_skillItem);
         addChild(_learnBtn);
         addChild(_upgradeBtn);
         addBtnTips(CHILD_SKILL_UPDATE,_upgradeBtn);
         addChild(_skillName);
         _skillName.text = "{invalid_utf8=230}{invalid_utf8=138}?能名字七个字";
         addChild(_skillCoolDown);
         _skillCoolDown.text = "冷却时间{invalid_utf8=239}{invalid_utf8=188}?10{invalid_utf8=231}{invalid_utf8=167}?";
         addChild(_skillNeedBook);
         _skillNeedBook.text = "学习消{invalid_utf8=232}?{invalid_utf8=151}技能书:1";
         _skillNeedBook.setFrame(1);
         _proMask = new Shape();
         _proMask.x = 217;
         _proMask.y = 46;
         addChild(_skillProBg);
         addChild(_skillProbg2);
         addChild(_skillPro);
         addChild(_proMask);
         _skillPro.mask = _proMask;
         addChild(_proTxt);
      }
      
      private function initEvent() : void
      {
         _learnBtn.addEventListener("click",__learnBtnClickHandler);
         _upgradeBtn.addEventListener("click",__upgradeBtnClickHandler);
         NotificationManager.instance.addEventListener("INFO_TIPS_DATA_UPDATE",onSelectedBtnTipsUpdate);
      }
      
      private function removeEvent() : void
      {
         if(_learnBtn)
         {
            _learnBtn.removeEventListener("click",__learnBtnClickHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",__upgradeBtnClickHandler);
         }
         NotificationManager.instance.removeEventListener("INFO_TIPS_DATA_UPDATE",onSelectedBtnTipsUpdate);
      }
      
      private function __learnBtnClickHandler(param1:MouseEvent) : void
      {
         var itemId:int;
         var skillBookName:String;
         var content:String;
         var msg:String;
         var quickUIcallback:Function;
         var e:MouseEvent = param1;
         if(model.selectedChild == null)
         {
            return;
         }
         if(model.selectedChild.fightUserId > 0 && model.selectedChild.fightUserId != playerInfo.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.cannotop"));
            return;
         }
         itemId = 0;
         if(_data.UseWay == 1)
         {
            itemId = 2269000;
         }
         else if(_data.UseWay == 2)
         {
            if(_data.MasterType == 44)
            {
               itemId = 2269002;
            }
            else
            {
               itemId = 2269001;
            }
         }
         if(GoodsManager.instance.getGoodsNumByTempId(itemId) >= 1)
         {
            skillBookName = getSkillBook(_data).TemplateName;
            content = LanguageMgr.GetTranslation("child.skill.learnBtnClickHandler.msg",skillBookName,_data.TemplateName);
            msg = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            SharedManagerHelper.ins.needAlert("child.skill.ChildSkillItem.__learnBtnClickHandler",leanSkillCallBack,msg,content);
         }
         else
         {
            quickUIcallback = function():void
            {
               var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
               var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(itemId);
               _loc1_.data(_loc2_,1);
               _loc1_.callback = buyCallBack;
               _loc1_.show();
            };
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
         }
      }
      
      private function leanSkillCallBack() : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         if(_data.UseWay == 1)
         {
            _loc3_ = 2269000;
         }
         else if(_data.UseWay == 2)
         {
            if(_data.MasterType == 44)
            {
               _loc3_ = 2269002;
            }
            else
            {
               _loc3_ = 2269001;
            }
         }
         var _loc4_:int = int(GoodsManager.instance.findPosById(_loc3_));
         ChildSender.learnSkill(ChildManager.instance.model.selectedChild.childId,_loc4_,data.TemplateId);
         var _loc1_:Array = ChildManager.instance.model.selectedChild.fightSkill.split(",");
         var _loc2_:String = "";
         var _loc5_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            if((!_loc1_[_loc6_] || _loc1_[_loc6_] == "-1" || _loc1_[_loc6_] == "0") && !_loc5_)
            {
               _loc1_[_loc6_] = _data.SonType;
               if(_loc6_ == 4)
               {
                  _loc2_ += _data.SonType;
               }
               else
               {
                  _loc2_ += _data.SonType + ",";
               }
               _loc5_ = true;
            }
            else if(_loc6_ == 4)
            {
               if(!_loc1_[_loc6_])
               {
                  _loc2_ += "-1";
               }
               else
               {
                  _loc2_ += _loc1_[_loc6_] + "";
               }
            }
            else if(!_loc1_[_loc6_])
            {
               _loc2_ += "-1,";
            }
            else
            {
               _loc2_ += _loc1_[_loc6_] + ",";
            }
            _loc6_++;
         }
         ChildSender.carrySkill(ChildManager.instance.model.selectedChild.childId,_loc2_);
      }
      
      private function __upgradeBtnClickHandler(param1:MouseEvent) : void
      {
         var itemId:int;
         var count:int;
         var quickUIcallback:Function;
         var goods:GoodsInfo;
         var frame:MulItemUseFrame;
         var e:MouseEvent = param1;
         if(model.selectedChild == null)
         {
            return;
         }
         if(model.selectedChild.fightUserId > 0 && model.selectedChild.fightUserId != playerInfo.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.cannotop"));
            return;
         }
         itemId = 1;
         if(_data.Grades < 5)
         {
            if(_data.UseWay == 1)
            {
               itemId = 2269000;
            }
            else if(_data.UseWay == 2)
            {
               if(_data.MasterType == 44)
               {
                  itemId = 2269002;
               }
               else
               {
                  itemId = 2269001;
               }
            }
         }
         else
         {
            itemId = 2260001;
         }
         count = int(GoodsManager.instance.getGoodsNumByTempId(itemId));
         if(count <= 0)
         {
            quickUIcallback = function():void
            {
               var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
               var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(itemId);
               _loc1_.data(_loc2_,getUpgradeCostByGrade(_data.Grades) - useNum);
               _loc1_.callback = buyCallBack;
               _loc1_.show();
            };
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
         }
         else
         {
            goods = new GoodsInfo();
            goods.templateId = itemId;
            goods.count = GoodsManager.instance.getGoodsNumByTempId(itemId);
            goods.randomSkill1 = data.TemplateId;
            frame = ComponentFactory.Instance.creatComponentByStylename("core.MulItemUseFrame");
            frame._isItem = false;
            frame.data = goods;
            frame.show();
         }
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         var _loc15_:SkillTempInfo = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:String = null;
         var _loc4_:Array = null;
         var _loc10_:int = 0;
         var _loc12_:String = null;
         var _loc16_:Array = null;
         var _loc9_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc13_:int = 0;
         var _loc17_:int = 0;
         this._data = param1;
         _loc15_ = getSkillData(data,ChildManager.instance.model.selectedChild.skill);
         _isLearn = false;
         var _loc14_:GoodsTemplateInfo = getSkillBook(param1);
         if(_loc15_)
         {
            _data = _loc15_;
            _isLearn = true;
         }
         _skillName.text = data.TemplateName;
         _skillCoolDown.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",data.CoolDown / 1000);
         if(_data && _data.UseWay == 1)
         {
            _skillCoolDown.visible = true;
         }
         else
         {
            _skillCoolDown.visible = false;
         }
         _bg.setFrame(data.UseWay);
         var _loc7_:int = int(TempleteManager.instance.getSkillsBySonType(data.SonType).length);
         _skillItem.maxGrade = _loc7_;
         _skillItem.isLearn = _isLearn;
         _skillItem.data = data;
         _skillPro.visible = false;
         _skillProBg.visible = false;
         _skillProbg2.visible = false;
         _proMask.visible = false;
         _proTxt.visible = false;
         _skillNeedBook.visible = true;
         if(_isLearn)
         {
            _learnBtn.visible = false;
            if(data.Grades >= _loc7_)
            {
               _upgradeBtn.visible = true;
               _upgradeBtn.enable = false;
               _skillNeedBook.text = LanguageMgr.GetTranslation("child.skill.ChildSkillItem.maxLevel",_data.TemplateName);
               _skillPro.visible = true;
               _skillProBg.visible = true;
               _skillProbg2.visible = true;
               _proMask.visible = true;
               _proTxt.visible = true;
               _proTxt.text = "Max";
               drawPro(1,1);
            }
            else
            {
               _skillPro.visible = true;
               _skillProBg.visible = true;
               _skillProbg2.visible = true;
               _proMask.visible = true;
               _proTxt.visible = true;
               _upgradeBtn.visible = true;
               _upgradeBtn.enable = true;
               _skillNeedBook.text = LanguageMgr.GetTranslation("child.attribute.ChildSkillItem.upgradeSkillNeedNum",_loc14_.TemplateName,getUpgradeCostByGrade(_data.Grades));
               _loc2_ = GoodsManager.instance.getGoodsArrBySonTypeAndPropertyAndNotLock(226,_data.SonType);
               _loc3_ = 0;
               _loc8_ = 0;
               while(_loc8_ < _loc2_.length)
               {
                  _loc3_ += (_loc2_[_loc8_] as GoodsInfo).count;
                  _loc8_++;
               }
               _loc11_ = ChildManager.instance.model.selectedChild.skillBooks;
               _loc4_ = _loc11_.split("|");
               _loc10_ = 0;
               while(_loc10_ < _loc4_.length)
               {
                  _loc12_ = _loc4_[_loc10_];
                  _loc16_ = _loc12_.split(",");
                  if(parseInt(_loc16_[0]) > 0 && parseInt(_loc16_[0]) == data.TemplateId)
                  {
                     drawPro(parseInt(_loc16_[1]),getUpgradeCostByGrade(_data.Grades));
                     useNum = parseInt(_loc16_[1]);
                     break;
                  }
                  _loc10_++;
               }
               _proTxt.text = useNum + " / " + getUpgradeCostByGrade(_data.Grades);
            }
         }
         else
         {
            _skillNeedBook.visible = true;
            _learnBtn.visible = true;
            _upgradeBtn.visible = false;
            _skillNeedBook.text = LanguageMgr.GetTranslation("child.attribute.ChildSkillItem.learnSkillNeedNum1",_loc14_.TemplateName);
            _loc9_ = GoodsManager.instance.getGoodsArrBySonTypeAndPropertyAndNotLock(226,_data.SonType);
            _loc5_ = 0;
            _loc6_ = 0;
            while(_loc6_ < _loc9_.length)
            {
               _loc5_ += (_loc9_[_loc6_] as GoodsInfo).count;
               _loc6_++;
            }
            _loc13_ = 0;
            if(_data.UseWay == 1)
            {
               _loc13_ = 2269000;
            }
            else if(_data.UseWay == 2)
            {
               if(_data.MasterType == 44)
               {
                  _loc13_ = 2269002;
               }
               else
               {
                  _loc13_ = 2269001;
               }
            }
            _loc17_ = int(GoodsManager.instance.getGoodsNumByTempId(_loc13_));
            if(_loc17_ == 0)
            {
               _learnBtn.iconStyle = "asset.childSkill.childSkillItem.learnBtnIcon2";
               _learnBtn.backStyle = "asset.childSkill.childSkillItem.learnBtnBg2";
            }
            else
            {
               _learnBtn.iconStyle = "asset.childSkill.childSkillItem.learnBtnIcon";
               _learnBtn.backStyle = "asset.childSkill.childSkillItem.learnBtnBg";
            }
         }
         onSelectedBtnTipsUpdate(null);
      }
      
      private function getSkillBook(param1:SkillTempInfo) : GoodsTemplateInfo
      {
         var _loc3_:* = null;
         var _loc5_:SkillTempInfo = null;
         var _loc2_:int = 1;
         _loc5_ = getSkillData(data,ChildManager.instance.model.selectedChild.skill);
         var _loc4_:int = int(_loc5_ ? _loc5_.Grades : 1);
         if(_loc4_ < 5)
         {
            if(param1.UseWay == 1)
            {
               _loc2_ = 2269000;
            }
            else if(param1.UseWay == 2)
            {
               if(param1.MasterType == 44)
               {
                  _loc2_ = 2269002;
               }
               else
               {
                  _loc2_ = 2269001;
               }
            }
         }
         else
         {
            _loc2_ = 2260001;
         }
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_);
      }
      
      private function getUpgradeGoodsByGrade(param1:SkillTempInfo) : GoodsTemplateInfo
      {
         var _loc2_:GoodsTemplateInfo = null;
         var _loc3_:int = 0;
         if(param1.Grades >= 5)
         {
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(2260001);
         }
         else
         {
            _loc3_ = 0;
            if(param1.UseWay == 1)
            {
               _loc3_ = 2269000;
            }
            else if(param1.UseWay == 2 && param1.MasterType != 44)
            {
               _loc3_ = 2269001;
            }
            else if(param1.UseWay == 2 && param1.MasterType == 44)
            {
               _loc3_ = 2269002;
            }
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_);
         }
         return _loc2_;
      }
      
      private function getUpgradeCostByGrade(param1:uint) : uint
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(param1 >= 5)
         {
            _loc3_ = uint(param1 - 5);
            if(_loc3_ >= ADVANCED_COST_LIST.length)
            {
               _loc2_ = 0;
            }
            else
            {
               _loc2_ = ADVANCED_COST_LIST[_loc3_];
            }
         }
         else
         {
            _loc2_ = uint(Math.pow(4,param1 - 1) * 10);
         }
         return _loc2_;
      }
      
      private function getUpgradeNameByGrade(param1:uint) : String
      {
         var _loc2_:String = null;
         if(param1 >= 5)
         {
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(2260001).TemplateName;
         }
         else
         {
            _loc2_ = _data.TemplateName + LanguageMgr.GetTranslation("child.skill.ChildSkillItem.skillBook");
         }
         return _loc2_;
      }
      
      public function getSkillData(param1:SkillTempInfo, param2:String) : SkillTempInfo
      {
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc5_:SkillTempInfo = null;
         if(param2)
         {
            _loc3_ = param2.split(",");
         }
         else
         {
            _loc3_ = [];
         }
         var _loc4_:SkillTempInfo = null;
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            if(_loc3_ && _loc3_[_loc6_] != "-1" && _loc3_[_loc6_] != "")
            {
               _loc5_ = TempleteManager.instance.getSkillById(parseInt(_loc3_[_loc6_]));
               if(_loc5_.SonType == param1.SonType)
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function drawPro(param1:int, param2:int) : void
      {
         _proMask.graphics.clear();
         _proMask.graphics.beginFill(16777215,0);
         _proMask.graphics.drawRect(0,0,229 * param1 / param2,16);
         _proMask.graphics.endFill();
      }
      
      private function getMaxNeedBook(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = int(TempleteManager.instance.getSkillsBySonType(data.SonType).length);
         if(param1 < 5)
         {
            _loc4_ = 5 - 1;
         }
         var _loc2_:int = 0;
         _loc3_ = param1;
         while(_loc3_ <= _loc4_)
         {
            _loc2_ += getUpgradeCostByGrade(_loc3_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function addBtnTips(param1:String, param2:IconButton) : void
      {
         if(mc == null)
         {
            mc = getBtnTipView();
         }
         param2.addChild(mc);
      }
      
      public function onSelectedBtnTipsUpdate(param1:Event = null) : void
      {
         if(mc != null)
         {
            mc.visible = false;
         }
         var _loc2_:GoodsTemplateInfo = getUpgradeGoodsByGrade(_data);
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(_loc2_.TemplateId));
         if(_loc3_ > 0 && mc)
         {
            mc.visible = true;
            mc.txt.text = _loc3_ > 99 ? "99+" : _loc3_.toString();
         }
      }
      
      private function getBtnTipView() : MovieClip
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         _loc1_.visible = false;
         _loc1_.x = 43;
         _loc1_.y = -12;
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_skillNeedBook)
         {
            ObjectUtils.disposeObject(_skillNeedBook);
         }
         _skillNeedBook = null;
         if(_skillProBg)
         {
            ObjectUtils.disposeObject(_skillProBg);
         }
         _skillProBg = null;
         if(_skillProbg2)
         {
            ObjectUtils.disposeObject(_skillProbg2);
         }
         _skillProbg2 = null;
         if(_skillPro)
         {
            ObjectUtils.disposeObject(_skillPro);
         }
         _skillPro = null;
         if(_proMask)
         {
            _proMask.graphics.clear();
         }
         _proMask = null;
         if(_skillItemBg)
         {
            ObjectUtils.disposeObject(_skillItemBg);
         }
         _skillItemBg = null;
         if(_skillItem)
         {
            ObjectUtils.disposeObject(_skillItem);
         }
         _skillItem = null;
         if(_learnBtn)
         {
            ObjectUtils.disposeObject(_learnBtn);
         }
         _learnBtn = null;
         if(_upgradeBtn)
         {
            ObjectUtils.disposeObject(_upgradeBtn);
         }
         _upgradeBtn = null;
         if(_skillName)
         {
            ObjectUtils.disposeObject(_skillName);
         }
         _skillName = null;
         if(_skillCoolDown)
         {
            ObjectUtils.disposeObject(_skillName);
         }
         _skillName = null;
         if(_proTxt)
         {
            ObjectUtils.disposeObject(_proTxt);
         }
         _proTxt = null;
         _data = null;
      }
   }
}

