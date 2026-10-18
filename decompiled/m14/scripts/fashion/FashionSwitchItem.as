package fashion
{
   import bag.datas.GoodsSonType;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FashionEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FashionManager;
   import managers.ShopManager;
   import mvc.module.fashion.FashionModel;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerBufferInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerBufferManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class FashionSwitchItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _bottomBg:Bitmap;
      
      private var _new:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _item:BaseItemView;
      
      private var _data:GoodsTemplateInfo;
      
      private var _model:FashionModel = FrameControllerManager.instance.fashionCodeController.model;
      
      private var _identityBtn:IconButton;
      
      private var _overBg:Scale9CornerImage;
      
      private var _tempMc:MovieClip;
      
      private var _hitSprite:Sprite;
      
      private var _profile:ScaleFrameImage;
      
      private var _noOpenImg:Bitmap;
      
      private var _lockImg:Bitmap;
      
      private var _blockImg:Bitmap;
      
      private var _hbox:HBox;
      
      public function FashionSwitchItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchItem.FashionItemBg");
         _bottomBg = ComponentFactory.Instance.creatBitmap("asset.FashionSwitchItem.NormalItemBg");
         _new = ComponentFactory.Instance.creatBitmap("asset.FashionSwitchItem.NewImage");
         _item = ComponentFactory.Instance.creatCustomObject("FashionSwitchItem.GoodsItem");
         _name = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchItem.NameText");
         _overBg = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchItem.MouseOver");
         _identityBtn = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchItem.identityBtn");
         _identityBtn.text = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.noIdentity");
         _tempMc = ComponentFactory.Instance.creat("asset.core.TaskRewardButtonMc3");
         _tempMc.gotoAndStop(1);
         _tempMc.pos.mouseEnabled = false;
         _tempMc.mouseEnabled = false;
         _tempMc.pos.addChild(_identityBtn);
         _profile = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchItem.profile");
         _profile.mouseEnabled = _profile.mouseChildren = false;
         _noOpenImg = ComponentFactory.Instance.creat("asset.FashionSwitchItem.ItemNoOpen");
         _noOpenImg.x = 13;
         _noOpenImg.y = 115;
         _lockImg = ComponentFactory.Instance.creat("asset.FashionSwitchItem.ItemLock");
         _lockImg.x = 25;
         _lockImg.y = 25;
         _blockImg = ComponentFactory.Instance.creat("asset.FashionSwitchItem.BlockImage");
         _blockImg.x = 3;
         _blockImg.y = 140;
         _identityBtn.visible = false;
         addChild(_bg);
         addChild(_bottomBg);
         addChild(_overBg);
         addChild(_item);
         addChild(_new);
         addChild(_profile);
         addChild(_name);
         _hbox = new HBox();
         _hbox.spacing = 1;
         _hbox.x = 8;
         _hbox.y = 85;
         if(VersionSwitch.FASHION_APPRAISAL)
         {
            addChild(_tempMc);
            addChild(_hbox);
         }
         else
         {
            addChild(_blockImg);
         }
         addChild(_noOpenImg);
         addChild(_lockImg);
         _hitSprite = new Sprite();
         _hitSprite.mouseEnabled = false;
         _item.icon.hitArea = _hitSprite;
         addChild(_hitSprite);
         sizeHitSprite(0);
         _overBg.visible = false;
         _new.visible = false;
         _noOpenImg.visible = false;
         _lockImg.visible = false;
         _profile.setFrame(1);
         _bg.setFrame(1);
      }
      
      private function sizeHitSprite(param1:int = 0) : void
      {
         if(param1 == 0)
         {
            _hitSprite.graphics.clear();
            _hitSprite.graphics.beginFill(0,0);
            _hitSprite.graphics.drawRect(0,0,100,140);
            _hitSprite.graphics.endFill();
         }
         else
         {
            _hitSprite.graphics.clear();
            _hitSprite.graphics.beginFill(0,0);
            _hitSprite.graphics.drawRect(0,0,100,170);
            _hitSprite.graphics.endFill();
         }
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_new);
         _new = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_identityBtn);
         _identityBtn = null;
         ObjectUtils.disposeObject(_tempMc);
         _tempMc = null;
         ObjectUtils.disposeObject(_hitSprite);
         _hitSprite = null;
         ObjectUtils.disposeObject(_profile);
         _profile = null;
         ObjectUtils.disposeObject(_noOpenImg);
         _noOpenImg = null;
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
         ObjectUtils.disposeObject(_blockImg);
         _blockImg = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         removeEventListener("click",__clickHandler);
      }
      
      public function get data() : GoodsTemplateInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsTemplateInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc1_:SkillTempInfo = null;
         var _loc4_:String = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:ShopGoodsInfo = null;
         clean();
         if(_data)
         {
            buttonMode = true;
            _identityBtn.visible = true;
            if(_noOpenImg)
            {
               _noOpenImg.visible = false;
            }
            if(_lockImg)
            {
               _lockImg.visible = false;
            }
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _data.TemplateId;
            _loc1_ = fashionModel.getFashionObjectSkillTemplate(_data);
            _loc4_ = _loc1_ != null ? _loc1_.TemplateName : "";
            _loc6_ = int(_loc1_ != null ? _loc1_.Grades : 0);
            _loc5_.appraisal_skill = _loc1_ != null ? _loc1_.TemplateId : 0;
            if(VersionSwitch.FASHION_APPRAISAL && _hbox)
            {
               addFashionStar(_loc6_);
            }
            if(fashionModel.hasIdentityedBook(_data.TemplateId))
            {
               if(fashionModel.hasRefreshFull(_data.TemplateId))
               {
                  _identityBtn.tipData = null;
                  _identityBtn.text = _loc4_;
                  _identityBtn.icon.visible = false;
                  _identityBtn.backgoundInnerRectString = "0,100,6,19,13";
               }
               else
               {
                  _loc3_ = int(fashionModel.getCountForRefresh(_data));
                  _identityBtn.tipData = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.refreshTipTxt",_loc3_,"");
                  _identityBtn.text = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.refreshTxt");
                  _identityBtn.icon.visible = false;
                  _identityBtn.backgoundInnerRectString = "0,100,6,19,13";
               }
            }
            else
            {
               _loc3_ = int(fashionModel.getCountForIdentityBook(_data));
               _loc2_ = int(fashionModel.getSuccessRateForIdentityBook(_data));
               _identityBtn.text = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.noIdentity");
               _identityBtn.icon.visible = true;
               _identityBtn.backgoundInnerRectString = "5,100,6,19,13";
               updateIndentityBtnTip();
            }
            _identityBtn.enable = _data.TemplateId in fashionModel.bookList;
            if(_data.TransformId > 0 && _data.TransformId < 6)
            {
               _profile.visible = true;
               _profile.setFrame(_data.TransformId);
            }
            if(_item)
            {
               _item.data = _loc5_;
            }
            if(_name)
            {
               _name.htmlText = "<font color=\'" + GoodsSonType.getColorByProfile(_data.Profile) + "\'>" + _data.TemplateName + "</font>";
            }
            if(_data.TemplateId in fashionModel.bookList)
            {
               setFilters(null);
               if(_new)
               {
                  _new.visible = fashionModel.bookList[_data.TemplateId] != true;
               }
               sizeHitSprite(0);
               if(_bg)
               {
                  _bg.setFrame(2);
               }
               _identityBtn.visible = true;
            }
            else
            {
               if(_bg)
               {
                  _bg.setFrame(1);
               }
               setFilters([UIFilter.getGrayFilter()]);
               sizeHitSprite(1);
               _loc7_ = TempleteManager.instance.getShopTempInfoByItemId(_data.TemplateId);
               if(_loc7_)
               {
                  _identityBtn.visible = true;
               }
               else
               {
                  _identityBtn.visible = true;
               }
            }
         }
      }
      
      private function addFashionStar(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Bitmap = null;
         var _loc2_:Bitmap = null;
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            if(_loc4_ < param1)
            {
               _loc3_ = ComponentFactory.Instance.creatBitmap("asset.fashion.StarLevelLightImg");
               _hbox.addChild(_loc3_);
            }
            else
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.fashion.StarLeveldarkImg");
               _hbox.addChild(_loc2_);
            }
            _loc4_++;
         }
      }
      
      private function setFilters(param1:Array) : void
      {
         if(_bg)
         {
            _bg.filters = param1;
         }
         if(_bottomBg)
         {
            _bottomBg.filters = param1;
         }
         if(_new)
         {
            _new.filters = param1;
         }
         if(_name)
         {
            _name.filters = param1;
         }
         if(_item)
         {
            _item.filters = param1;
         }
         if(_identityBtn)
         {
            _identityBtn.filters = param1;
         }
         if(_overBg)
         {
            _overBg.filters = param1;
         }
         if(_tempMc)
         {
            _tempMc.filters = param1;
         }
         if(_hitSprite)
         {
            _hitSprite.filters = param1;
         }
         if(_profile)
         {
            _profile.filters = param1;
         }
         if(_noOpenImg)
         {
            _noOpenImg.filters = param1;
         }
         if(_lockImg)
         {
            _lockImg.filters = param1;
         }
      }
      
      private function clean() : void
      {
         if(_new)
         {
            _new.visible = false;
         }
         if(_item)
         {
            _item.data = null;
         }
         if(_name)
         {
            _name.text = "";
         }
         if(_identityBtn)
         {
            _identityBtn.visible = false;
            _identityBtn.tipData = null;
         }
         this.buttonMode = false;
         if(_tempMc)
         {
            _tempMc.gotoAndStop(1);
         }
         if(_bg)
         {
            _bg.setFrame(1);
         }
         if(_profile)
         {
            _profile.visible = false;
         }
         if(_noOpenImg)
         {
            _noOpenImg.visible = true;
         }
         if(_lockImg)
         {
            _lockImg.visible = true;
         }
         if(_hbox)
         {
            _hbox.removeAllChild();
         }
         setFilters([UIFilter.getGrayFilter()]);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         if(!_data)
         {
            return;
         }
         if(_data.TemplateId in fashionModel.bookList && fashionModel.bookList[_data.TemplateId] == false)
         {
            FashionManager.instance.disenableNewIcon(_data.TemplateId);
         }
         if(param1.target == _identityBtn)
         {
            identityBtnClickHandler();
         }
         else
         {
            _loc2_ = !(_data.TemplateId in fashionModel.bookList);
            dispatchEvent(new FashionEvent("FASHION_BOOK_WEAR",{
               "book":_loc2_,
               "data":_data
            },true));
         }
      }
      
      private function activityBtnClickHandler() : void
      {
         SoundManager.instance.play("022");
         if(!_data)
         {
            return;
         }
         SimpleAlertHelper.instance.data = [__resultHandler,_data.TemplateId];
         var _loc5_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(_data.TemplateId);
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.activityBtn.tipData",_data.TemplateName,_loc5_.price);
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc5_.GiftToken);
      }
      
      private function __resultHandler(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc5_:ShopGoodsInfo = null;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc5_ = TempleteManager.instance.getShopTempInfoByItemId(_data.TemplateId);
            _loc4_ = 1;
            if(param2)
            {
               _loc4_ = 2;
            }
            ShopManager.Instance.buyOne(_loc5_.Id,1,playerInfo.userId,_loc4_,false);
         }
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function identityBtnClickHandler() : void
      {
         var _loc1_:String = null;
         var _loc5_:int = 0;
         var _loc7_:String = null;
         SoundManager.instance.play("022");
         if(_tempMc && _tempMc.isPlaying)
         {
            _tempMc.gotoAndStop(1);
         }
         if(!_data)
         {
            return;
         }
         var _loc4_:ThaneInfo = ArmyManager.instance.thane;
         if(fashionModel.hasRefreshFull(_data.TemplateId))
         {
            _loc1_ = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.identityedFull");
         }
         else if(_loc4_.grades < 27)
         {
            _loc1_ = LanguageMgr.GetTranslation("BattleGuardView.needGrade",27);
         }
         if(_loc1_)
         {
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         if(!fashionModel.hasIdentityedBook(_data.TemplateId))
         {
            _loc5_ = (6 - _data.TransformId) * 200000;
            _loc7_ = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.identityContent",_loc5_);
         }
         else
         {
            _loc5_ = int(fashionModel.getCountForRefresh(_data));
            _loc7_ = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.refreshContent",_loc5_);
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [indentityCallBack,_data];
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,true,true);
      }
      
      private function indentityCallBack(param1:Boolean, param2:Boolean, param3:GoodsTemplateInfo) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc6_:int = 0;
         if(!fashionModel.hasIdentityedBook(param3.TemplateId))
         {
            _loc6_ = (6 - _data.TransformId) * 200000;
            if(_loc6_ > ResourceManager.instance.gold.count)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.gold"));
               return;
            }
         }
         else
         {
            _loc6_ = int(fashionModel.getCountForRefresh(_data));
            _loc4_ = int(GoodsManager.instance.getGoodsNumByTempId(208020));
            _loc5_ = _loc6_ - _loc4_;
            if(_loc5_ > 0)
            {
               CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback,[208020,_loc5_]);
               return;
            }
         }
         FashionManager.instance.identityBook(param3.TemplateId);
      }
      
      private function quickUIcallback(param1:Array) : void
      {
         var _loc2_:BuyFrameI = null;
         var _loc3_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(param1[0]);
         if(_loc3_)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
            _loc2_.data(_loc3_,param1[1]);
            _loc2_.show();
         }
      }
      
      public function setFrame(param1:int) : void
      {
         if(!_overBg)
         {
            return;
         }
         if(param1 == 2)
         {
            _overBg.visible = true;
         }
         else
         {
            _overBg.visible = false;
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         _overBg.visible = true;
         if(!fashionModel.hasIdentityedBook(_data.TemplateId))
         {
            updateIndentityBtnTip();
         }
      }
      
      private function updateIndentityBtnTip() : void
      {
         var _loc4_:String = null;
         var _loc2_:int = (6 - _data.TransformId) * 200000;
         var _loc1_:int = int(fashionModel.getSuccessRateForIdentityBook(_data));
         var _loc3_:PlayerBufferInfo = PlayerBufferManager.instance.getItemBufferInfo(20000);
         if(_loc3_)
         {
            _loc4_ = _loc1_ + "<font color=\'#79f050\'>+" + _loc3_.rateCount + "</font>";
            _loc4_ = " " + LanguageMgr.GetTranslation("fashion.view.compose.composeRate") + _loc4_ + "%";
         }
         else
         {
            _loc4_ = "" + _loc1_;
            _loc4_ = "  " + LanguageMgr.GetTranslation("fashion.view.compose.composeRate") + _loc4_ + "%";
         }
         _identityBtn.tipData = LanguageMgr.GetTranslation("fashion.FashionSwitchItem.identityTipTxt",_loc2_,"") + "\n" + _loc4_;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(fashionModel.lookDragonTalkerFashion)
         {
            if(_data && fashionModel.isInDragonTalkerSaveList(_data.TemplateId))
            {
               _overBg.visible = true;
            }
            else
            {
               _overBg.visible = false;
            }
         }
         else if(_data && fashionModel.isInSaveList(_data.TemplateId))
         {
            _overBg.visible = true;
         }
         else
         {
            _overBg.visible = false;
         }
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      override public function get height() : Number
      {
         return 173;
      }
      
      override public function get width() : Number
      {
         return 104;
      }
      
      public function flash() : void
      {
         if(_tempMc)
         {
            _tempMc.play();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_item)
         {
            _item.filters = null;
         }
         if(_name)
         {
            _name.filters = null;
         }
         uintView();
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _model = null;
      }
   }
}

