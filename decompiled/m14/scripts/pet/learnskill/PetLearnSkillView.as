package pet.learnskill
{
   import bag.datas.GoodsSonType;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.PetSocketOut;
   import managers.ShopManager;
   import managers.VIPManager;
   import mvc.module.pet.PetData;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import mvc.module.vip.VipInfo;
   import pet.property.PetShowView;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.VipPrerogativeInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ConfigManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.component.TileContainer;
   import yishi.view.frame.NewVipOpenView;
   import yishi.view.tips.MessageTipManager;
   
   public class PetLearnSkillView extends Component
   {
      
      private static const NUM:int = 25;
      
      private var _back1:ScaleBitmapImage;
      
      private var _back2:Sprite;
      
      private var _back3:Bitmap;
      
      private var _back4:MutipleImage;
      
      private var _titleBg:Bitmap;
      
      private var _showView:PetShowView;
      
      private var _tile1:TileContainer;
      
      private var _tile2:TileContainer;
      
      private var _successRateLabel:GradientText;
      
      private var _learnBtn:IconButton;
      
      private var _bookItemList:Array;
      
      private var _skillItemList:Array;
      
      private var _learnSkillUseBind:Boolean = true;
      
      private var _allbooks:Array;
      
      private var bookDic:Dictionary;
      
      private var _shopModel:ShopModel;
      
      private var _bottomSp:Sprite;
      
      private var _current:int;
      
      private var _total:int;
      
      private var _firstBtn:BaseButton;
      
      private var _lastBtn:BaseButton;
      
      private var _preBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBack:Bitmap;
      
      private var _books:Array;
      
      private var _currentBook:GoodsInfo;
      
      private var goodsTemp:GoodsTemplateInfo;
      
      private const SPECIAL_SKILL:int = 1;
      
      private const RANDOM_SKILL:int = 2;
      
      private var _lastFreeText:FilterFrameText;
      
      private var _lastFreeNote:FilterFrameText;
      
      private var _quitSkill:int;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _lastFreeSkillLearnDate:Date;
      
      private var _mask:ScaleBitmapImage;
      
      private var _vipOpenView:NewVipOpenView;
      
      private var _data:PetData;
      
      private var _petType:int = -1000;
      
      public function PetLearnSkillView()
      {
         super();
         _shopModel = ShopManager.Instance.model;
         _lastFreeSkillLearnDate = DateFormatter.parse(playerInfo.lastFreeSkillLearnTime,"YYYY-MM-DD hh:mm:ss");
         initView();
         addEvent();
         updateState();
         if(stage)
         {
            invalidateViewport(null);
         }
         else
         {
            addEventListener("addedToStage",invalidateViewport);
         }
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:PetSkillItemViewII = null;
         var _loc2_:PetSkillBookItemView = null;
         _back1 = ComponentFactory.Instance.creatComponentByStylename("petskill.AllSkillBack");
         _back2 = ComponentFactory.Instance.creat("asset.pet.GoodsBack");
         _back2.x = 317;
         _back2.y = 290;
         _back3 = ComponentFactory.Instance.creatBitmap("asset.pet.skillBG_open");
         _back3.x = 4;
         _back3.y = 277;
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.pet.MorphSKillBg");
         _titleBg.x = 64;
         _titleBg.y = 281;
         _back4 = ComponentFactory.Instance.creatComponentByStylename("pet.learnSkillView.Image");
         _showView = new PetShowView();
         _showView.state = 2;
         _showView.x = 5;
         _showView.y = 10;
         _tile1 = ComponentFactory.Instance.creatCustomObject("petSkill.TileContainer1");
         _tile2 = ComponentFactory.Instance.creatCustomObject("petSkill.TileContainer2");
         _tile2.mouseEnabled = false;
         addChild(_back1);
         addChild(_back2);
         addChild(_back3);
         addChild(_back4);
         addChild(_titleBg);
         addChild(_showView);
         addChild(_tile1);
         addChild(_tile2);
         _skillItemList = [];
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc1_ = new PetSkillItemViewII();
            _tile1.appendItem(_loc1_);
            if(_loc3_ >= 5)
            {
               _loc1_.skillType = 2;
            }
            else
            {
               _loc1_.skillType = 1;
               _loc1_.index = _loc3_;
            }
            _skillItemList.push(_loc1_);
            _loc3_++;
         }
         _bookItemList = [];
         _loc3_ = 0;
         while(_loc3_ < 25)
         {
            _loc2_ = new PetSkillBookItemView();
            _tile2.appendItem(_loc2_);
            _bookItemList.push(_loc2_);
            _loc3_++;
         }
         _successRateLabel = ComponentFactory.Instance.creatComponentByStylename("petskill.SuccRate");
         _learnBtn = ComponentFactory.Instance.creatComponentByStylename("petskill.LearnBtn");
         _lastFreeText = ComponentFactory.Instance.creatComponentByStylename("pet.lastFreeSkillText");
         _lastFreeNote = ComponentFactory.Instance.creatComponentByStylename("pet.lastFreeSkillNote");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("pet.learnSkillView.ScrollPanel");
         _mask = ComponentFactory.Instance.creatComponentByStylename("pet.learnSkillView.Mask");
         _vipOpenView = new NewVipOpenView(205);
         _vipOpenView.x = 315;
         _vipOpenView.y = 340;
         _vipOpenView._nickNameTxt.width = 305;
         addChild(_successRateLabel);
         addChild(_learnBtn);
         addChild(_lastFreeText);
         addChild(_lastFreeNote);
         addChild(_scrollPanel);
         _scrollPanel.setView(_tile2);
         addChild(_mask);
         addChild(_vipOpenView);
         _successRateLabel.text = LanguageMgr.GetTranslation("pet.PetFrame.openWithDianmond");
         _lastFreeNote.text = LanguageMgr.GetTranslation("pet.PetLearnSkillView.lastFreeSkillNote");
         _bottomSp = new Sprite();
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("PetLearnSkillView.firstBtn");
         _lastBtn = ComponentFactory.Instance.creatComponentByStylename("PetLearnSkillView.lastBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("PetLearnSkillView.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("PetLearnSkillView.nextBtn");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("PetLearnSkillView.pageTxt");
         _pageBack = ComponentFactory.Instance.creatBitmap("asset.pet.PetLearnSkillViewPageTxtBack");
         _bottomSp.addChild(_firstBtn);
         _bottomSp.addChild(_lastBtn);
         _bottomSp.addChild(_preBtn);
         _bottomSp.addChild(_nextBtn);
         _bottomSp.addChild(_pageBack);
         _bottomSp.addChild(_pageTxt);
         _bottomSp.x = 165;
         _bottomSp.y = 394;
         ass();
      }
      
      private function ass() : void
      {
         if(ConfigManager.info.AAS)
         {
            _learnBtn.enable = true;
            if(!checkFreeSkillTime())
            {
               _learnBtn.enable = false;
            }
         }
      }
      
      private function invalidateViewport(param1:Event) : void
      {
         var id:int;
         var e:Event = param1;
         removeEventListener("addedToStage",invalidateViewport);
         id = int(setTimeout(function():void
         {
            clearTimeout(id);
            if(_scrollPanel)
            {
               _scrollPanel.invalidateViewport();
               _scrollPanel.commitChanges();
            }
         },150));
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_back3);
         _back3 = null;
         ObjectUtils.disposeObject(_back4);
         _back4 = null;
         ObjectUtils.disposeObject(_showView);
         _showView = null;
         ObjectUtils.disposeObject(_tile1);
         _tile1 = null;
         ObjectUtils.disposeObject(_tile2);
         _tile2 = null;
         ObjectUtils.disposeAllChildren(_successRateLabel);
         _successRateLabel = null;
         ObjectUtils.disposeObject(_learnBtn);
         _learnBtn = null;
         ObjectUtils.disposeObject(_pageBack);
         _pageBack = null;
         ObjectUtils.disposeObject(_lastFreeText);
         _lastFreeText = null;
         ObjectUtils.disposeObject(_lastFreeNote);
         _lastFreeNote = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_firstBtn);
         _firstBtn = null;
         ObjectUtils.disposeObject(_lastBtn);
         _lastBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_bottomSp);
         _bottomSp = null;
         ObjectUtils.disposeObject(_vipOpenView);
         _vipOpenView = null;
         if(_skillItemList)
         {
            while(_skillItemList.length)
            {
               ObjectUtils.disposeObject(_skillItemList.pop());
            }
         }
         if(_bookItemList)
         {
            while(_bookItemList.length)
            {
               ObjectUtils.disposeObject(_bookItemList.pop());
            }
         }
         _skillItemList = null;
         _bookItemList = null;
         _currentBook = null;
         goodsTemp = null;
      }
      
      private function addEvent() : void
      {
         _tile2.addEventListener("click",__itemClickHandler);
         _learnBtn.addEventListener("click",__learnClickHandler);
         NotificationManager.instance.addEventListener("PET_SKILL_CHANGE",__setFastKeyHandler);
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__pageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__pageBtnHandler);
         }
         if(_firstBtn)
         {
            _firstBtn.addEventListener("click",__pageBtnHandler);
         }
         if(_lastBtn)
         {
            _lastBtn.addEventListener("click",__pageBtnHandler);
         }
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__systimeUpdateHandler);
         NotificationManager.instance.addEventListener("QUIT_PET_SKILL",__quitPetSkillHandler);
         playerInfo.addEventListener("FREESKILL_CHANGE",__freeSkillTimeHandler);
         __systimeUpdateHandler(null);
      }
      
      private function removeEvent() : void
      {
         if(_tile2)
         {
            _tile2.removeEventListener("click",__itemClickHandler);
         }
         if(_learnBtn)
         {
            _learnBtn.removeEventListener("click",__learnClickHandler);
         }
         NotificationManager.instance.removeEventListener("PET_SKILL_CHANGE",__setFastKeyHandler);
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__pageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__pageBtnHandler);
         }
         if(_firstBtn)
         {
            _firstBtn.removeEventListener("click",__pageBtnHandler);
         }
         if(_lastBtn)
         {
            _lastBtn.removeEventListener("click",__pageBtnHandler);
         }
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__systimeUpdateHandler);
         NotificationManager.instance.removeEventListener("QUIT_PET_SKILL",__quitPetSkillHandler);
         playerInfo.removeEventListener("FREESKILL_CHANGE",__freeSkillTimeHandler);
      }
      
      private function __pageBtnHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case _preBtn:
               if(_current > 1)
               {
                  _current -= 1;
               }
               break;
            case _nextBtn:
               if(_current < _total)
               {
                  _current += 1;
               }
               break;
            case _firstBtn:
               _current = 1;
               break;
            case _lastBtn:
               _current = _total;
         }
         setBtnState();
         refreshCells();
      }
      
      private function setBtnState() : void
      {
         _preBtn.enable = _current > 1;
         _firstBtn.enable = _current > 1;
         _nextBtn.enable = _current < _total;
         _lastBtn.enable = _current < _total;
         if(_total < 1)
         {
            _total = 1;
         }
         _pageTxt.text = _current + "/" + _total;
      }
      
      private function refreshCells() : void
      {
         bindSkillBooks();
      }
      
      private function __setFastKeyHandler(param1:NotificationEvent) : void
      {
         PetSocketOut.setSkillFastKey(_data.petId,fastKey);
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         var _loc7_:PetSkillBookItemView = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc9_:String = null;
         var _loc10_:GoodsInfo = null;
         var _loc5_:String = null;
         var _loc11_:String = null;
         var _loc12_:ShopGoodsInfo = null;
         var _loc6_:int = 0;
         var _loc8_:String = null;
         if(param1.target is PetSkillBookItemView)
         {
            if(!_data)
            {
               return;
            }
            _loc7_ = param1.target as PetSkillBookItemView;
            goodsTemp = _loc7_.data;
            if(!goodsTemp)
            {
               return;
            }
            if(_data.checkSkillIsLearned(goodsTemp.Property1))
            {
               _loc2_ = LanguageMgr.GetTranslation("pet.learnskill.PetLearnSkillView.skillisexit");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(_loc7_.filters && _loc7_.filters.length > 0)
            {
               return;
            }
            if(_loc7_.count <= 0)
            {
               return;
            }
         }
         else if(param1.target is TextButton)
         {
            _loc7_ = (param1.target as TextButton).parent as PetSkillBookItemView;
            goodsTemp = _loc7_.data;
            if(!goodsTemp)
            {
               return;
            }
            _currentBook = new GoodsInfo();
            _currentBook.templateId = _loc7_.data.TemplateId;
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc9_ = LanguageMgr.GetTranslation("public.prompt");
            _loc10_ = getUseSkillBook(_loc7_.data.TemplateId);
            if(_loc10_)
            {
               _loc5_ = _currentBook.templateInfo.TemplateName;
               _loc11_ = LanguageMgr.GetTranslation("PetLearnSkillView.useBookTip.randomSkill",_loc5_);
               SimpleAlertHelper.instance.data = [CheckUseBook];
               SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc11_,_loc3_,_loc4_,true,true,false,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert");
            }
            else
            {
               _loc12_ = TempleteManager.instance.getShopTempInfoByItemId(_loc7_.data.TemplateId);
               if(_loc12_)
               {
                  _loc6_ = _loc12_.Point + _loc12_.GiftToken;
                  _loc8_ = GoodsSonType.getColorByProfile(_currentBook.templateInfo.Profile);
                  _loc5_ = _currentBook.templateInfo.TemplateName;
                  _loc11_ = LanguageMgr.GetTranslation("PetLearnSkillView.usePointTip",_loc6_,_loc8_,_loc5_);
                  SimpleAlertHelper.instance.data = [CheckUseBind];
                  SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc11_,_loc3_,_loc4_,true,true,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc6_);
               }
            }
         }
      }
      
      private function CheckUseBook(param1:Boolean, param2:Boolean = true) : void
      {
         if(!param1)
         {
            return;
         }
         sendLearn(1);
      }
      
      private function CheckUseBind(param1:Boolean, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         if(isDie)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         _learnSkillUseBind = param2;
         var _loc4_:int = int(playerInfo.point);
         if(_learnSkillUseBind)
         {
            _loc4_ = playerInfo.point + playerInfo.giftToken;
         }
         var _loc5_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(goodsTemp.TemplateId);
         if(_loc5_)
         {
            _loc3_ = _loc5_.Point + _loc5_.GiftToken;
         }
         if(_loc4_ >= _loc3_)
         {
            sendLearn(1);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function sendLearn(param1:int) : void
      {
         if(!_data)
         {
            return;
         }
         learnSkill(param1);
      }
      
      private function checkUseBindSkillBookBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            learnSkill(param3);
         }
      }
      
      private function learnSkill(param1:int) : void
      {
         var _loc2_:int = 0;
         if(!_data)
         {
            return;
         }
         if(param1 == 1)
         {
            _loc2_ = int(TempleteManager.instance.getSkillTemplateInfoById(goodsTemp.Property1).TemplateId);
         }
         else if(param1 == 2)
         {
            _loc2_ = 0;
         }
         PetSocketOut.learnSkill(_data.petId,_loc2_,param1,_learnSkillUseBind);
      }
      
      private function getUseSkillBook(param1:int, param2:int = 0) : GoodsInfo
      {
         var _loc4_:GoodsInfo = null;
         var _loc5_:* = null;
         var _loc3_:Array = GoodsManager.instance.getBagGoodsByTemplateId(param1);
         if(_loc3_.length <= 0)
         {
            return null;
         }
         _loc3_.sortOn(["isBinds","pos"],[2,16]);
         if(param2 == 0)
         {
            _loc4_ = _loc3_[0];
         }
         else if(param2 == 1)
         {
            for each(_loc5_ in _loc3_)
            {
               if(_loc5_.isBinds)
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
         }
         else if(param2 == 2)
         {
            for each(_loc5_ in _loc3_)
            {
               if(!_loc5_.isBinds)
               {
                  _loc4_ = _loc5_;
                  break;
               }
            }
         }
         return _loc4_;
      }
      
      private function __learnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc9_:String = null;
         var _loc6_:int = 0;
         SoundManager.instance.play("022");
         if(!_data)
         {
            return;
         }
         if(checkFreeSkillTime())
         {
            sendLearn(2);
            return;
         }
         var _loc3_:Boolean = true;
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc8_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc7_:String = LanguageMgr.GetTranslation("pet.PetFrame.enterWar");
         if(_loc3_)
         {
            _loc6_ = getRandomSkillCost();
            _loc9_ = LanguageMgr.GetTranslation("PetLearnSkillView.usePointTip.randomSkill",_loc6_);
            SimpleAlertHelper.instance.data = [CheckUseRandomBind];
            SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc9_,_loc4_,_loc5_,true,true,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc6_);
         }
      }
      
      private function CheckUseRandomBind(param1:Boolean, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         if(isDie)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         _learnSkillUseBind = param2;
         var _loc4_:int = int(playerInfo.point);
         if(param2)
         {
            _loc4_ = playerInfo.point + playerInfo.giftToken;
         }
         _loc3_ = getRandomSkillCost();
         if(_loc4_ >= _loc3_)
         {
            sendLearn(2);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function getRandomSkillCost() : int
      {
         var _loc2_:int = 200;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("pet_learn_random_skill");
         if(_loc1_)
         {
            _loc2_ = parseInt(_loc1_.ConfigValue);
         }
         return _loc2_;
      }
      
      private function __quitPetSkillHandler(param1:NotificationEvent) : void
      {
         var _loc2_:* = null;
         var _loc9_:String = null;
         var _loc6_:int = 0;
         SoundManager.instance.play("022");
         _quitSkill = param1.data;
         if(!_data)
         {
            return;
         }
         var _loc3_:Boolean = true;
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc8_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc7_:String = LanguageMgr.GetTranslation("pet.PetFrame.enterWar");
         if(_loc3_)
         {
            _loc6_ = getForgetSkillCost();
            _loc9_ = LanguageMgr.GetTranslation("PetLearnSkillView.usePointTip.quitSkill",_loc6_);
            SimpleAlertHelper.instance.data = [checkQuitSkillBind];
            SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc9_,_loc4_,_loc5_,true,true,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc6_);
         }
      }
      
      private function checkQuitSkillBind(param1:Boolean, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         if(isDie)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         _learnSkillUseBind = param2;
         var _loc4_:int = int(playerInfo.point);
         if(param2)
         {
            _loc4_ = playerInfo.point + playerInfo.giftToken;
         }
         _loc3_ = getRandomSkillCost();
         if(_loc4_ >= _loc3_)
         {
            quitSkill();
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function quitSkill() : void
      {
         if(!_data)
         {
            return;
         }
         PetSocketOut.quitSkill(_data.petId,_quitSkill,_learnSkillUseBind);
      }
      
      private function getForgetSkillCost() : int
      {
         var _loc2_:int = 200;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("pet_forget_skill");
         if(_loc1_)
         {
            _loc2_ = parseInt(_loc1_.ConfigValue);
         }
         return _loc2_;
      }
      
      private function __systimeUpdateHandler(param1:PlayerEvent) : void
      {
         var _loc2_:int = intervalTime - (playerModel.sysCurTimeBySecond - _lastFreeSkillLearnDate.time / 1000);
         if(!checkFreeSkillTime())
         {
            _lastFreeText.text = LanguageMgr.GetTranslation("pet.PetLearnSkillView.lastFreeText1",DateFormatter.getCountDate(_loc2_,2,3));
         }
         else
         {
            _lastFreeText.text = LanguageMgr.GetTranslation("pet.PetLearnSkillView.lastFreeText2");
         }
      }
      
      private function __freeSkillTimeHandler(param1:PlayerEvent) : void
      {
         _lastFreeSkillLearnDate = DateFormatter.parse(playerInfo.lastFreeSkillLearnTime,"YYYY-MM-DD hh:mm:ss");
         __systimeUpdateHandler(null);
      }
      
      private function checkFreeSkillTime() : Boolean
      {
         var _loc1_:int = playerModel.sysCurTimeBySecond - _lastFreeSkillLearnDate.time / 1000;
         if(_loc1_ > intervalTime)
         {
            return true;
         }
         return false;
      }
      
      public function get intervalTime() : int
      {
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("pet_learn_random_skill_interval");
         if(_loc1_)
         {
            return (int(_loc1_.ConfigValue) - para1) * 60;
         }
         return 0;
      }
      
      private function get para1() : int
      {
         var _loc1_:VipPrerogativeInfo = null;
         if(vipInfo.IsVipAndNoExpirt)
         {
            _loc1_ = VIPManager.Instance.getVipPrerogativeByTypeAndGrade(205,vipInfo.VipGrade);
            return int(_loc1_.para1);
         }
         return 0;
      }
      
      private function get vipInfo() : VipInfo
      {
         return VIPManager.Instance.model.vipInfo;
      }
      
      public function get fastKey() : String
      {
         var _loc3_:int = 0;
         var _loc2_:PetSkillItemViewII = null;
         var _loc1_:String = "";
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = _skillItemList[_loc3_] as PetSkillItemViewII;
            if(_loc2_.data)
            {
               _loc1_ += _loc2_.data.SonType + ",";
            }
            else
            {
               _loc1_ += "-1,";
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         if(_data != param1)
         {
            _data = param1;
            _showView.data = param1;
         }
         if(_data)
         {
            if(_data.template)
            {
               this.petType = _data.template.PetType;
            }
            updateSkill();
         }
         updateState();
         updateIsLearned();
         _scrollPanel.invalidateViewport();
      }
      
      private function updateState() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(_data)
         {
            _loc2_ = int(_data.grade);
         }
         _learnBtn.visible = true;
         _successRateLabel.visible = true;
         for each(_loc1_ in _skillItemList)
         {
            _loc1_.isLock = false;
         }
      }
      
      private function updateSkill() : void
      {
         var _loc1_:PetSkillItemViewII = null;
         var _loc2_:SkillTempInfo = null;
         for each(_loc1_ in _skillItemList)
         {
            _loc1_.data = null;
         }
         if(!_data)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc4_:Array = _data.petFastKeyOfString.split(",");
         for each(_loc2_ in _data.activeSkillList)
         {
            if(_loc2_)
            {
               _loc3_ = _loc4_.indexOf(_loc2_.SonType.toString());
               _loc1_ = _skillItemList[_loc3_] as PetSkillItemViewII;
               if(_loc1_)
               {
                  _loc1_.data = _loc2_;
               }
            }
         }
         _loc3_ = 5;
         for each(_loc2_ in _data.passiveSkillList)
         {
            if(_loc2_)
            {
               _loc1_ = _skillItemList[_loc3_] as PetSkillItemViewII;
               if(_loc1_)
               {
                  _loc1_.data = _loc2_;
               }
               _loc3_++;
            }
         }
         _loc2_ = null;
      }
      
      public function get petType() : int
      {
         return _petType;
      }
      
      public function set petType(param1:int) : void
      {
         if(_petType == param1)
         {
            return;
         }
         _petType = param1;
         _books = _shopModel.petSkillBookDic[_petType];
         _current = 1;
         _total = Math.ceil(_books.length / 25);
         setBtnState();
         bindSkillBooks();
      }
      
      private function bindSkillBooks() : void
      {
         var line:int;
         var j:int;
         var item2:PetSkillBookItemView;
         var id:int;
         var i:int;
         var goods:GoodsTemplateInfo;
         var item:PetSkillBookItemView;
         if(_books == null)
         {
            _books = _shopModel.petSkillBookDic[_petType];
         }
         if(_books.length > _bookItemList.length)
         {
            line = Math.ceil((_books.length - _bookItemList.length) / 5);
            j = 0;
            while(j < line * 5)
            {
               item2 = new PetSkillBookItemView();
               _tile2.appendItem(item2);
               _bookItemList.push(item2);
               j = j + 1;
            }
            id = int(setTimeout(function():void
            {
               clearTimeout(id);
               if(_scrollPanel)
               {
                  _scrollPanel.invalidateViewport();
                  _scrollPanel.commitChanges();
               }
            },150));
         }
         i = 0;
         while(i < _bookItemList.length)
         {
            goods = _books[i + (_current - 1) * 25] as GoodsTemplateInfo;
            item = _bookItemList[i] as PetSkillBookItemView;
            item.data = goods;
            if(_data && goods)
            {
               item.isLearned = _data.checkSkillIsLearned(goods.Property1);
            }
            i = i + 1;
         }
      }
      
      private function updateIsLearned() : void
      {
         if(!_data)
         {
            return;
         }
         for each(var _loc1_:PetSkillBookItemView in _bookItemList)
         {
            if(_loc1_.data)
            {
               _loc1_.isLearned = _data.checkSkillIsLearned(_loc1_.data.Property1);
            }
         }
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _data = null;
         _shopModel = null;
      }
   }
}

