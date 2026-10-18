// @ts-nocheck
export const defs = {};
export const deps = {};
defs["tasktracetip.view.AddPawnTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __AddPawnTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.AddPawnTipView.txt");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = this._data.content;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         if($.C("map.campaign.CampaignManager").instance.mapModel && ($.C("map.campaign.CampaignManager").instance.mapModel.mapId == 10001 || $.C("map.campaign.CampaignManager").instance.mapModel.mapId == 10002))
         {
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
         else
         {
            $.C("yishi.manager.FrameControllerManager").instance.armyController.startFrameByType($.C("yishi.datas.consant.ArmyPanelEnum").RECRUIT_PAWN);
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
      }
    check() {
         return false;
      }
    get data() { return super.data; }
  }
  $.meta(__AddPawnTipView, "tasktracetip.view.AddPawnTipView", []);
  return __AddPawnTipView;
}
deps["tasktracetip.view.AddPawnTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "map.campaign.CampaignManager", "tasktracetip.view.TaskTraceTipView", "yishi.datas.consant.ArmyPanelEnum", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.AntaeusBattleFailureTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __AntaeusBattleFailureTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.GetGiftBtn");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.AntaeusBattleFailureTipView.ContentTxt");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("gameguide.GameGuideFrame.skipNow");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("antaeus");
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    check() {
         return false;
      }
    dispose() {
         this.removeEvent();
         super.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    get data() { return super.data; }
  }
  $.meta(__AntaeusBattleFailureTipView, "tasktracetip.view.AntaeusBattleFailureTipView", []);
  return __AntaeusBattleFailureTipView;
}
deps["tasktracetip.view.AntaeusBattleFailureTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.AntaeusMeetTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __AntaeusMeetTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.GetGiftBtn");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.AntaeusMeetTipView.ContentTxt");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("gameguide.GameGuideFrame.skipNow");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("antaeus");
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    check() {
         return false;
      }
    dispose() {
         this.removeEvent();
         super.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    get data() { return super.data; }
  }
  $.meta(__AntaeusMeetTipView, "tasktracetip.view.AntaeusMeetTipView", []);
  return __AntaeusMeetTipView;
}
deps["tasktracetip.view.AntaeusMeetTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.ApexStartTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __ApexStartTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.ConsortiaIcon");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("gameguide.GameGuideFrame.skipNow");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
         this.addChild(this._icon);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = this._data.content;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("apex",1);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(51);
      }
    check() {
         return false;
      }
    get data() { return super.data; }
  }
  $.meta(__ApexStartTipView, "tasktracetip.view.ApexStartTipView", []);
  return __ApexStartTipView;
}
deps["tasktracetip.view.ApexStartTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.BetterGoodsTipsView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __BetterGoodsTipsView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("taskTraceTips.ItemView");
         this._icon.iconBack = $.bind(this, "iconLoadComplete");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._contentTxt.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.BetterGoodsTipsView.tips");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.BetterGoodsTipsView.text");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         if(!$.C("bag.helper.GoodsCheck").checkGoodsBetterThanHero(this._data.goods))
         {
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this._data.type);
            return;
         }
         this._textBtn.enable = false;
         this._icon.data = this._data.goods;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    iconLoadComplete(param1 = null) {
         this._textBtn.enable = true;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         var _loc4_ = null;
         var _loc3_ = null;
         var _loc9_ = 0;
         var _loc10_ = 0;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc7_ = null;
         var _loc11_ = null;
         super.__btnHandler(param1);
         if(!this._data || !this._data.goods)
         {
            this.dispose();
            return;
         }
         $.C("yishi.manager.FrameControllerManager").instance.armyController.model.currentPage = $.int(this._data.goods.pos / 56) + 1;
         var _loc8_ = $.C("yishi.manager.GoodsManager").instance.getGoodsByGoodsIdFromGeneralBag(this._data.goods.id);
         if(_loc8_ == null)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.BetterGoodsTipsView.command01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
            return;
         }
         if(!$.C("bag.helper.GoodsCheck").checkGoodsBetterThanHero(_loc8_))
         {
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
            return;
         }
         if(_loc8_)
         {
            _loc4_ = $.C("yishi.manager.GoodsManager").instance.getHeroGoodsListBySonTypeAndId(_loc8_.templateInfo.SonType,this.thane.id).getList();
            _loc3_ = $.C("bag.datas.GoodsSonType").getSonTypePos(_loc8_.templateInfo.SonType);
            _loc9_ = $.int(_loc3_[0]);
            _loc10_ = 0;
            if(_loc3_.length > 1)
            {
               if(_loc3_.length > _loc4_.length)
               {
                  _loc9_ = $.int(_loc3_[_loc4_.length]);
               }
            }
            if($.C("yishi.manager.FrameControllerManager").instance.armyController.model.currentOpenPanel == $.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL)
            {
               _loc5_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
            }
            if(!_loc5_)
            {
               $.C("yishi.manager.FrameControllerManager").instance.armyController.startFrameByType($.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL,$.bind(this, "callBack"));
            }
            else
            {
               _loc5_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
               _loc5_["defaultContent"] = $.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL;
               _loc6_ = this.getDragIconObj(_loc8_);
               _loc7_ = _loc5_["equipView"].getItemViewByPos(_loc9_);
               _loc11_ = _loc7_.parent.localToGlobal(new ($.C("flash.geom.Point"))(_loc7_.x,_loc7_.y));
               _loc6_.x = this._icon.parent.localToGlobal(new ($.C("flash.geom.Point"))(this._icon.x,this._icon.y)).x;
               _loc6_.y = this._icon.parent.localToGlobal(new ($.C("flash.geom.Point"))(this._icon.x,this._icon.y)).y;
               $.C("com.pickgliss.toplevel.StageReferance").stage.addChild(_loc6_);
               $.C("com.greensock.TweenMax").to(_loc6_,2,{
                  "x":_loc11_.x,
                  "y":_loc11_.y,
                  "onComplete":$.bind(this, "complete"),
                  "onCompleteParams":[_loc8_,_loc7_,_loc6_,_loc9_]
               });
               $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
            }
         }
      }
    callBack() {
         var _loc1_ = null;
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc8_ = 0;
         var _loc9_ = 0;
         var _loc7_ = $.C("yishi.manager.GoodsManager").instance.getGoodsByGoodsIdFromGeneralBag(this._data.goods.id);
         if(_loc7_ == null)
         {
            _loc1_ = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.BetterGoodsTipsView.command01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc1_);
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
            return;
         }
         if(!$.C("bag.helper.GoodsCheck").checkGoodsBetterThanHero(_loc7_))
         {
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
            return;
         }
         var _loc3_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(_loc3_)
         {
            _loc3_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
            _loc3_["show"]();
         }
         if(_loc7_)
         {
            _loc4_ = $.C("yishi.manager.GoodsManager").instance.getHeroGoodsListBySonTypeAndId(_loc7_.templateInfo.SonType,this.thane.id).getList();
            _loc2_ = $.C("bag.datas.GoodsSonType").getSonTypePos(_loc7_.templateInfo.SonType);
            _loc8_ = $.int(_loc2_[0]);
            _loc9_ = 0;
            if(_loc2_.length > 1)
            {
               if(_loc2_.length > _loc4_.length)
               {
                  _loc8_ = $.int(_loc2_[_loc4_.length]);
               }
            }
         }
         var _loc5_ = this.getDragIconObj(_loc7_);
         var _loc6_ = _loc3_["equipView"].getItemViewByPos(_loc8_);
         var _loc10_ = _loc6_.parent.localToGlobal(new ($.C("flash.geom.Point"))(_loc6_.x,_loc6_.y));
         var _loc11_ = _loc3_["equipBag"].getBaseBagItemByPos(this._data.goods.pos);
         _loc11_.mouseChildren = _loc11_.mouseEnabled = false;
         _loc5_.x = this._icon.parent.localToGlobal(new ($.C("flash.geom.Point"))(this._icon.x,this._icon.y)).x;
         _loc5_.y = this._icon.parent.localToGlobal(new ($.C("flash.geom.Point"))(this._icon.x,this._icon.y)).y;
         $.C("com.pickgliss.toplevel.StageReferance").stage.addChild(_loc5_);
         $.C("com.greensock.TweenMax").to(_loc5_,2,{
            "x":_loc10_.x,
            "y":_loc10_.y,
            "onComplete":$.bind(this, "complete"),
            "onCompleteParams":[_loc7_,_loc6_,_loc5_,_loc8_]
         });
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    complete(param1, param2, param3, param4) {
         if (typeof param4 !== "number" || (param4 | 0) !== param4) param4 = $.int(param4);
         var _loc6_ = null;
         $.C("com.greensock.TweenMax").killTweensOf(param3);
         $.C("yishi.manager.PlayerManager").instance.moveBagToBag(param1.bagType,param1.objectId,param1.pos,4,this.thane.id,param4,1);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(param3);
         param3 = null;
         param2 = null;
         var _loc5_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(_loc5_ && this._data)
         {
            _loc6_ = _loc5_["equipBag"].getBaseBagItemByPos(param1.pos);
            _loc6_.mouseChildren = _loc6_.mouseEnabled = true;
         }
      }
    getDragIconObj(param1) {
         var _loc2_ = null;
         var _loc4_ = null;
         var _loc3_ = new ($.C("flash.display.Sprite"))();
         var _loc5_ = this._icon.icon.content;
         if(param1 && _loc5_)
         {
            _loc2_ = new ($.C("flash.display.BitmapData"))(_loc5_.width / _loc5_.scaleX,_loc5_.height / _loc5_.scaleY,true,0);
            _loc2_.draw(_loc5_);
            _loc4_ = new ($.C("flash.display.Bitmap"))(_loc2_);
            _loc4_.alpha = 1;
            _loc4_.width = 54;
            _loc4_.height = 54;
            _loc3_.addChild(_loc4_);
         }
         return _loc3_;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    dispose() {
         if(this._icon)
         {
            this._icon.dispose();
         }
         this._icon = null;
         if(this._contentTxt)
         {
            this._contentTxt.dispose();
         }
         this._contentTxt = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__BetterGoodsTipsView, "tasktracetip.view.BetterGoodsTipsView", []);
  return __BetterGoodsTipsView;
}
deps["tasktracetip.view.BetterGoodsTipsView"] = ["bag.datas.GoodsSonType", "bag.helper.GoodsCheck", "com.greensock.TweenMax", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Bitmap", "flash.display.BitmapData", "flash.display.Sprite", "flash.geom.Point", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.datas.consant.ArmyPanelEnum", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.manager.GoodsManager", "yishi.manager.PlayerManager", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.BufferDisapearTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __BufferDisapearTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("public.confirm");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         var _loc4_ = $.as(param1.data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"));
         var _loc5_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc4_.goodsTemplateId);
         var _loc2_ = _loc5_ ? $.C("yishi.utils.GoodsHelp").getGoodColorString(_loc5_.Profile) : $.C("yishi.utils.GoodsHelp").getGoodColorString(3);
         var _loc3_ = "[<font color=" + _loc2_ + ">" + _loc4_.name + "</font>]";
         var _loc6_ = $.C("manager.LanguageMgr").GetTranslation("public.BufferDisapear");
         this._contentTxt.htmlText = _loc3_ + _loc6_;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__BufferDisapearTipView, "tasktracetip.view.BufferDisapearTipView", []);
  return __BufferDisapearTipView;
}
deps["tasktracetip.view.BufferDisapearTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.datas.playerinfo.PlayerBufferInfo", "yishi.manager.TempleteManager", "yishi.utils.GoodsHelp"];

defs["tasktracetip.view.BuyBloodTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __BuyBloodTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         if($.C("yishi.manager.GoodsManager").instance.getGoodsNumBySonType(209) == 0)
         {
            this._contentTxt.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.BuyBloodTipView.content01");
            this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.BuyBloodTipView.text01");
            this._textBtn.width = 125;
         }
         else
         {
            this._contentTxt.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.BuyBloodTipView.content02");
            this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.BuyBloodTipView.text02");
         }
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc4_ = null;
         super.__btnHandler(param1);
         if($.C("yishi.manager.GoodsManager").instance.getGoodsNumBySonType(209) == 0)
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.createComponentGroupByStylename("resourcesBar.QuickBuyFrame");
            _loc2_.show();
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
         else
         {
            _loc3_ = $.C("yishi.manager.GoodsManager").instance.getGeneralBagGoodsBySonType(209)[0];
            if(_loc3_)
            {
               this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.BuyBloodTipView.text02");
               this._contentTxt.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.BuyBloodTipView.content02");
               $.C("yishi.manager.FrameControllerManager").instance.armyController.model.currentPage = $.int(_loc3_.pos / 56) + 1;
               _loc4_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
               if(!_loc4_ || _loc4_ && _loc4_.stylename != "army.ArmyFrameII")
               {
                  $.C("yishi.manager.FrameControllerManager").instance.armyController.startFrameByType($.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL,$.bind(this, "back"));
               }
               else
               {
                  _loc4_["defaultContent"] = $.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL;
                  _loc4_["equipBag"].showEffectBySontype(209);
                  _loc4_["equipBag"].showFilterBySontype(209);
                  $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
               }
            }
         }
      }
    back() {
         var _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(_loc1_)
         {
            _loc1_["equipBag"].showEffectBySontype(209);
            _loc1_["equipBag"].showFilterBySontype(209);
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
      }
    check() {
         return false;
      }
    get data() { return super.data; }
  }
  $.meta(__BuyBloodTipView, "tasktracetip.view.BuyBloodTipView", []);
  return __BuyBloodTipView;
}
deps["tasktracetip.view.BuyBloodTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.datas.consant.ArmyPanelEnum", "yishi.manager.FrameControllerManager", "yishi.manager.GoodsManager"];

defs["tasktracetip.view.CampaignCardTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __CampaignCardTipView extends __Base {
    static $fields(self) {
    self.txt = null;
    self.btn = null;
    }
    constructor() {
         super();
      }
    initView() {
         var _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTrace.card.bg");
         var _loc4_ = _loc3_.bitmapData;
         var _loc8_ = new ($.C("flash.display.Bitmap"))(_loc4_);
         var _loc7_ = _loc8_.transform.matrix;
         _loc7_.a = -1;
         _loc7_.tx = _loc8_.width;
         _loc8_.transform.matrix = _loc7_;
         _loc8_.x = _loc3_.width * 2;
         var _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTrace.card.titlebg");
         _loc6_.x = 55;
         _loc6_.y = -20;
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTrace.campaigncard.title");
         _loc2_.x = 78;
         _loc2_.y = -5;
         var _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTrace.card.itembg");
         _loc5_.x = 55;
         _loc5_.y = 30;
         var _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("campaign.campaignCardIcon");
         this.txt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vip.vipCardTxt");
         var _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vip.vipCardTipTxt");
         _loc1_.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.campaignCommand01");
         this.btn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("campaign.useCampaignCardBtn");
         this.addChild(_loc3_);
         this.addChild(_loc8_);
         this.addChild(_loc6_);
         this.addChild(_loc2_);
         this.addChild(_loc5_);
         this.addChild(_loc9_);
         this.addChild(this.txt);
         this.addChild(_loc1_);
         this.addChild(this.btn);
      }
    initEvent() {
         this.btn.addEventListener("click",$.bind(this, "__clickHandler"));
      }
    removeEvent() {
         if(this.btn)
         {
            this.btn.removeEventListener("click",$.bind(this, "__clickHandler"));
         }
      }
    __clickHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.useVipCard();
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    show() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
         if(this.data)
         {
            this.txt.text = this.data.goods.templateInfo.TemplateName;
         }
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,1,true,true,2);
      }
    useVipCard() {
         this.data && $.C("yishi.service.managers.SocketSendManager").instance.sendUseItem(this.data.goods.pos);
      }
    set data(param1) {
         super._data = param1;
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.removeEvent();
         if(this.btn)
         {
            this.btn.dispose();
         }
         this.btn = null;
         if(this.txt)
         {
            this.txt.dispose();
         }
         this.txt = null;
         if(this._data)
         {
            this._data.goods = null;
         }
         this._data = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__CampaignCardTipView, "tasktracetip.view.CampaignCardTipView", []);
  return __CampaignCardTipView;
}
deps["tasktracetip.view.CampaignCardTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.display.Bitmap", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.keyboard.KeyBoardRegister", "yishi.service.managers.SocketSendManager"];

defs["tasktracetip.view.ChildPatrolTaskTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __ChildPatrolTaskTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("appell.AppellFrame.AppellLink.LinkText");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = this._data.content;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         if(!$.C("yishi.SwitchPageHelp").checkScene())
         {
            return;
         }
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("childpatrol",1);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__ChildPatrolTaskTipView, "tasktracetip.view.ChildPatrolTaskTipView", []);
  return __ChildPatrolTaskTipView;
}
deps["tasktracetip.view.ChildPatrolTaskTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.SwitchPageHelp", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.ConsortiaEmeDreamTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __ConsortiaEmeDreamTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.ConsortiaBossIcon");
         this._icon.tipStyle = "yishi.view.tips.OneLineTip";
         this._icon.tipData = $.C("manager.LanguageMgr").GetTranslation("consortia.view.myConsortia.activity.ConsortiaBossFrame.titleText");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("gameguide.GameGuideFrame.skipNow");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
         this.addChild(this._icon);
         this.__switchHandler(null,null);
      }
    initEvent() {
         super.initEvent();
         $.C("yishi.utils.MsgMan").addObserver("CampaignEvent.CONSORTIA_BOSS_SWITCH",this,$.bind(this, "__switchHandler"));
      }
    removeEvent() {
         super.removeEvent();
         $.C("yishi.utils.MsgMan").removeObserver("CampaignEvent.CONSORTIA_BOSS_SWITCH",this,$.bind(this, "__switchHandler"));
      }
    __switchHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this.model.emeDreamInfo.state != 1 && this.model.emeDreamInfo.state != 2)
         {
            $.C("managers.TaskTraceTipManager").instance.cleanByType(42);
         }
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = this._data.content;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         super.__btnHandler(param1);
         if($.C("managers.MopupManager").instance.model.isMopup)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("mopup.MopupManager.mopupTipData01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if(this.model.emeDreamInfo.state != 1 && this.model.emeDreamInfo.state != 2)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("consortia.view.myConsortia.activity.ConsortiaActivityListView.emeDreamPromptTxt" + this.model.emeDreamInfo.state);
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if(this.checkScene())
         {
            $.C("managers.ConsortiaSocketOutManager").enterConsortiaBoss();
         }
         $.C("managers.TaskTraceTipManager").instance.cleanByType(56);
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    get model() {
         return $.C("yishi.manager.ConsortiaManager").instance.model;
      }
    checkScene() {
         var _loc1_ = $.C("yishi.utils.WorldBossHelper").getCampaignTips();
         if($.C("yishi.utils.StringHelper").isNullOrEmpty(_loc1_))
         {
            return true;
         }
         $.C("yishi.view.tips.MessageTipManager").instance().show(_loc1_);
         return false;
      }
    check() {
         return false;
      }
    get data() { return super.data; }
    set playerInfo(v) { super.playerInfo = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__ConsortiaEmeDreamTipView, "tasktracetip.view.ConsortiaEmeDreamTipView", []);
  return __ConsortiaEmeDreamTipView;
}
deps["tasktracetip.view.ConsortiaEmeDreamTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.ConsortiaSocketOutManager", "managers.MopupManager", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.ConsortiaManager", "yishi.manager.PlayerManager", "yishi.utils.MsgMan", "yishi.utils.StringHelper", "yishi.utils.WorldBossHelper", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.ConsortiaNewBossTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __ConsortiaNewBossTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    self._icon = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.GetGiftBtn");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.ConsortiaNewBossTipView.ContentTxt");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("gameguide.GameGuideFrame.skipNow");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.ConsortiaNewBossIcon");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
         this.addChild(this._icon);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         super.__btnHandler(param1);
         if($.C("managers.FreedomTeamManager").instance.hasTeam)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("resourcebar.view.consortianewboss.inTeam");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if($.C("managers.MopupManager").instance.model.isMopup)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("mopup.MopupManager.mopupTipData01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if($.C("yishi.scene.SceneManager").instance.currentType == "BATTLE_SCENE")
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("ChatOutputViewII.tip01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if($.C("yishi.manager.FrameControllerManager").instance.landMineController.isInLandMineFrame)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("ChatOutputViewII.inLandMine.alert");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if($.C("yishi.manager.FrameControllerManager").instance.gemMazeController.isEnterGemMaze)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("ChatOutputViewII.inGemMaze.alert");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if($.C("yishi.scene.SceneManager").instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("worldboss.helper.WorldBossHelper.tip06");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         var _loc3_ = $.C("yishi.utils.WorldBossHelper").getCampaignTips();
         if(_loc3_ != "")
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc3_);
            return;
         }
         if(this.playerInfo.consortiaID == 0)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("chat.view.ChatView.consortianewboss.command");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("consortianewboss",1);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    check() {
         return false;
      }
    dispose() {
         this.removeEvent();
         super.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    get data() { return super.data; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__ConsortiaNewBossTipView, "tasktracetip.view.ConsortiaNewBossTipView", []);
  return __ConsortiaNewBossTipView;
}
deps["tasktracetip.view.ConsortiaNewBossTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.FreedomTeamManager", "managers.MopupManager", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager", "yishi.scene.SceneManager", "yishi.utils.WorldBossHelper", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.ConsortiaSkillTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __ConsortiaSkillTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.ConsortiaSkillTipView.content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.ConsortiaSkillTipView.text");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("consortia",5);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__ConsortiaSkillTipView, "tasktracetip.view.ConsortiaSkillTipView", []);
  return __ConsortiaSkillTipView;
}
deps["tasktracetip.view.ConsortiaSkillTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.ConsortiaTreasureTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __ConsortiaTreasureTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.ConsortiaIcon");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("gameguide.GameGuideFrame.skipNow");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
         this.addChild(this._icon);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = this._data.content;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("consortia",11);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(51);
      }
    check() {
         return false;
      }
    get data() { return super.data; }
  }
  $.meta(__ConsortiaTreasureTipView, "tasktracetip.view.ConsortiaTreasureTipView", []);
  return __ConsortiaTreasureTipView;
}
deps["tasktracetip.view.ConsortiaTreasureTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.DragonSoulTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __DragonSoulTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._textBtn.width = 140;
         this._textBtn.x = 40;
         this._icon.tipStyle = "yishi.view.tips.OneLineTip";
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.DragonSoulTipView.btnText");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         if(this._data)
         {
            this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap(this._data.icon);
            this._icon.tipData = this._data.name;
            this._contentTxt.htmlText = this._data.content;
            this._textBtn.text = this._data.btnTxt;
         }
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         this.dispose();
         var _loc2_ = this.checkLimit;
         if(_loc2_)
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         $.C("yishi.manager.FrameControllerManager").instance.armyController.startFrameByType($.C("yishi.datas.consant.ArmyPanelEnum").DRAGON_SOUL_PANEL);
      }
    get checkLimit() {
         if($.C("managers.MopupManager").instance.model.isMopup)
         {
            return $.C("manager.LanguageMgr").GetTranslation("mopup.MopupManager.mopupTipData01");
         }
         return null;
      }
    get data() { return super.data; }
    set checkLimit(v) { super.checkLimit = v; }
  }
  $.meta(__DragonSoulTipView, "tasktracetip.view.DragonSoulTipView", []);
  return __DragonSoulTipView;
}
deps["tasktracetip.view.DragonSoulTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.MopupManager", "tasktracetip.view.TaskTraceTipView", "yishi.datas.consant.ArmyPanelEnum", "yishi.manager.FrameControllerManager", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.EmeDreamTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __EmeDreamTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    self._icon = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.GetGiftBtn");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.EmeDreamTipView.ContentTxt");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("gameguide.GameGuideFrame.skipNow");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.EmeDreamIcon");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
         this.addChild(this._icon);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("managers.ConsortiaSocketOutManager").enterConsortiaBoss();
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    check() {
         return false;
      }
    dispose() {
         this.removeEvent();
         super.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    get data() { return super.data; }
  }
  $.meta(__EmeDreamTipView, "tasktracetip.view.EmeDreamTipView", []);
  return __EmeDreamTipView;
}
deps["tasktracetip.view.EmeDreamTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.ConsortiaSocketOutManager", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView"];

defs["tasktracetip.view.ExpBackTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __ExpBackTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("active.expback.tracetips.btntxt");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = this._data.content;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("expback");
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__ExpBackTipView, "tasktracetip.view.ExpBackTipView", []);
  return __ExpBackTipView;
}
deps["tasktracetip.view.ExpBackTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.FarmCanPickTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __FarmCanPickTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.FarmIcon");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._icon.tipStyle = "yishi.view.tips.OneLineTip";
         this._icon.tipData = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.CanPickTipView.farmTip");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.CanPickTipView.farmContent");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.CanPickTipView.text");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    show() {
         super.show();
         if(this.data && this.data.content)
         {
            this._contentTxt.htmlText = $.as(this.data.content, "String");
         }
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.CanPickTipView.farmContent" + param1.data.showType);
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         super.__btnHandler(param1);
         if($.C("managers.MopupManager").instance.model.isMopup)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("mopup.MopupManager.mopupTipData01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if($.C("yishi.scene.SceneManager").instance.currentType == "CASTLE_SCENE" || $.C("yishi.scene.SceneManager").instance.currentType == "SPACE_SCENE")
         {
            $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("farm","HOME_NEW_FRAME",this.data.data["showType"]);
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
            return;
         }
         $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("taskTrace.SinglepassHasBugleYipsView.TipInfo"));
      }
    get data() { return super.data; }
  }
  $.meta(__FarmCanPickTipView, "tasktracetip.view.FarmCanPickTipView", []);
  return __FarmCanPickTipView;
}
deps["tasktracetip.view.FarmCanPickTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.MopupManager", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager", "yishi.scene.SceneManager", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.FashionIdentityBufferTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __FashionIdentityBufferTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("fashionIdentityBufferTipView.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("fashionIdentityBufferTipView.btnText");
         this._textBtn.width = 195;
         this._textBtn.x = 10;
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = this._data.content;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.x = (188 - this._contentTxt.textWidth) * 0.5 + 12;
         this._contentTxt.y = (89 - this._contentTxt.textHeight) * 0.5 + 18;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("fashion",1);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    check() {
         return false;
      }
    get data() { return super.data; }
  }
  $.meta(__FashionIdentityBufferTipView, "tasktracetip.view.FashionIdentityBufferTipView", []);
  return __FashionIdentityBufferTipView;
}
deps["tasktracetip.view.FashionIdentityBufferTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.FateGuardTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __FateGuardTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("gameguide.GameGuideFrame.skipNow");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._textBtn.enable = true;
         this._contentTxt.width = 120;
         this._contentTxt.text = param1.content;
         this._contentTxt.x = 44;
         this._contentTxt.y = 52;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         var _loc2_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(!_loc2_)
         {
            $.C("yishi.manager.FrameControllerManager").instance.armyController.startFrameByType($.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL,$.bind(this, "back"));
         }
         else
         {
            _loc2_["defaultContent"] = $.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL;
            _loc2_["playFirstOpen"]();
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
      }
    back() {
         var _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(_loc1_)
         {
            _loc1_["playFirstOpen"]();
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__FateGuardTipView, "tasktracetip.view.FateGuardTipView", []);
  return __FateGuardTipView;
}
deps["tasktracetip.view.FateGuardTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.datas.consant.ArmyPanelEnum", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.GradeBoxTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __GradeBoxTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("taskTraceTips.ItemView");
         this._icon.iconBack = $.bind(this, "iconLoadComplete");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._contentTxt.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.GradeBoxTipView.tips");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.GradeBoxTipView.text");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._textBtn.enable = false;
         this._icon.data = param1.goods;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    iconLoadComplete(param1 = null) {
         this._textBtn.enable = true;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         super.__btnHandler(param1);
         if($.C("yishi.manager.GoodsManager").instance.getGoodsByGoodsIdFromGeneralBag(this.data.goods.id))
         {
            $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("gradebox",null,this.data.goods);
         }
         else
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.GradeBoxTipView.command01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
         }
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__GradeBoxTipView, "tasktracetip.view.GradeBoxTipView", []);
  return __GradeBoxTipView;
}
deps["tasktracetip.view.GradeBoxTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager", "yishi.manager.GoodsManager", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.HookTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __HookTipView extends __Base {
    static $fields(self) {
    self._offLineTime = null;
    self._totalExp = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._offLineTime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.HookOffLineTime");
         this._totalExp = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.HookTotalExt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.HookTipView.text");
         this.addChild(this._offLineTime);
         this.addChild(this._totalExp);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._offLineTime.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.HookTipView.offLine",$.int(this.model.hookTime / 3600),$.int(this.model.hookTime % 3600 / 60));
         this._totalExp.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.HookTipView.totalExp",this.model.hookGp);
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.HookRewardFrame");
         _loc2_.show();
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get model() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
      }
    get data() { return super.data; }
    set model(v) { super.model = v; }
  }
  $.meta(__HookTipView, "tasktracetip.view.HookTipView", []);
  return __HookTipView;
}
deps["tasktracetip.view.HookTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.PlayerManager"];

defs["tasktracetip.view.IntensifyTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __IntensifyTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.IntensifyTipView.content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.IntensifyTipView.text");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.storeController.startFrameByType("STORE_PANEL_INTENSIFY");
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__IntensifyTipView, "tasktracetip.view.IntensifyTipView", []);
  return __IntensifyTipView;
}
deps["tasktracetip.view.IntensifyTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.KingContractTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __KingContractTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = param1.content;
         this._textBtn.text = param1.btnTxt;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         this.data && this.data.goods && $.C("yishi.service.managers.SocketSendManager").instance.sendUseItem(this.data.goods.pos);
         $.C("yishi.manager.NotificationManager").instance.dispatchEvent(new ($.C("flash.events.Event"))("KingBuffItemShine"));
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    check() {
         return false;
      }
    dispose() {
         this._contentTxt && this._contentTxt.dispose();
         this._contentTxt = null;
         this.removeEvent();
         super.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    get data() { return super.data; }
  }
  $.meta(__KingContractTipView, "tasktracetip.view.KingContractTipView", []);
  return __KingContractTipView;
}
deps["tasktracetip.view.KingContractTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.events.Event", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.NotificationManager", "yishi.service.managers.SocketSendManager"];

defs["tasktracetip.view.MarryTreeTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __MarryTreeTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("yishi.utils.IconFactory").getMarryTreeIcon();
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._icon.tipStyle = "yishi.view.tips.OneLineTip";
         this._icon.tipData = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.MarryTreeTipView.iconTip");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.MarryTreeTipView.contentTxt");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.CanPickTipView.text");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         super.__btnHandler(param1);
         if($.C("managers.MopupManager").instance.model.isMopup)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("mopup.MopupManager.mopupTipData01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if($.C("farm.FarmManager").instance.model.preMapId > 0)
         {
            $.C("ui.maintoolbar.MainToolBar").instance.returnFromHookRoom();
            $.C("farm.FarmManager").instance.model.preMapId = 0;
         }
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("farm","HOME_NEW_FRAME",2);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__MarryTreeTipView, "tasktracetip.view.MarryTreeTipView", []);
  return __MarryTreeTipView;
}
deps["tasktracetip.view.MarryTreeTipView"] = ["com.pickgliss.ui.ComponentFactory", "farm.FarmManager", "manager.LanguageMgr", "managers.MopupManager", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "ui.maintoolbar.MainToolBar", "yishi.manager.FrameControllerManager", "yishi.utils.IconFactory", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.MilitaryTecTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __MilitaryTecTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._contentTxt.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.MilitaryTecTipView.content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.MilitaryTecTipView.text");
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         var _loc2_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(501);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo($.C("mvc.controler.BuildingControler").getModelNameByInfo(_loc2_),null,_loc2_);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
  }
  $.meta(__MilitaryTecTipView, "tasktracetip.view.MilitaryTecTipView", []);
  return __MilitaryTecTipView;
}
deps["tasktracetip.view.MilitaryTecTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "mvc.controler.BuildingControler", "tasktracetip.view.TaskTraceTipView", "yishi.manager.BuildingManager", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.MountOpenTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.PawnCharacteristicsTipView");
  class __MountOpenTipView extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.MountOpenTipView.content");
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
      }
    __btnHandler(param1) {
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("mounts",1);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    dispose() {
         if(this.isDie)
         {
            return;
         }
         super.dispose();
      }
  }
  $.meta(__MountOpenTipView, "tasktracetip.view.MountOpenTipView", []);
  return __MountOpenTipView;
}
deps["tasktracetip.view.MountOpenTipView"] = ["manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.PawnCharacteristicsTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.MountPropertyTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __MountPropertyTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.MountPropertyTipView.text");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.MountPropertyTipView.content");
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("mounts",1);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__MountPropertyTipView, "tasktracetip.view.MountPropertyTipView", []);
  return __MountPropertyTipView;
}
deps["tasktracetip.view.MountPropertyTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.MountTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __MountTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.MountTipView.text");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         if(param1.data == 2)
         {
            this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.MountTipView.content2");
            this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.MountTipView.text2");
         }
         else
         {
            this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.MountTipView.content");
         }
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.storeController.startFrameByType("STORE_PANEL_MOUNT");
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__MountTipView, "tasktracetip.view.MountTipView", []);
  return __MountTipView;
}
deps["tasktracetip.view.MountTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.OpenBagTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __OpenBagTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("taskTraceTips.ItemView");
         this._icon.iconBack = $.bind(this, "iconLoadComplete");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.OpenBagTipView.text");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._textBtn.enable = false;
         this._icon.data = param1.goods;
         this._contentTxt.text = param1.content;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    iconLoadComplete(param1 = null) {
         this._textBtn.enable = true;
      }
    __btnHandler(param1) {
         var _loc3_ = null;
         var _loc2_ = null;
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.armyController.model.currentPage = $.int(this._data.goods.pos / 56) + 1;
         if($.C("yishi.manager.FrameControllerManager").instance.armyController.model.currentOpenPanel == $.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL)
         {
            _loc3_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
            if(this.fashionModel.isFashion(this._data.goods))
            {
               this.fashionModel.selectedPanel = "FASHION_PANEL";
               this.fashionModel.dispatchEvent(new ($.C("events.FashionEvent"))("SWITCH_EQUIPVIEW",null));
            }
         }
         if(!_loc3_)
         {
            $.C("yishi.manager.FrameControllerManager").instance.armyController.startFrameByType($.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL,$.bind(this, "back"));
         }
         else
         {
            _loc3_["defaultContent"] = $.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL;
            _loc2_ = $.C("yishi.manager.GoodsManager").instance.getGoodsByGoodsIdFromGeneralBag(this._data.goods.id);
            if(_loc2_)
            {
               _loc3_["equipBag"].showEffectByPos(this._data.goods.pos);
               _loc3_["equipBag"].showFilterByPos(this._data.goods.pos);
            }
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
      }
    dispose() {
         if(this._icon)
         {
            this._icon.dispose();
         }
         this._icon = null;
         if(this._contentTxt)
         {
            this._contentTxt.dispose();
         }
         this._contentTxt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
    back() {
         var _loc1_ = null;
         var _loc2_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(_loc2_)
         {
            _loc1_ = $.C("yishi.manager.GoodsManager").instance.getGoodsByGoodsIdFromGeneralBag(this._data.goods.id);
            if(_loc1_)
            {
               _loc2_["equipBag"].showEffectByPos(this._data.goods.pos);
               _loc2_["equipBag"].showFilterByPos(this._data.goods.pos);
            }
            if(this.fashionModel.isFashion(this._data.goods))
            {
               this.fashionModel.selectedPanel = "FASHION_PANEL";
               this.fashionModel.dispatchEvent(new ($.C("events.FashionEvent"))("SWITCH_EQUIPVIEW",null));
            }
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
      }
    get fashionModel() {
         return $.C("yishi.manager.FrameControllerManager").instance.fashionCodeController.model;
      }
    get data() { return super.data; }
    set fashionModel(v) { super.fashionModel = v; }
  }
  $.meta(__OpenBagTipView, "tasktracetip.view.OpenBagTipView", []);
  return __OpenBagTipView;
}
deps["tasktracetip.view.OpenBagTipView"] = ["com.pickgliss.ui.ComponentFactory", "events.FashionEvent", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.datas.consant.ArmyPanelEnum", "yishi.manager.FrameControllerManager", "yishi.manager.GoodsManager"];

defs["tasktracetip.view.PawnCharacteristicsTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __PawnCharacteristicsTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    self._pawnList = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.PawnCharacteristicsTipView.content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.PawnCharacteristicsTipView.text");
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    __btnHandler(param1) {
         var _loc2_ = 0;
         super.__btnHandler(param1);
         var _loc3_ = $.C("yishi.manager.ArmyManager").instance.casernPawnList.getList();
         _loc2_ = _loc3_.length - 1;
         while(_loc2_ >= 0)
         {
            if(_loc3_[_loc2_].templateInfo.Level >= 10)
            {
               $.C("yishi.manager.FrameControllerManager").instance.armyController.startFrameByType($.C("yishi.datas.consant.ArmyPanelEnum").PAWNUPGRADE,_loc3_[_loc2_]);
               if($.C("yishi.manager.FrameControllerManager").instance.armyController.getPawnUpgradeFrame())
               {
                  $.C("yishi.manager.FrameControllerManager").instance.armyController.getPawnUpgradeFrame()["setApperceiveEffect"]();
               }
               break;
            }
            _loc2_--;
         }
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    dispose() {
         if(this.isDie)
         {
            return;
         }
         this.isDie = true;
         this._contentTxt = null;
         this._pawnList = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
  }
  $.meta(__PawnCharacteristicsTipView, "tasktracetip.view.PawnCharacteristicsTipView", []);
  return __PawnCharacteristicsTipView;
}
deps["tasktracetip.view.PawnCharacteristicsTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.datas.consant.ArmyPanelEnum", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.PerkinlabCanPickTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __PerkinlabCanPickTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.CanPickTipView.text");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = this._data.content;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("perkinlab");
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__PerkinlabCanPickTipView, "tasktracetip.view.PerkinlabCanPickTipView", []);
  return __PerkinlabCanPickTipView;
}
deps["tasktracetip.view.PerkinlabCanPickTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.PetAddPointTip"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __PetAddPointTip extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("taskTraceTips.PetIcon");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt02");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("PetAddPointTip.content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("PetAddPointTip.btnTxt");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
         var _loc1_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.enterWarPet;
         if(_loc1_)
         {
            this._icon.icon = $.C("yishi.utils.IconFactory").getPetHeadItemIcon(_loc1_.templateId);
            this._icon.tipData = _loc1_;
         }
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         if(!$.C("yishi.manager.FrameControllerManager").instance.petController.isOpenedFrame)
         {
            $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("pet");
         }
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__PetAddPointTip, "tasktracetip.view.PetAddPointTip", []);
  return __PetAddPointTip;
}
deps["tasktracetip.view.PetAddPointTip"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager", "yishi.utils.IconFactory"];

defs["tasktracetip.view.PetBossTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __PetBossTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.PetBossIcon");
         this._icon.tipStyle = "yishi.view.tips.OneLineTip";
         this._icon.tipData = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.PetBossTipView.iconTip");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("gameguide.GameGuideFrame.skipNow");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
         this.addChild(this._icon);
         this.__switchHandler(null,null);
      }
    initEvent() {
         super.initEvent();
         $.C("yishi.utils.MsgMan").addObserver("CampaignEvent.PET_BOSS_SWITCH",this,$.bind(this, "__switchHandler"));
      }
    removeEvent() {
         super.removeEvent();
         $.C("yishi.utils.MsgMan").removeObserver("CampaignEvent.PET_BOSS_SWITCH",this,$.bind(this, "__switchHandler"));
      }
    __switchHandler(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(!$.C("map.campaign.CampaignManager").instance.petBossModel.isOpen)
         {
            this.dispose();
         }
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = this._data.content;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         var _loc2_ = $.C("map.campaign.CampaignManager").instance.petBossModel;
         if(_loc2_.isOpen)
         {
            if($.C("yishi.scene.SceneManager").instance.currentType == "OUTER_CITY_SCENE")
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("taskTrace.SinglepassHasBugleYipsView.TipInfo"));
               return;
            }
            if($.C("yishi.manager.ArmyManager").instance.thane.grades < 50)
            {
               $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.PetBossTipView.LevelTips"));
            }
            else
            {
               $.C("yishi.SwitchPageHelp").walkToCrossMapTarget(_loc2_.mapId + "," + _loc2_.nodeId);
            }
         }
         else
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("dayGuide.view.DailyItem.PetBossUnOpen"));
            this.dispose();
         }
      }
    check() {
         return false;
      }
    get data() { return super.data; }
  }
  $.meta(__PetBossTipView, "tasktracetip.view.PetBossTipView", []);
  return __PetBossTipView;
}
deps["tasktracetip.view.PetBossTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "map.campaign.CampaignManager", "tasktracetip.view.TaskTraceTipView", "yishi.SwitchPageHelp", "yishi.manager.ArmyManager", "yishi.scene.SceneManager", "yishi.utils.MsgMan", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.RefreshTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __RefreshTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.RefreshTipView.text");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.RefreshTipView.content");
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.storeController.startFrameByType("STORE_PANEL_REFRESH");
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__RefreshTipView, "tasktracetip.view.RefreshTipView", []);
  return __RefreshTipView;
}
deps["tasktracetip.view.RefreshTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.RegressionTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __RegressionTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.RegressionIcon");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._icon.tipStyle = "yishi.view.tips.OneLineTip";
         this._icon.tipData = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.RegressionTipView.IconTipTxt");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.RegressionTipView.content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.RegressionTipView.text");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         super.__btnHandler(param1);
         if(this.thane.grades < 6)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("mainBar.TopToolsBar.dayGuideBtn.underLevel");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
         }
         else
         {
            $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("funny");
         }
         this.dispose();
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get data() { return super.data; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__RegressionTipView, "tasktracetip.view.RegressionTipView", []);
  return __RegressionTipView;
}
deps["tasktracetip.view.RegressionTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "tasktracetip.view.TaskTraceTipView", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.SecretTreeTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __SecretTreeTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._icon.tipStyle = "yishi.view.tips.OneLineTip";
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         if(this._data)
         {
            this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap(this._data.icon);
            this._icon.tipData = this._data.name;
            this._contentTxt.htmlText = this._data.content;
            this._textBtn.text = this._data.btnTxt;
         }
         if(this._textBtn)
         {
            if(($.as(this._textBtn.textField, $.C("flash.text.TextField"))).textWidth > 92)
            {
               ($.as(this._textBtn.textField, $.C("flash.text.TextField"))).width = ($.as(this._textBtn.textField, $.C("flash.text.TextField"))).textWidth + 3;
               this._textBtn.width = ($.as(this._textBtn.textField, $.C("flash.text.TextField"))).width + 30;
               ($.as(this._textBtn.textField, $.C("flash.text.TextField"))).x = 15;
               this._textBtn.x = (214 - this._textBtn.width) * 0.5;
            }
         }
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         var _loc2_ = this.checkLimit;
         if(_loc2_ != "")
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            this.dispose();
            return;
         }
         if(this.checkScene())
         {
            $.C("managers.ConsortiaSocketOutManager").sendEnterSecretLand();
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
      }
    get checkLimit() {
         if($.C("managers.MopupManager").instance.model.isMopup)
         {
            return $.C("manager.LanguageMgr").GetTranslation("mopup.MopupManager.mopupTipData01");
         }
         return $.C("yishi.utils.WorldBossHelper").getCampaignTips();
      }
    checkScene() {
         var _loc1_ = $.C("yishi.utils.WorldBossHelper").getCampaignTips();
         if($.C("yishi.utils.StringHelper").isNullOrEmpty(_loc1_))
         {
            return true;
         }
         $.C("yishi.view.tips.MessageTipManager").instance().show(_loc1_);
         return false;
      }
    get data() { return super.data; }
    set checkLimit(v) { super.checkLimit = v; }
  }
  $.meta(__SecretTreeTipView, "tasktracetip.view.SecretTreeTipView", []);
  return __SecretTreeTipView;
}
deps["tasktracetip.view.SecretTreeTipView"] = ["com.pickgliss.ui.ComponentFactory", "flash.text.TextField", "manager.LanguageMgr", "managers.ConsortiaSocketOutManager", "managers.MopupManager", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.utils.StringHelper", "yishi.utils.WorldBossHelper", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.ShopTimeBuyTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __ShopTimeBuyTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.ShopIcon");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt02");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._icon.tipStyle = "yishi.view.tips.OneLineTip";
         this.addChild(this._icon);
         this._icon.tipData = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.ShopTimeBuyTipView.IconTips");
         this.addChild(this._contentTxt);
         this._contentTxt.text = "";
         this.addChild(this._textBtn);
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.ShopTimeBuyTipView.btnTxt");
      }
    set data(param1) {
         super.data = param1;
         if(this._data)
         {
            this._contentTxt.text = this._data.content;
         }
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("com.pickgliss.utils.SoundManager").instance.play("015",true);
         if(this._data && this._data.data)
         {
            $.C("managers.ShopManager").Instance.shopFrameDefaultPanel = this._data.data["isVIPShop"] ? "SHOPFRAME_VIPBUY" : "SHOPFRAME_TIMEBUY";
            if(!this._data.data["isVIPShop"] && $.C("managers.ShopManager").Instance.model.getTimeBuyList(0).length <= 0)
            {
               $.C("managers.TaskTraceTipManager").instance.cleanByType(33);
               return;
            }
            $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("shop");
         }
         $.C("managers.TaskTraceTipManager").instance.cleanByType(33);
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contentTxt);
         this._contentTxt = null;
         this._icon = null;
         super.dispose();
      }
    get data() { return super.data; }
  }
  $.meta(__ShopTimeBuyTipView, "tasktracetip.view.ShopTimeBuyTipView", []);
  return __ShopTimeBuyTipView;
}
deps["tasktracetip.view.ShopTimeBuyTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "manager.LanguageMgr", "managers.ShopManager", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.SinglepassHasBugleYipsView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __SinglepassHasBugleYipsView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    self._info = null;
    self._icon = null;
    }
    constructor() {
         super();
      }
    set data(param1) {
         super.data = param1;
         if(this.data != null)
         {
            this._contentTxt.text = this.data.content;
            this._icon.data = this.data.goods;
         }
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.SinglepassHasBugleYipsView.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("taskTrace.SinglepassHasBugleYipsView.intoSinglePass");
         this._textBtn.backgound.width = 180;
         this._textBtn.textField.x = 9;
         this._textBtn.x = 17;
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("taskTraceTips.ItemView");
         this._icon.iconBack = $.bind(this, "iconLoadComplete");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    iconLoadComplete(param1 = null) {
         this._textBtn.enable = true;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         if($.C("yishi.scene.SceneManager").instance.currentType == "CASTLE_SCENE" || $.C("yishi.scene.SceneManager").instance.currentType == "SPACE_SCENE" || $.C("yishi.scene.SceneManager").instance.currentType == "OUTER_CITY_SCENE")
         {
            $.C("yishi.SwitchPageHelp").goSpaceAndFind(20);
         }
         else
         {
            $.C("yishi.view.tips.MessageTipManager").instance().show($.C("manager.LanguageMgr").GetTranslation("taskTrace.SinglepassHasBugleYipsView.TipInfo"));
         }
         this.dispose();
      }
    dispose() {
         if(this._icon)
         {
            this._icon.dispose();
         }
         this._icon = null;
         if(this._contentTxt)
         {
            this._contentTxt.dispose();
         }
         this._contentTxt = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__SinglepassHasBugleYipsView, "tasktracetip.view.SinglepassHasBugleYipsView", []);
  return __SinglepassHasBugleYipsView;
}
deps["tasktracetip.view.SinglepassHasBugleYipsView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "tasktracetip.view.TaskTraceTipView", "yishi.SwitchPageHelp", "yishi.scene.SceneManager", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.StarTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __StarTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         this._contentTxt.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.StarTipView.content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.StarTipView.text");
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("star");
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
  }
  $.meta(__StarTipView, "tasktracetip.view.StarTipView", []);
  return __StarTipView;
}
deps["tasktracetip.view.StarTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.StoreComposeBetterEquipTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __StoreComposeBetterEquipTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.NormalBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("appell.AppellFrame.AppellLink.LinkText");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = this._data.content;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.storeController.startFrameByType("STORE_PANEL_COMPOSE");
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__StoreComposeBetterEquipTipView, "tasktracetip.view.StoreComposeBetterEquipTipView", []);
  return __StoreComposeBetterEquipTipView;
}
deps["tasktracetip.view.StoreComposeBetterEquipTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.TaskEquipTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __TaskEquipTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    self._info = null;
    }
    constructor() {
         super();
      }
    set data(param1) {
         this._info = $.as(param1.data, $.C("yishi.datas.goods.GoodsInfo"));
         super.data = param1;
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._contentTxt.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.TaskEquipTipView.content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.TaskEquipTipView.text");
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.armyController.model.currentPage = $.int(this._info.pos / 56) + 1;
         var _loc2_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(!_loc2_)
         {
            $.C("yishi.manager.FrameControllerManager").instance.armyController.startFrameByType($.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL,$.bind(this, "back"));
         }
         else
         {
            _loc2_["defaultContent"] = $.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL;
            _loc2_["equipBag"].showEffectByPos(this._info.pos);
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
      }
    back() {
         var _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(_loc1_)
         {
            _loc1_["equipBag"].showEffectByPos(this._info.pos);
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__TaskEquipTipView, "tasktracetip.view.TaskEquipTipView", []);
  return __TaskEquipTipView;
}
deps["tasktracetip.view.TaskEquipTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.datas.consant.ArmyPanelEnum", "yishi.datas.goods.GoodsInfo", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.TaskTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __TaskTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    __btnHandler(param1) {
         var _loc7_ = null;
         var _loc3_ = null;
         var _loc6_ = null;
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc5_ = null;
         super.__btnHandler(param1);
         if(this.data != null && this.data.data != null && this.data.data.TemplateId == 150)
         {
            _loc7_ = $.C("yishi.manager.PathManager").getClientLoginPath();
            _loc3_ = $.C("yishi.manager.PathManager").getClientLoginName() + ".exe";
            if(_loc7_.substr(-3) != "exe")
            {
               _loc6_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.userInfo.user;
               _loc4_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.userInfo.site;
               if(_loc7_.indexOf("?") == -1)
               {
                  _loc7_ += "?";
               }
               else
               {
                  _loc7_ += "&";
               }
               _loc7_ += "u=" + _loc6_ + "&site=" + _loc4_;
            }
            _loc7_ = encodeURI(_loc7_);
            _loc2_ = new ($.C("flash.net.URLRequest"))(_loc7_);
            _loc5_ = new ($.C("flash.net.FileReference"))();
            _loc5_.download(_loc2_,_loc3_);
         }
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    check() {
         return super.check();
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.TaskTipView.content" + param1.data.TemplateId);
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.TaskTipView.btnText" + param1.data.TemplateId);
      }
    dispose() {
         this._contentTxt = null;
         super.dispose();
      }
    initView() {
         super.initView();
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.TaskTip_Login");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn.x = 63;
         this._textBtn.y = 120;
         this._contentTxt.y = 54;
         this._contentTxt.height = 60;
         this._contentTxt.wordWrap = true;
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    get data() { return super.data; }
  }
  $.meta(__TaskTipView, "tasktracetip.view.TaskTipView", []);
  return __TaskTipView;
}
deps["tasktracetip.view.TaskTipView"] = ["com.pickgliss.ui.ComponentFactory", "flash.net.FileReference", "flash.net.URLRequest", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.PathManager", "yishi.manager.PlayerManager"];

defs["tasktracetip.view.TaskTraceTipView"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __TaskTraceTipView extends __Base {
    static $fields(self) {
    self._back = null;
    self._panel = null;
    self._clostBtn = null;
    self._titleImg = null;
    self._data = null;
    self._textBtn = null;
    self._backMv = null;
    self._timer = new ($.C("flash.utils.Timer"))(5000);
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTrace.backBG1");
         this._panel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTrace.panelBG1");
         this._titleImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.TitleImg");
         this._clostBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTrace.MessageCloseBtn");
         this._backMv = $.C("com.pickgliss.ui.ComponentFactory").Instance.creat("asset.taskTrace.backBGMv1");
         this._backMv.container.movie01.visible = false;
         this._backMv.container.movie01.stop();
         this._backMv.container.movie02.visible = false;
         this._backMv.container.movie02.stop();
         this._back.setFrame(1);
         this._panel.setFrame(1);
         this._backMv.container.container.addChild(this._back);
         this.addChild(this._backMv);
         this.addChild(this._panel);
         this.addChild(this._titleImg);
         this.addChild(this._clostBtn);
         this.__onResizeHandler(null);
      }
    uninit() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._data = null;
      }
    initEvent() {
         if(this._textBtn)
         {
            this._textBtn.addEventListener("click",$.bind(this, "__btnHandler"));
         }
         this._clostBtn.addEventListener("click",$.bind(this, "__onCloseHandler"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.addEventListener("resize",$.bind(this, "__onResizeHandler"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SHOW_TASK_TRACE",$.bind(this, "__show"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("HIDE_TASK_TRACE",$.bind(this, "__hide"));
         $.C("yishi.manager.NotificationManager").instance.addEventListener("SWITCH_SCENE",$.bind(this, "_onSceneViewAdded"));
      }
    removeEvent() {
         if(this._textBtn)
         {
            this._textBtn.removeEventListener("click",$.bind(this, "__btnHandler"));
         }
         this._clostBtn.removeEventListener("click",$.bind(this, "__onCloseHandler"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.removeEventListener("resize",$.bind(this, "__onResizeHandler"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SHOW_TASK_TRACE",$.bind(this, "__show"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("HIDE_TASK_TRACE",$.bind(this, "__hide"));
         $.C("yishi.manager.NotificationManager").instance.removeEventListener("SWITCH_SCENE",$.bind(this, "_onSceneViewAdded"));
      }
    __onResizeHandler(param1) {
         if($.C("yishi.scene.SceneManager").instance.currentType == "CASTLE_SCENE" || $.C("yishi.scene.SceneManager").instance.currentType == "SPACE_SCENE" || $.C("yishi.scene.SceneManager").instance.currentType == "OUTER_CITY_SCENE")
         {
            this.x = $.C("com.pickgliss.toplevel.StageReferance").gameStageWidth - this.wid - 90;
            if(this.x < $.C("yishi.datas.PathInfo").GAME_WIDTH - this.wid - 90)
            {
               this.x = $.C("yishi.datas.PathInfo").GAME_WIDTH - this.wid - 90;
            }
         }
         else
         {
            this.x = $.C("com.pickgliss.toplevel.StageReferance").gameStageWidth - this.wid;
            if(this.x < $.C("yishi.datas.PathInfo").GAME_WIDTH - this.wid)
            {
               this.x = $.C("yishi.datas.PathInfo").GAME_WIDTH - this.wid;
            }
         }
         this.y = $.C("com.pickgliss.toplevel.StageReferance").gameStageHeight - this.hei - 70 + this.gap;
         if(this.y < $.C("yishi.datas.PathInfo").GAME_HEIGHT - this.hei - 70 + this.gap)
         {
            this.y = $.C("yishi.datas.PathInfo").GAME_HEIGHT - this.hei - 70 + this.gap;
         }
      }
    moveComplete() {
         if(!this._timer)
         {
            this._timer = new ($.C("flash.utils.Timer"))(5000);
         }
         this._timer.addEventListener("timer",$.bind(this, "onTime"));
         this._timer.start();
         if(!this._back || !this._backMv || !this._backMv.container)
         {
            return;
         }
         if(this._back.getFrame == 1)
         {
            this._backMv.container.movie01.visible = true;
            this._backMv.container.movie01.gotoAndPlay(1);
         }
         else if(this._back.getFrame == 2)
         {
            this._backMv.container.movie02.visible = true;
            this._backMv.container.movie02.gotoAndPlay(1);
         }
         else if(this._back.getFrame == 3)
         {
            this._backMv.container.movie01.visible = true;
            this._backMv.container.movie01.gotoAndPlay(1);
         }
      }
    onTime(param1) {
         if(!this._timer)
         {
            this._timer = new ($.C("flash.utils.Timer"))(5000);
         }
         this._timer.removeEventListener("timer",$.bind(this, "onTime"));
         this._timer.reset();
         if(this._back == null)
         {
            return;
         }
         if(this._back.getFrame == 1 && this._backMv)
         {
            this._backMv.container.movie01.visible = false;
            this._backMv.container.movie01.gotoAndStop(1);
         }
         else if(this._back.getFrame == 2 && this._backMv)
         {
            this._backMv.container.movie02.visible = false;
            this._backMv.container.movie02.gotoAndStop(1);
         }
         else if(this._back.getFrame == 3 && this._backMv)
         {
            this._backMv.container.movie01.visible = false;
            this._backMv.container.movie01.gotoAndStop(1);
         }
      }
    __onCloseHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("008");
         this._clostBtn.enable = false;
         this.dispose();
      }
    __show(param1) {
         this.visible = true;
      }
    __hide(param1) {
         var _loc2_ = $.int($.C("map.campaign.CampaignManager").instance.mapModel ? $.C("map.campaign.CampaignManager").instance.mapModel.mapId : 0);
         this.visible = false;
      }
    _onSceneViewAdded(param1) {
         if($.C("yishi.scene.SceneManager").instance.currentType == "CASTLE_SCENE" || $.C("yishi.scene.SceneManager").instance.currentType == "SPACE_SCENE" || $.C("yishi.scene.SceneManager").instance.currentType == "OUTER_CITY_SCENE")
         {
            this.x = $.C("com.pickgliss.toplevel.StageReferance").gameStageWidth - this.wid - 90;
            if(this.x < $.C("yishi.datas.PathInfo").GAME_WIDTH - this.wid - 90)
            {
               this.x = $.C("yishi.datas.PathInfo").GAME_WIDTH - this.wid - 90;
            }
         }
         else
         {
            this.x = $.C("com.pickgliss.toplevel.StageReferance").gameStageWidth - this.wid;
            if(this.x < $.C("yishi.datas.PathInfo").GAME_WIDTH - this.wid)
            {
               this.x = $.C("yishi.datas.PathInfo").GAME_WIDTH - this.wid;
            }
         }
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         this._data = param1;
         if(this._textBtn)
         {
            if(($.as(this._textBtn.textField, $.C("flash.text.TextField"))).textWidth > 92)
            {
               ($.as(this._textBtn.textField, $.C("flash.text.TextField"))).width = ($.as(this._textBtn.textField, $.C("flash.text.TextField"))).textWidth + 3;
               this._textBtn.width = ($.as(this._textBtn.textField, $.C("flash.text.TextField"))).width + 30;
               ($.as(this._textBtn.textField, $.C("flash.text.TextField"))).x = 15;
               this._textBtn.x = (214 - this._textBtn.width) * 0.5;
            }
         }
      }
    __btnHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
      }
    check() {
         return false;
      }
    addMessage() {
         if(this._data && this._textBtn && this._textBtn.enable && this.check())
         {
            $.C("mainBar.TipsBar").instance.messageBtnList.addMessage(this._data);
         }
      }
    show() {
         var _loc1_ = NaN;
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,4,false,false,0,1,false);
         _loc1_ = $.C("com.pickgliss.toplevel.StageReferance").gameStageHeight - this.hei - 70 + this.gap;
         if(_loc1_ < $.C("yishi.datas.PathInfo").GAME_HEIGHT - this.hei - 70 + this.gap)
         {
            _loc1_ = $.C("yishi.datas.PathInfo").GAME_HEIGHT - this.hei - 70 + this.gap;
         }
         this.y = _loc1_ + 200;
         $.C("com.greensock.TweenMax").to(this,0.5,{
            "alpha":1,
            "y":_loc1_,
            "onComplete":$.bind(this, "moveComplete")
         });
      }
    get gap() {
         if(this._back && this._back.getFrame == 2)
         {
            return 40;
         }
         return 0;
      }
    get hei() {
         return 167;
      }
    get wid() {
         return 220;
      }
    dispose() {
         $.C("com.greensock.TweenMax").killTweensOf(this);
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "onTime"));
            this._timer = null;
         }
         this.addMessage();
         this.removeEvent();
         this.uninit();
         if(this._back)
         {
            this._back.dispose();
         }
         this._back = null;
         if(this._clostBtn)
         {
            this._clostBtn.dispose();
         }
         this._clostBtn = null;
         if(this._textBtn)
         {
            this._textBtn.dispose();
         }
         this._textBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeViolentMc(this._backMv);
         this._backMv = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.dispatchEvent(new ($.C("flash.events.Event"))("dispose"));
         $.C("com.pickgliss.toplevel.StageReferance").stage.focus = null;
         super.dispose();
         $.C("yishi.manager.NotificationManager").instance.sendNotification("NEXT_TASK_TRACETIPVIEW");
      }
    set gap(v) { super.gap = v; }
    set hei(v) { super.hei = v; }
    set wid(v) { super.wid = v; }
  }
  $.meta(__TaskTraceTipView, "tasktracetip.view.TaskTraceTipView", []);
  $.statics(__TaskTraceTipView, () => {
    __TaskTraceTipView.WIDTH = 219.5;
  });
  return __TaskTraceTipView;
}
deps["tasktracetip.view.TaskTraceTipView"] = ["com.greensock.TweenMax", "com.pickgliss.toplevel.StageReferance", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "flash.events.Event", "flash.text.TextField", "flash.utils.Timer", "mainBar.TipsBar", "map.campaign.CampaignManager", "yishi.datas.PathInfo", "yishi.manager.NotificationManager", "yishi.scene.SceneManager"];

defs["tasktracetip.view.TreasureMapTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __TreasureMapTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    self.goods = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("taskTraceTips.ItemView");
         this._icon.iconBack = $.bind(this, "iconLoadComplete");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.TreasureMapTipView.btnTxt");
         this._textBtn.width = 180;
         this._textBtn.x = 20;
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._textBtn.enable = false;
         this._icon.data = param1.goods;
         this._contentTxt.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.TreasureMapTipView.content",param1.goods.templateInfo.TemplateName);
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    iconLoadComplete(param1 = null) {
         this._textBtn.enable = true;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         var _loc3_ = null;
         super.__btnHandler(param1);
         if(!this._data || !this._data.goods)
         {
            this.dispose();
            return;
         }
         $.C("yishi.manager.FrameControllerManager").instance.armyController.model.currentPage = $.int(this._data.goods.pos / 56) + 1;
         this.goods = $.C("yishi.manager.GoodsManager").instance.getGoodsByGoodsIdFromGeneralBag(this._data.goods.id);
         if(this.goods == null)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.BetterGoodsTipsView.command01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
            return;
         }
         _loc3_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(!_loc3_)
         {
            $.C("yishi.manager.FrameControllerManager").instance.armyController.startFrameByType($.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL,$.bind(this, "callBack"));
            if(this.data)
            {
               $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
            }
         }
         else
         {
            _loc3_["equipBag"]["showEffectByPos"](this.goods.pos);
         }
      }
    callBack() {
         var _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(_loc1_)
         {
            _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
            _loc1_["show"]();
         }
         if(this.goods)
         {
            _loc1_["equipBag"]["showEffectByPos"](this.goods.pos);
         }
      }
    dispose() {
         if(this._icon)
         {
            this._icon.dispose();
         }
         this._icon = null;
         if(this._contentTxt)
         {
            this._contentTxt.dispose();
         }
         this._contentTxt = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__TreasureMapTipView, "tasktracetip.view.TreasureMapTipView", []);
  return __TreasureMapTipView;
}
deps["tasktracetip.view.TreasureMapTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.datas.consant.ArmyPanelEnum", "yishi.manager.FrameControllerManager", "yishi.manager.GoodsManager", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.TreeCanPickTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __TreeCanPickTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.TreeIcon");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._icon.tipStyle = "yishi.view.tips.OneLineTip";
         this._icon.tipData = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.CanPickTipView.treeTip");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.CanPickTipView.treeContent");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.CanPickTipView.text");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         super.__btnHandler(param1);
         if($.C("managers.MopupManager").instance.model.isMopup)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("mopup.MopupManager.mopupTipData01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         if($.C("farm.FarmManager").instance.model.preMapId > 0)
         {
            $.C("ui.maintoolbar.MainToolBar").instance.returnFromHookRoom();
            $.C("farm.FarmManager").instance.model.preMapId = 0;
         }
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("farm","HOME_NEW_FRAME",1);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__TreeCanPickTipView, "tasktracetip.view.TreeCanPickTipView", []);
  return __TreeCanPickTipView;
}
deps["tasktracetip.view.TreeCanPickTipView"] = ["com.pickgliss.ui.ComponentFactory", "farm.FarmManager", "manager.LanguageMgr", "managers.MopupManager", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "ui.maintoolbar.MainToolBar", "yishi.manager.FrameControllerManager", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.UpgradePawnTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __UpgradePawnTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._contentTxt.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.UpgradePawnTipView.content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.UpgradePawnTipView.text");
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         var _loc2_ = $.C("yishi.manager.BuildingManager").instance.model.getBuildingInfoByMasterType(4);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo($.C("mvc.controler.BuildingControler").getModelNameByInfo(_loc2_),null,_loc2_);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
  }
  $.meta(__UpgradePawnTipView, "tasktracetip.view.UpgradePawnTipView", []);
  return __UpgradePawnTipView;
}
deps["tasktracetip.view.UpgradePawnTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "mvc.controler.BuildingControler", "tasktracetip.view.TaskTraceTipView", "yishi.manager.BuildingManager", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.UseWearyTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __UseWearyTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.UseWearyTipView.content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.UseWearyTipView.text");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.armyController.model.currentPage = $.int(this._data.goods.pos / 56) + 1;
         var _loc2_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(!_loc2_)
         {
            $.C("yishi.manager.FrameControllerManager").instance.armyController.startFrameByType($.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL,$.bind(this, "back"));
         }
         else
         {
            _loc2_["defaultContent"] = $.C("yishi.datas.consant.ArmyPanelEnum").EQUIP_PANEL;
            _loc2_["equipBag"].showEffectByPos(this._data.goods.pos);
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
      }
    back() {
         var _loc1_ = $.C("yishi.manager.FrameControllerManager").instance.armyController.frame;
         if(_loc1_)
         {
            _loc1_["equipBag"].showEffectByPos(this._data.goods.pos);
            $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__UseWearyTipView, "tasktracetip.view.UseWearyTipView", []);
  return __UseWearyTipView;
}
deps["tasktracetip.view.UseWearyTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.datas.consant.ArmyPanelEnum", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.VIPCardTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __VIPCardTipView extends __Base {
    static $fields(self) {
    self.titleTxt = null;
    self.itemView = null;
    self.txt = null;
    self.btn = null;
    }
    constructor() {
         super();
      }
    initView() {
         var _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("VIPCardTipView.back");
         this.addChild(_loc3_);
         var _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("VIPCardTipView.bg");
         this.addChild(_loc2_);
         this.titleTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("VIPCardTipView.titleTxt");
         this.addChild(this.titleTxt);
         this.itemView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("VIPCardTipView.itemView");
         this.addChild(this.itemView);
         this.txt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("VIPCardTipView.vipCardTxt");
         this.addChild(this.txt);
         var _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("VIPCardTipView.vipCardTipTxt");
         _loc1_.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.vipCommand02");
         this.addChild(_loc1_);
         this.btn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("vip.useVipCardBtn");
         this.addChild(this.btn);
      }
    initEvent() {
         this.btn.addEventListener("click",$.bind(this, "__clickHandler"));
      }
    removeEvent() {
         if(this.btn)
         {
            this.btn.removeEventListener("click",$.bind(this, "__clickHandler"));
         }
      }
    __clickHandler(param1) {
         $.C("com.pickgliss.utils.SoundManager").instance.play("022");
         this.useVipCard();
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    show() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = false;
         if(this.data)
         {
            this.txt.text = this.data.goods.templateInfo.TemplateName;
            this.titleTxt.text = this.txt.text;
            this.itemView.icon = this.data.goods.templateInfo.iconPath;
         }
         this.titleTxt.text = this.txt.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VIPCardTipView.titleTxt");
         this.itemView.icon = $.C("yishi.manager.PathManager").resourcePath + "icon/item_VIPcard.png";
         $.C("com.pickgliss.ui.LayerManager").Instance.addToLayer(this,1,true,true,2);
      }
    useVipCard() {
         this.data && $.C("yishi.service.managers.SocketSendManager").instance.sendUseItem(this.data.goods.pos);
      }
    set data(param1) {
         super._data = param1;
      }
    dispose() {
         $.C("yishi.keyboard.KeyBoardRegister").instance.keyEnable = true;
         this.removeEvent();
         if(this.btn)
         {
            this.btn.dispose();
         }
         this.btn = null;
         if(this.txt)
         {
            this.txt.dispose();
         }
         this.txt = null;
         if(this._data)
         {
            this._data.goods = null;
         }
         this._data = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__VIPCardTipView, "tasktracetip.view.VIPCardTipView", []);
  return __VIPCardTipView;
}
deps["tasktracetip.view.VIPCardTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.LayerManager", "com.pickgliss.utils.ObjectUtils", "com.pickgliss.utils.SoundManager", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.keyboard.KeyBoardRegister", "yishi.manager.PathManager", "yishi.service.managers.SocketSendManager"];

defs["tasktracetip.view.VIPCustomTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __VIPCustomTipView extends __Base {
    static $fields(self) {
    self._vcTitleImg = null;
    self._contentImg = null;
    self._contentTxt = null;
    self._vcBtn = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(4);
         this._panel.visible = false;
         this._titleImg.visible = false;
         this._clostBtn.x = 196;
         this._clostBtn.y = 41;
         this._vcTitleImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTrace.VIPCustom.TitleAsset");
         this._contentImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTrace.VIPCustom.ContentAsset");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.VIPCustomTipView.ContentTxt");
         this._vcBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tasktracebar.VIPCustomTipView.VCBtn");
         this.addChild(this._vcTitleImg);
         this.addChild(this._contentImg);
         this.addChild(this._contentTxt);
         this.addChild(this._vcBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.htmlText = this.data.content;
      }
    initEvent() {
         super.initEvent();
         this._vcBtn.addEventListener("click",$.bind(this, "__btnHandler"));
      }
    removeEvent() {
         super.removeEvent();
         if(this._vcBtn)
         {
            this._vcBtn.removeEventListener("click",$.bind(this, "__btnHandler"));
         }
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         var _loc2_ = "http://wpa.qq.com/msgrd?V=1&Uin=" + this.data.title + "&Site=sq.7road.com&Menu=yes";
         $.C("manager.ExternalInterfaceManager").instance.AASRegisterPath(_loc2_);
         $.C("yishi.service.managers.SocketSendManager").instance.vipCustomAdd();
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get hei() {
         return 195;
      }
    dispose() {
         this.removeEvent();
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vcTitleImg);
         this._vcTitleImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contentImg);
         this._contentImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contentTxt);
         this._contentTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vcBtn);
         this._vcBtn = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         this._data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
    set hei(v) { super.hei = v; }
  }
  $.meta(__VIPCustomTipView, "tasktracetip.view.VIPCustomTipView", []);
  return __VIPCustomTipView;
}
deps["tasktracetip.view.VIPCustomTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.ExternalInterfaceManager", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.service.managers.SocketSendManager"];

defs["tasktracetip.view.VipGiftGetTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __VipGiftGetTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.GetGiftBtn");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipGiftGetTipView.ContentTxt");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipGiftGetTipView.BtnTxt");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("vip",$.C("mvc.module.vip.VIPModel").OPEN_GIFT_FRAME);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    check() {
         return false;
      }
    dispose() {
         this.removeEvent();
         super.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    get data() { return super.data; }
  }
  $.meta(__VipGiftGetTipView, "tasktracetip.view.VipGiftGetTipView", []);
  return __VipGiftGetTipView;
}
deps["tasktracetip.view.VipGiftGetTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.TaskTraceTipManager", "mvc.module.vip.VIPModel", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.VipMountActivityTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __VipMountActivityTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.VipIcon");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._icon.tipStyle = "yishi.view.tips.OneLineTip";
         this._icon.tipData = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipMountActivateTipView.Tip");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipMountActivateTipView.Content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipMountActivateTipView.text");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    show() {
         super.show();
         if(this.data && this.data.content)
         {
            this._contentTxt.htmlText = $.as(this.data.content, "String");
         }
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         super.__btnHandler(param1);
         if($.C("managers.MopupManager").instance.model.isMopup)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("mopup.MopupManager.mopupTipData01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         $.C("managers.MountsManager").instance.vipMountActivity = true;
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("mounts",2);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__VipMountActivityTipView, "tasktracetip.view.VipMountActivityTipView", []);
  return __VipMountActivityTipView;
}
deps["tasktracetip.view.VipMountActivityTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.MopupManager", "managers.MountsManager", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.VipMountLoseTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __VipMountLoseTipView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("asset.taskTraceTips.TreeIconView");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.taskTraceTips.VipIcon");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         this._icon.tipStyle = "yishi.view.tips.OneLineTip";
         this._icon.tipData = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipMountLoseTipView.Tip");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipMountLoseTipView.Content");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipMountLoseTipView.text");
         this.addChild(this._icon);
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    show() {
         super.show();
         if(this.data && this.data.content)
         {
            this._contentTxt.htmlText = $.as(this.data.content, "String");
         }
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         var _loc2_ = null;
         super.__btnHandler(param1);
         if($.C("managers.MopupManager").instance.model.isMopup)
         {
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("mopup.MopupManager.mopupTipData01");
            $.C("yishi.view.tips.MessageTipManager").instance().show(_loc2_);
            return;
         }
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("vip");
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    get data() { return super.data; }
  }
  $.meta(__VipMountLoseTipView, "tasktracetip.view.VipMountLoseTipView", []);
  return __VipMountLoseTipView;
}
deps["tasktracetip.view.VipMountLoseTipView"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "managers.MopupManager", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager", "yishi.view.tips.MessageTipManager"];

defs["tasktracetip.view.VipRechargeTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __VipRechargeTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.RechargeBtn");
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipRechargeTipView.ContentTxt");
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipRechargeTipView.BtnTxt");
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("vip");
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    check() {
         return false;
      }
    dispose() {
         this.removeEvent();
         super.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    get data() { return super.data; }
  }
  $.meta(__VipRechargeTipView, "tasktracetip.view.VipRechargeTipView", []);
  return __VipRechargeTipView;
}
deps["tasktracetip.view.VipRechargeTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.TaskTraceTipManager", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["tasktracetip.view.VipUpGradeTipView"] = function define($) {
  const __Base = $.C("tasktracetip.view.TaskTraceTipView");
  class __VipUpGradeTipView extends __Base {
    static $fields(self) {
    self._contentTxt = null;
    }
    constructor() {
         super();
      }
    initView() {
         super.initView();
         this._back.setFrame(1);
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         this._textBtn = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("taskTraceTips.UpGradeBtn");
         var _loc1_ = $.int($.C("managers.VIPManager").Instance.model.vipInfo.VipGrade);
         this._contentTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipUpGradeTipView.ContentTxt",_loc1_);
         this._textBtn.text = $.C("manager.LanguageMgr").GetTranslation("tasktracetip.view.VipUpGradeTipView.BtnTxt");
         this._textBtn.width = 140;
         this._textBtn.x = 40;
         this.addChild(this._contentTxt);
         this.addChild(this._textBtn);
      }
    set data(param1) {
         super.data = param1;
         this._contentTxt.height = this._contentTxt.textHeight + this._contentTxt.numLines * 4;
         this._contentTxt.y = 55 - (this._contentTxt.numLines - 1) * 10;
      }
    __btnHandler(param1) {
         super.__btnHandler(param1);
         $.C("yishi.manager.FrameControllerManager").instance.openControllerByInfo("vip",$.C("mvc.module.vip.VIPModel").OPEN_PRIVILEGE_FRAME);
         $.C("managers.TaskTraceTipManager").instance.cleanByType(this.data.type);
      }
    check() {
         return false;
      }
    dispose() {
         this.removeEvent();
         super.dispose();
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
      }
    get data() { return super.data; }
  }
  $.meta(__VipUpGradeTipView, "tasktracetip.view.VipUpGradeTipView", []);
  return __VipUpGradeTipView;
}
deps["tasktracetip.view.VipUpGradeTipView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.TaskTraceTipManager", "managers.VIPManager", "mvc.module.vip.VIPModel", "tasktracetip.view.TaskTraceTipView", "yishi.manager.FrameControllerManager"];

defs["yishi.view.tips.ActiveVehicleBoxTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ActiveVehicleBoxTip extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._timer = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.totalVBox");
         this._bg.width = 255;
         this.addChild(this._totalBox);
      }
    $$updateTransform() {
         var _nameSprite;
         var _injuryTxt;
         var _nameTxt;
         var _castTime;
         var _coolDown;
         var _descTxt;
         var _line;
         var showTipsAry;
         var tempInfo;
         var info;
         var buff;
         var buffHurt;
         var buffTemp;
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__onTimerHandler"));
            this._timer = null;
         }
         this._totalBox.removeAllChild();
         super.$$updateTransform();
         if(this.tipData)
         {
            showTipsAry = $.as(this.tipData, "Array");
            for (tempInfo of $.values(showTipsAry))
            {
               _nameSprite = new ($.C("com.pickgliss.ui.core.Component"))();
               _nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.NameTxt1");
               _injuryTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.NameTxt2");
               _castTime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
               _coolDown = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
               _descTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ActiveVehicleBoxTip.DescTxt");
               _line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.line");
               if($.is(tempInfo, $.C("yishi.datas.templates.VehicleSkillTempInfo")))
               {
                  info = $.as(tempInfo, $.C("yishi.datas.templates.VehicleSkillTempInfo"));
                  _nameTxt.text = info.TemplateName;
                  _injuryTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.DaimonSkillTip.injuryTxt" + info.InjuryEffect);
                  _castTime.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.castTime",info.CastTime / 1000);
                  _coolDown.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",info.CoolDown / 1000);
                  _descTxt.htmlText = info.Description;
                  _descTxt.height = _descTxt.textHeight + 5;
                  _nameSprite.addChild(_nameTxt);
                  _nameSprite.addChild(_injuryTxt);
                  this._totalBox.addChild(_nameSprite);
                  if(info.InjuryEffect == 3)
                  {
                     this._totalBox.addChild(_descTxt);
                  }
                  else
                  {
                     this._totalBox.addChild(_castTime);
                     this._totalBox.addChild(_coolDown);
                     this._totalBox.addChild(_descTxt);
                  }
                  this._totalBox.addChild(_line);
               }
               else if($.is(tempInfo, $.C("yishi.datas.templates.VehicleSkillBuffTemplate")))
               {
                  buff = $.as(tempInfo, $.C("yishi.datas.templates.VehicleSkillBuffTemplate"));
                  _nameTxt.text = buff.Name;
                  _descTxt.htmlText = buff.Description;
                  _descTxt.height = _descTxt.textHeight + 5;
                  if(buff.Duration == -1)
                  {
                     _castTime.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.lastTime2",$.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips.Long"));
                     _coolDown.text = $.C("manager.LanguageMgr").GetTranslation("emailII.view.EmailItemView.leftTime",$.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips.Long"));
                  }
                  else
                  {
                     _castTime.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.lastTime",$.int(buff.Duration / 1000));
                     _coolDown.text = $.C("manager.LanguageMgr").GetTranslation("emailII.view.EmailItemView.leftTime",buff.leftTime) + $.C("manager.LanguageMgr").GetTranslation("public.time.second");
                  }
                  this._totalBox.addChild(_nameTxt);
                  this._totalBox.addChild(_castTime);
                  this._totalBox.addChild(_coolDown);
                  this._totalBox.addChild(_descTxt);
                  this._totalBox.addChild(_line);
               }
               else if($.is(tempInfo, $.C("map.campaign.data.skill.MapBuffHurtData")))
               {
                  buffHurt = $.as(tempInfo, $.C("map.campaign.data.skill.MapBuffHurtData"));
                  buffTemp = buffHurt.buffTemplate;
                  _nameTxt.text = buffTemp.Name;
                  _descTxt.htmlText = buffTemp.Description;
                  _descTxt.height = _descTxt.textHeight + 5;
                  this._totalBox.addChild(_nameTxt);
                  if(buffTemp.Duration != -1)
                  {
                     _castTime.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.lastTime",$.int(buffTemp.Duration / 1000));
                     _coolDown.text = $.C("manager.LanguageMgr").GetTranslation("emailII.view.EmailItemView.leftTime",buff.leftTime) + $.C("manager.LanguageMgr").GetTranslation("public.time.second");
                     this._timer = new ($.C("flash.utils.Timer"))(1000);
                     this._timer.start();
                     this._timer.addEventListener("timer",(param1) =>
                     {
                        if(_coolDown)
                        {
                           _coolDown.text = $.C("manager.LanguageMgr").GetTranslation("emailII.view.EmailItemView.leftTime",buff.leftTime) + $.C("manager.LanguageMgr").GetTranslation("public.time.second");
                        }
                     });
                     this._totalBox.addChild(_castTime);
                     this._totalBox.addChild(_coolDown);
                  }
                  this._totalBox.addChild(_descTxt);
                  this._totalBox.addChild(_line);
               }
            }
            this._totalBox.refreshChildPos();
            this._bg.height = this._totalBox.height + 10;
         }
      }
    __onTimerHandler(param1) {
         var _loc2_ = null;
         if(this.tipData)
         {
            _loc2_ = this.tipData;
         }
      }
    dispose() {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__onTimerHandler"));
            this._timer = null;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
  }
  $.meta(__ActiveVehicleBoxTip, "yishi.view.tips.ActiveVehicleBoxTip", []);
  return __ActiveVehicleBoxTip;
}
deps["yishi.view.tips.ActiveVehicleBoxTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.utils.Timer", "manager.LanguageMgr", "map.campaign.data.skill.MapBuffHurtData", "yishi.datas.templates.VehicleSkillBuffTemplate", "yishi.datas.templates.VehicleSkillTempInfo", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.AncientArmoryTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __AncientArmoryTips extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._itemIcon = null;
    self._name = null;
    self._gradeTxt = null;
    self._describe = null;
    self._redBg = null;
    self._yellowBg = null;
    self._purpleBg = null;
    self._blueBg = null;
    self._greenBg = null;
    self._whiteBg = null;
    self._profileImg = null;
    }
    constructor() {
         super();
         this._bg.width = 255;
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this._name.width = 180;
         this._name.y = 5;
         this._gradeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.armoryGradeTxt");
         this._describe = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ancientartifact.armoryDescTipsTxt");
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.armoryTotalBox");
         this._redBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.redItemTipsBg");
         this._yellowBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.yellowItemTipsBg");
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._blueBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blueItemTipsBg");
         this._greenBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.greenItemTipsBg");
         this._whiteBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.whiteItemTipsBg");
         this._itemIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this.addChild(this._redBg);
         this.addChild(this._yellowBg);
         this.addChild(this._purpleBg);
         this.addChild(this._blueBg);
         this.addChild(this._greenBg);
         this.addChild(this._whiteBg);
         this.addChild(this._itemIcon);
         this._itemIcon.x = 9;
         this.addChild(this._profileImg);
         this._profileImg.x = 8;
         this._describe.width = 212;
         this._totalBox.x = 10;
         this._totalBox.y = 58;
         this._totalBox.spacing = 4;
         this.addChild(this._name);
         this.addChild(this._gradeTxt);
         this.addChild(this._totalBox);
      }
    $$updateTransform() {
         var _loc8_ = null;
         var _loc13_ = null;
         var _loc10_ = 0;
         var _loc12_ = null;
         var _loc7_ = null;
         var _loc11_ = null;
         var _loc9_ = 0;
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc3_ = 0;
         var _loc1_ = 0;
         var _loc4_ = 0;
         var _loc6_ = null;
         if(this.tipData)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._totalBox);
            this._totalBox.beginChanges();
            _loc8_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
            _loc8_.width = 215;
            this._totalBox.addChild(_loc8_);
            _loc13_ = $.as(this.tipData, $.C("mvc.module.ancientartifact.AncientArmoryInfo"));
            _loc10_ = $.int(_loc13_.grades);
            this._itemIcon.icon = $.C("yishi.utils.IconFactory").getArmoryIconPath(_loc13_.templateId,_loc13_.profile);
            _loc12_ = $.C("yishi.manager.TempleteManager").instance.armoryTempCate.getTempInfoByTemplateId(_loc13_.templateId,_loc13_.profile);
            this._name.text = _loc12_.TemplateName;
            this._name.setFrame(_loc13_.profile + 1);
            this._gradeTxt.text = $.C("manager.LanguageMgr").GetTranslation("ancientartifact.AncientAdvanceFrame.armoryMarkTips",_loc13_.grades);
            _loc7_ = ["Attacks","PhyDefence","MagicDefence","Live","Parry","Penetrate"];
            _loc11_ = ["AttackAdd","PhyDefenceAdd","MagicDefenceAdd","LiveAdd","ParryAdd","PenetrateAdd"];
            _loc9_ = $.int(_loc7_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc9_)
            {
               _loc3_ = $.int(_loc12_[_loc7_[_loc4_]]);
               _loc1_ = $.int(_loc12_[_loc11_[_loc4_]]) * _loc10_;
               if(_loc3_ > 0)
               {
                  _loc5_ = $.C("manager.LanguageMgr").GetTranslation("ancientartifact.AncientAdvanceFrame.armoryMarkTxt0" + (_loc4_ + 1));
                  _loc2_ = new ($.C("yishi.view.tips.goods.ArtifactEquipItem"))();
                  _loc2_.updateText(_loc5_,_loc3_ + _loc1_);
                  this._totalBox.addChild(_loc2_);
               }
               _loc4_ += 1;
            }
            this._describe.htmlText = _loc12_.Desc;
            this.setProfile(_loc13_.profile);
            _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
            _loc6_.width = 215;
            this._totalBox.addChild(_loc6_);
            this._totalBox.addChild(this._describe);
            this._totalBox.commitChanges();
            this._bg.height = this._totalBox.y + this._totalBox.height + 10;
            this._redBg.height = this._bg.height;
            this._yellowBg.height = this._bg.height;
            this._purpleBg.height = this._bg.height;
            this._blueBg.height = this._bg.height;
            this._greenBg.height = this._bg.height;
            this._whiteBg.height = this._bg.height;
            this._redBg.width = this._bg.width;
            this._yellowBg.width = this._bg.width;
            this._purpleBg.width = this._bg.width;
            this._blueBg.width = this._bg.width;
            this._greenBg.width = this._bg.width;
            this._whiteBg.width = this._bg.width;
            this._redBg.y = this._bg.y - 3;
            this._yellowBg.y = this._bg.y - 3;
            this._purpleBg.y = this._bg.y - 3;
            this._blueBg.y = this._bg.y - 3;
            this._greenBg.y = this._bg.y - 3;
            this._whiteBg.y = this._bg.y - 3;
         }
      }
    setProfile(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._bg.visible = false;
         this._redBg.visible = this._yellowBg.visible = this._purpleBg.visible = this._blueBg.visible = this._greenBg.visible = this._whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               this._greenBg.visible = true;
               this._profileImg.setFrame(2);
               break;
            case 1:
               this._blueBg.visible = true;
               this._profileImg.setFrame(3);
               break;
            case 2:
               this._purpleBg.visible = true;
               this._profileImg.setFrame(4);
               break;
            case 3:
               this._yellowBg.visible = true;
               this._profileImg.setFrame(5);
               break;
            case 4:
               this._redBg.visible = true;
               this._profileImg.setFrame(6);
         }
      }
    dispose() {
         if(this._redBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._redBg);
         }
         this._redBg = null;
         if(this._yellowBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._yellowBg);
         }
         this._yellowBg = null;
         if(this._purpleBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._purpleBg);
         }
         this._purpleBg = null;
         if(this._blueBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blueBg);
         }
         this._blueBg = null;
         if(this._greenBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._greenBg);
         }
         this._greenBg = null;
         if(this._whiteBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._whiteBg);
         }
         this._whiteBg = null;
         if(this._itemIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemIcon);
         }
         this._itemIcon = null;
         if(this._profileImg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._profileImg);
         }
         this._profileImg = null;
         if(this._totalBox)
         {
            this._totalBox.dispose();
         }
         this._totalBox = null;
         if(this._describe)
         {
            this._describe.dispose();
         }
         this._describe = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__AncientArmoryTips, "yishi.view.tips.AncientArmoryTips", []);
  return __AncientArmoryTips;
}
deps["yishi.view.tips.AncientArmoryTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "mvc.module.ancientartifact.AncientArmoryInfo", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.ArtifactEquipItem"];

defs["yishi.view.tips.AppellInfoTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __AppellInfoTips extends __Base {
    static $fields(self) {
    self._container = null;
    self._appellTopDescribe = null;
    self._appellTopView = null;
    self._line = null;
    self._appellTalkDescribe = null;
    self._appellTalkView = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         $.C("yishi.manager.EnterFrameManager").instance.registeEnterFrame(this);
         this._container = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.TipContain");
         this._appellTopDescribe = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.AppellInfoTips.AppellTopDescribe");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.AppellInfoTips.AppellInfoTipsLine");
         this._appellTalkDescribe = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.AppellInfoTips.AppellTalkDescribe");
         this.addChild(this._container);
      }
    enterFrame() {
         if(this._appellTopView)
         {
            this._appellTopView.draw();
         }
      }
    clean() {
         this._container.removeAllChild();
         this._container.refreshChildPos();
         if(this._appellTopView && this._appellTopView.parent)
         {
            this._appellTopView.parent.removeChild(this._appellTopView);
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellTopView);
         this._appellTopView = null;
      }
    $$updateTransform() {
         var _loc1_ = null;
         this.clean();
         if($.is(this._data, $.C("yishi.datas.templates.AppellInfoTemplate")))
         {
            this._appellTopView = new ($.C("avatar.view.SimpleAvatarView"))(this._data.ImgWidth,this._data.ImgHeight,$.C("yishi.manager.PathManager").getAppellImgPath(this._data.TemplateId),this._data.ImgCount);
            this._appellTopView.drawFrame = this._data.ImgFrame;
            this._appellTopDescribe.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.AppellInfoTips.AppellTopDescribeTxt");
            this._appellTalkDescribe.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.AppellInfoTips.AppellTalkDescribeTxt");
            this._container.addChild(this._appellTopDescribe);
            this._container.addChild(this._appellTopView);
            if(this._data.Perfix != "")
            {
               _loc1_ = "chatII.Appell" + $.C("yishi.manager.AppellManager").instance.model.getPerfixStyle(this._data.TemplateId);
               this._appellTalkView = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject(_loc1_);
               this._container.addChild(this._line);
               this._container.addChild(this._appellTalkDescribe);
               this._container.addChild(this._appellTalkView);
            }
            this._appellTopView.x = (this._container.width - this._appellTopView.width) * 0.5;
            this._line.width = this._container.width;
            if(this._appellTalkView)
            {
               this._appellTalkView.x = (this._container.width - this._appellTalkView["content"].width) * 0.5;
            }
            this._bg.width = this._container.x + this._container.width + 15;
            this._bg.height = this._container.y + this._container.height + 15;
         }
      }
    dispose() {
         $.C("yishi.manager.EnterFrameManager").instance.unRegisteEnterFrame(this);
         this.clean();
         if(this._appellTopDescribe)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellTopDescribe);
         }
         this._appellTopDescribe = null;
         if(this._line)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         }
         this._line = null;
         if(this._appellTalkDescribe)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellTalkDescribe);
         }
         this._appellTalkDescribe = null;
         if(this._appellTalkView)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._appellTalkView);
         }
         this._appellTalkView = null;
         this._data = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__AppellInfoTips, "yishi.view.tips.AppellInfoTips", ["IEnterFrame"]);
  return __AppellInfoTips;
}
deps["yishi.view.tips.AppellInfoTips"] = ["avatar.view.SimpleAvatarView", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.templates.AppellInfoTemplate", "yishi.manager.AppellManager", "yishi.manager.EnterFrameManager", "yishi.manager.PathManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.ArchaeologyUpgradeRewardTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ArchaeologyUpgradeRewardTips extends __Base {
    static $fields(self) {
    self.nextLevelAlertText = null;
    self.nextLevelText = null;
    self.canGetText = null;
    self.appellText = null;
    self.mountText = null;
    self.appellTemp = null;
    self.itemTemp = null;
    self.appellName = "";
    self.mountName = "";
    self.nextBookTemp = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.nextLevelAlertText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ArchaeologyUpgradeRewardTips.nextLevelAlertText");
         this.nextLevelText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ArchaeologyUpgradeRewardTips.nextLevelText");
         this.canGetText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ArchaeologyUpgradeRewardTips.canGetText");
         this.appellText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ArchaeologyUpgradeRewardTips.appellText");
         this.mountText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ArchaeologyUpgradeRewardTips.mountText");
         this.addChild(this.nextLevelAlertText);
         this.addChild(this.nextLevelText);
         this.addChild(this.canGetText);
         this.addChild(this.appellText);
         this.addChild(this.mountText);
         this.nextLevelAlertText.text = $.C("manager.LanguageMgr").GetTranslation("ArchaeologyUpgradeRewardTips.nextLevelAlertText.text");
         this.canGetText.text = $.C("manager.LanguageMgr").GetTranslation("ArchaeologyUpgradeRewardTips.canGetText.text");
         this._bg.width = 220;
         this._bg.height = 105;
      }
    $$updateTransform() {
         this.cleanData();
         if(this._data)
         {
            this.nextLevelText.text = $.C("manager.LanguageMgr").GetTranslation("ArchaeologyFrame.levelText.text" + this._data.Collection1);
            this.appellTemp = $.C("yishi.manager.TempleteManager").instance.appellInfoTemplateCate.getTemplateByID(this._data.RewardAppell);
            this.itemTemp = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(this._data.RewardId1);
            if(this.appellTemp)
            {
               this.appellName = this.appellTemp.Title;
            }
            if(this.itemTemp)
            {
               this.mountName = this.itemTemp.TemplateName;
            }
            this.appellText.htmlText = $.C("manager.LanguageMgr").GetTranslation("ArchaeologyUpgradeRewardTips.appellText.text",this.appellName);
            this.mountText.htmlText = $.C("manager.LanguageMgr").GetTranslation("ArchaeologyUpgradeRewardTips.mountText.text",this.mountName);
            this._bg.width = Math.max(this.appellText.x + this.appellText.textWidth + 10,this.mountText.x + this.mountText.textWidth + 10);
            this._bg.width = Math.max(220,this._bg.width);
         }
      }
    cleanData() {
         this.nextLevelText.text = "";
         this.appellText.text = "";
         this.mountText.text = "";
         this.appellTemp = null;
         this.itemTemp = null;
         this.appellName = "";
         this.mountName = "";
      }
    get model() {
         return $.C("yishi.manager.ArchaeologyManager").instance.model;
      }
    dispose() {
         if(this.nextLevelAlertText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nextLevelAlertText);
         }
         this.nextLevelAlertText = null;
         if(this.nextLevelText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nextLevelText);
         }
         this.nextLevelText = null;
         if(this.canGetText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.canGetText);
         }
         this.canGetText = null;
         if(this.appellText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.appellText);
         }
         this.appellText = null;
         if(this.mountText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.mountText);
         }
         this.mountText = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set model(v) { super.model = v; }
  }
  $.meta(__ArchaeologyUpgradeRewardTips, "yishi.view.tips.ArchaeologyUpgradeRewardTips", []);
  return __ArchaeologyUpgradeRewardTips;
}
deps["yishi.view.tips.ArchaeologyUpgradeRewardTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.manager.ArchaeologyManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.AvengerJewelryTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __AvengerJewelryTips extends __Base {
    static $fields(self) {
    self._item = null;
    self._nameText = null;
    self._gradeTxt = null;
    self._propTitleText = null;
    self._propBox = null;
    self._skillTitleText = null;
    self._skillDescText = null;
    self._line1 = null;
    self._line2 = null;
    self._redBg = null;
    self._yellowBg = null;
    self._purpleBg = null;
    self._blueBg = null;
    self._greenBg = null;
    self._whiteBg = null;
    }
    constructor() {
         super();
         this._item = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.BaseItemView");
         this._nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this._gradeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("AvengerJewelryTips.gradeTxt");
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._propTitleText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.attText");
         this._propBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("AvengerJewelryTips.propBox");
         this._line2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._skillTitleText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.attText");
         this._skillDescText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitTempText");
         this._redBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.redItemTipsBg");
         this._yellowBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.yellowItemTipsBg");
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._blueBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blueItemTipsBg");
         this._greenBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.greenItemTipsBg");
         this._whiteBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.whiteItemTipsBg");
         this.addChild(this._redBg);
         this.addChild(this._yellowBg);
         this.addChild(this._purpleBg);
         this.addChild(this._blueBg);
         this.addChild(this._greenBg);
         this.addChild(this._whiteBg);
         this.addChild(this._item);
         this.addChild(this._nameText);
         this.addChild(this._gradeTxt);
         this.addChild(this._line1);
         this._line1.y = 65;
         this.addChild(this._propTitleText);
         this._propTitleText.y = 55;
         this.addChild(this._propBox);
         this._propBox.x = 14;
         this._propBox.y = 80;
         this.addChild(this._line2);
         this.addChild(this._skillTitleText);
         this.addChild(this._skillDescText);
         this._skillDescText.x = 25;
         this._skillDescText.width = 250;
         this._propTitleText.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.pawnupgrade.property");
         this._skillTitleText.text = $.C("manager.LanguageMgr").GetTranslation("HigherGradeOpenTipView.content2");
         this._bg.width = 312;
         this._nameText.width = 225;
         this._item.x = 9;
         this._redBg.width = this._yellowBg.width = this._purpleBg.width = this._blueBg.width = this._greenBg.width = this._whiteBg.width = this._bg.width;
      }
    $$updateTransform() {
         var _loc5_ = null;
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc7_ = 0;
         var _loc2_ = null;
         var _loc1_ = 0;
         var _loc6_ = null;
         if(this.tipData)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._propBox);
            this._propBox.beginChanges();
            _loc5_ = $.as(this.tipData, $.C("yishi.datas.goods.GoodsInfo"));
            this._item.data = _loc5_;
            this.setProfile(_loc5_.templateInfo.Profile);
            this._nameText.text = _loc5_.templateInfo.TemplateName;
            this._nameText.setFrame(_loc5_.templateInfo.Profile);
            this._gradeTxt.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc5_.templateInfo.Property1);
            _loc3_ = ["Attack","Defence","MagicDefence","Live"];
            _loc4_ = 1;
            while(_loc4_ <= _loc3_.length)
            {
               _loc7_ = $.int(_loc5_.templateInfo[_loc3_[_loc4_ - 1]]);
               _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.simpleGoodSkillText");
               _loc2_.text = $.C("manager.LanguageMgr").GetTranslation("AvengerBodyPropItem.propText1" + _loc4_,_loc7_);
               this._propBox.addChild(_loc2_);
               _loc4_++;
            }
            this._propBox.commitChanges();
            _loc1_ = $.int(_loc5_.templateInfo.Property4);
            _loc6_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc1_];
            if(_loc6_)
            {
               this._skillDescText.text = _loc6_.Description;
            }
            this._line2.y = this._propBox.y + this._propBox.height + 13;
            this._skillTitleText.y = this._line2.y - 7;
            this._skillDescText.y = this._skillTitleText.y + this._skillTitleText.height + 5;
            this._bg.height = this._skillDescText.y + this._skillDescText.height + 10;
            this._redBg.height = this._bg.height;
            this._yellowBg.height = this._bg.height;
            this._purpleBg.height = this._bg.height;
            this._blueBg.height = this._bg.height;
            this._greenBg.height = this._bg.height;
            this._whiteBg.height = this._bg.height;
            this._redBg.y = this._bg.y - 3;
            this._yellowBg.y = this._bg.y - 3;
            this._purpleBg.y = this._bg.y - 3;
            this._blueBg.y = this._bg.y - 3;
            this._greenBg.y = this._bg.y - 3;
            this._whiteBg.y = this._bg.y - 3;
         }
      }
    setProfile(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._bg.visible = false;
         this._redBg.visible = this._yellowBg.visible = this._purpleBg.visible = this._blueBg.visible = this._greenBg.visible = this._whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               this._whiteBg.visible = true;
               break;
            case 1:
               this._greenBg.visible = true;
               break;
            case 2:
               this._blueBg.visible = true;
               break;
            case 3:
               this._purpleBg.visible = true;
               break;
            case 4:
               this._yellowBg.visible = true;
               break;
            case 5:
               this._redBg.visible = true;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__AvengerJewelryTips, "yishi.view.tips.AvengerJewelryTips", []);
  return __AvengerJewelryTips;
}
deps["yishi.view.tips.AvengerJewelryTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.goods.GoodsInfo", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.BattleGuardItemTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __BattleGuardItemTip extends __Base {
    static $fields(self) {
    self._nameTxt = null;
    self._contentTxt = null;
    self._line = null;
    self._vBox = null;
    self._oneLineTxt = null;
    }
    constructor() {
         super();
      }
    init() {
         var _loc2_ = 0;
         var _loc1_ = null;
         super.init();
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("BattleGuardItemTip.nameTxt");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("BattleGuardItemTip.Line");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("BattleGuardItemTip.contentTxt");
         this.addChild(this._nameTxt);
         this.addChild(this._line);
         this.addChild(this._contentTxt);
         this._bg.width = 230;
         this._bg.height = 70;
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("BattleGuardItemTip.vbox01");
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new ($.C("yishi.view.tips.BattleGuardItemTip$$SocketItemView"))();
            this._vBox.addChild(_loc1_);
            _loc2_++;
         }
         this._oneLineTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.commonTipText");
      }
    $$updateTransform() {
         var _loc1_ = 0;
         if(!($.is(this.tipData, $.C("yishi.datas.playerinfo.BattleGuardSocketInfo"))))
         {
            return;
         }
         var _loc3_ = $.as(this.tipData, $.C("yishi.datas.playerinfo.BattleGuardSocketInfo"));
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("BattleGuardItemNames").split(",");
         if(_loc3_.type == 1)
         {
            _loc1_ = _loc3_.pos + 7;
            this._nameTxt.text = _loc2_[0];
         }
         else
         {
            _loc1_ = _loc3_.pos + 1;
            this._nameTxt.text = _loc2_[_loc1_];
         }
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         this.addChild(this._bg);
         if(_loc3_.state == 1)
         {
            this.addChild(this._nameTxt);
            this.addChild(this._line);
            this.addChild(this._vBox);
            this.openStateTip(_loc3_);
         }
         else
         {
            this.addChild(this._nameTxt);
            this.addChild(this._line);
            this.addChild(this._contentTxt);
            this.lockStateTip(_loc1_);
         }
      }
    get height() {
         if(this._bg)
         {
            return this._bg.height;
         }
         return super.height;
      }
    get width() {
         if(this._bg)
         {
            return this._bg.width;
         }
         return super.width;
      }
    openStateTip(param1) {
         var _loc4_ = 0;
         var _loc2_ = null;
         var _loc3_ = null;
         _loc4_ = 0;
         while(_loc4_ < this._vBox.numChildren)
         {
            _loc2_ = $.as(this._vBox.getChildAt(_loc4_), $.C("yishi.view.tips.BattleGuardItemTip$$SocketItemView"));
            _loc3_ = param1.getTempByPos(_loc4_);
            _loc2_.setData(_loc3_);
            _loc4_++;
         }
         this._bg.width = 230;
         this._bg.height = this._vBox.y + this._vBox.height + 10;
      }
    lockStateTip(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc4_ = null;
         var _loc5_ = null;
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.getTemplatesByType(28);
         for (var _loc3_ of $.values(_loc2_))
         {
            if(_loc3_.ActiveObject == param1)
            {
               _loc4_ = _loc3_;
               break;
            }
         }
         if(_loc4_)
         {
            _loc5_ = "";
            if(param1 < 7)
            {
               _loc5_ = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.EquipView.runes",_loc4_.Grades);
               if(_loc4_.Data > 0)
               {
                  _loc5_ += "<br/>" + $.C("manager.LanguageMgr").GetTranslation("BattleGuardItemTip.pointTip",_loc4_.Data);
               }
            }
            else
            {
               _loc5_ = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.EquipView.runes",_loc4_.Grades);
            }
            this._contentTxt.htmlText = _loc5_;
            this._contentTxt.height = this._contentTxt.textHeight + 5;
         }
         this._bg.width = Math.max(this._contentTxt.textWidth + 23,210);
         this._bg.height = this._contentTxt.y + this._contentTxt.textHeight + 10;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameTxt);
         this._nameTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contentTxt);
         this._contentTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         this._line = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         this._vBox = null;
         super.dispose();
      }
    set height(v) { super.height = v; }
    set width(v) { super.width = v; }
  }
  $.meta(__BattleGuardItemTip, "yishi.view.tips.BattleGuardItemTip", []);
  return __BattleGuardItemTip;
}
deps["yishi.view.tips.BattleGuardItemTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.playerinfo.BattleGuardSocketInfo", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip", "yishi.view.tips.BattleGuardItemTip$$SocketItemView"];

defs["yishi.view.tips.BattleGuardItemTip$$SocketItemView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __BattleGuardItemTip__SocketItemView extends __Base {
    static $fields(self) {
    self._icon = null;
    self._txt = null;
    }
    constructor() {
      super();
      this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("SocketItemView.icon");
      this._txt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("SocketItemView.txt");
      this.addChild(this._icon);
      this.addChild(this._txt);
   }
    setData(param1) {
      var _loc2_ = 0;
      var _loc3_ = null;
      if(param1)
      {
         _loc2_ = $.int(param1.Property2);
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("public.level4_space2",_loc2_);
         if(_loc2_ > 9)
         {
            _loc3_ += " " + param1.Description;
         }
         else
         {
            _loc3_ += "  " + param1.Description;
         }
         this._txt.htmlText = _loc3_;
         this._icon.icon = param1.iconPath;
      }
      else
      {
         this._txt.htmlText = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.InlayItem.value02");
         this._icon.icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.equipUnmount");
      }
   }
    dispose() {
      $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._icon);
      this._icon = null;
      $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._txt);
      this._txt = null;
   }
  }
  $.meta(__BattleGuardItemTip__SocketItemView, "yishi.view.tips.BattleGuardItemTip$$SocketItemView", []);
  return __BattleGuardItemTip__SocketItemView;
}
deps["yishi.view.tips.BattleGuardItemTip$$SocketItemView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr"];

defs["yishi.view.tips.BingoCardTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __BingoCardTips extends __Base {
    static $fields(self) {
    self._numberBg = null;
    self._titleContain = null;
    self._titleAsset = null;
    self._itemList = [];
    }
    constructor() {
         super();
      }
    init() {
         var _loc2_ = 0;
         var _loc1_ = null;
         super.init();
         this._bg.visible = false;
         this._numberBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.cardBingoBg");
         this._titleAsset = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.tips.cardTitleNumAsset");
         this._titleContain = new ($.C("com.pickgliss.ui.core.Component"))();
         this.addChild(this._numberBg);
         this.addChild(this._titleContain);
         _loc2_ = 0;
         while(_loc2_ < 25)
         {
            _loc1_ = new ($.C("yishi.view.tips.BingoCardTips$$BingoCardItem"))();
            _loc1_.x = 42 + $.int(_loc2_ % 5) * 50;
            _loc1_.y = 90 + $.int(_loc2_ / 5) * 50;
            this.addChild(_loc1_);
            this._itemList.push(_loc1_);
            _loc2_++;
         }
         this.scaleX = 0.7;
         this.scaleY = 0.7;
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc2_ = 0;
         if(this.tipData)
         {
            this.clean();
            _loc1_ = $.as(this.tipData, $.C("com.road.yishi.proto.bingo.BingoCardTempMsg"));
            _loc2_ = 0;
            while(_loc2_ < this._itemList.length)
            {
               this._itemList[_loc2_].data = _loc1_.cardNum[_loc2_];
               _loc2_++;
            }
            $.C("yishi.utils.NumberViewUtils").refreshValue(this._data.cardId,this._titleContain,this._titleAsset,28,39,25,28,"0123456789");
            this._titleContain.x = (this._numberBg.width - this._titleContain.displayWidth) / 2;
            this._titleContain.y = 10;
         }
      }
    clean() {
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__BingoCardTips, "yishi.view.tips.BingoCardTips", []);
  return __BingoCardTips;
}
deps["yishi.view.tips.BingoCardTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "com.road.yishi.proto.bingo.BingoCardTempMsg", "yishi.utils.NumberViewUtils", "yishi.view.tips.BaseTip", "yishi.view.tips.BingoCardTips$$BingoCardItem"];

defs["yishi.view.tips.BingoCardTips$$BingoCardItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __BingoCardTips__BingoCardItem extends __Base {
    static $fields(self) {
    self._numberAsset = null;
    self._numberContain = null;
    }
    constructor() {
      super();
      this._numberAsset = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.bingo.cardNumAsset");
      this._numberContain = new ($.C("com.pickgliss.ui.core.Component"))();
      this.addChild(this._numberContain);
   }
    set data(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
      $.C("yishi.utils.NumberViewUtils").refreshValue(param1,this._numberContain,this._numberAsset,15,20,13,15,"0123456789");
      this._numberContain.x = param1 < 10 ? 17 : 10;
      this._numberContain.y = 15;
      this._numberContain.visible = param1 == 0 ? false : true;
   }
    dispose() {
   }
    get data() { return super.data; }
  }
  $.meta(__BingoCardTips__BingoCardItem, "yishi.view.tips.BingoCardTips$$BingoCardItem", []);
  return __BingoCardTips__BingoCardItem;
}
deps["yishi.view.tips.BingoCardTips$$BingoCardItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "yishi.utils.NumberViewUtils"];

defs["yishi.view.tips.BufferTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __BufferTips extends __Base {
    static $fields(self) {
    self._box = null;
    self._title = null;
    self._describe = null;
    self._timeContan = null;
    self._remainTime = null;
    self._time = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._bg.width = 230;
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("campaign.titleTxt_2");
         this._describe = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("buffer.DiscribeTxt");
         this._remainTime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("campaign.rightText");
         this._time = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.bufferTime");
         this._box = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.TipContain");
         this._title.autoSize = this._remainTime.autoSize = this._time.autoSize = "left";
         this._remainTime.text = $.C("manager.LanguageMgr").GetTranslation("public.colon",$.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.BufferTips.remainTime.text"));
         this._timeContan = new ($.C("flash.display.Sprite"))();
         this._timeContan.addChild(this._remainTime);
         this._timeContan.addChild(this._time);
         this._time.x = this._remainTime.x + this._remainTime.textWidth + 5;
         this.addChild(this._box);
      }
    clean() {
         this._box.removeAllChild();
         this._time.htmlText = "";
         this._time.height = 20;
      }
    $$updateTransform() {
         var _loc3_ = null;
         var _loc2_ = null;
         var _loc1_ = null;
         this.clean();
         if($.is(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo")))
         {
            _loc3_ = $.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"));
            _loc2_ = _loc3_.description;
            _loc1_ = /\|/g;
            _loc2_ = _loc2_.replace(_loc1_,",");
            this._title.htmlText = _loc3_.name;
            this._describe.htmlText = _loc2_;
            this._describe.height = this._describe.textHeight + this._describe.numLines * 4;
            this._box.addChild(this._title);
            this._box.addChild(this._describe);
            this._remainTime.setFrame(1);
            if(_loc3_.bufferType == -4 && _loc3_.masterType != 1000)
            {
               this._describe.height = this._describe.textHeight + this._describe.numLines * 2;
               this._time.htmlText = $.C("manager.LanguageMgr").GetTranslation("buffer.BasePropertyBuffer");
               this._time.height = this._time.textHeight + this._time.numLines * 2;
               this._remainTime.setFrame(2);
               this._box.addChild(this._timeContan);
            }
            else if(_loc3_.leftTime > 0)
            {
               this.showTimeStr();
               this._box.addChild(this._timeContan);
            }
            this._box.refreshChildPos();
            this._bg.height = this._box.x + this._box.height + 5;
            this.__changeHandler(null);
            ($.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"))).addEventListener("change",$.bind(this, "__changeHandler"));
         }
      }
    __changeHandler(param1) {
         this.showTimeStr();
      }
    showTimeStr() {
         if(!this._data)
         {
            return;
         }
         if(!this.parent)
         {
            return;
         }
         if($.is(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo")) && this._data.bufferType == -4 && $.cast($.C("yishi.datas.playerinfo.PlayerBufferInfo"), this._data).masterType != 1000)
         {
            return;
         }
         if($.is(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo")) && $.cast($.C("yishi.datas.playerinfo.PlayerBufferInfo"), this._data).bufferType == 20000)
         {
            return;
         }
         var _loc1_ = "";
         if(($.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"))).leftTime >= 86400)
         {
            _loc1_ = $.int(($.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"))).leftTime / 86400) + $.C("manager.LanguageMgr").GetTranslation("public.day") + $.int(($.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"))).leftTime / 3600 % 24) + $.C("manager.LanguageMgr").GetTranslation("public.time.hour") + $.int(($.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"))).leftTime % 3600 / 60) + $.C("manager.LanguageMgr").GetTranslation("public.minute");
         }
         else if(($.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"))).leftTime >= 3600)
         {
            _loc1_ = $.int(($.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"))).leftTime / 3600) + $.C("manager.LanguageMgr").GetTranslation("public.time.hour") + $.int(($.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"))).leftTime % 3600 / 60) + $.C("manager.LanguageMgr").GetTranslation("public.minute");
         }
         else if(this._data.leftTime >= 60)
         {
            _loc1_ = $.int(($.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"))).leftTime / 60) + $.C("manager.LanguageMgr").GetTranslation("public.minute");
         }
         else
         {
            _loc1_ = $.C("yishi.utils.DateFormatter").getCountDate(($.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"))).leftTime,2,2);
         }
         this._time.text = _loc1_;
      }
    dispose() {
         ($.as(this._data, $.C("yishi.datas.playerinfo.PlayerBufferInfo"))).removeEventListener("change",$.bind(this, "__changeHandler"));
         this._data = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._timeContan);
         if(this._title)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         }
         this._title = null;
         if(this._describe)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._describe);
         }
         this._describe = null;
         if(this._remainTime)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._remainTime);
         }
         this._remainTime = null;
         if(this._time)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._time);
         }
         this._time = null;
         if(this._box)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._box);
         }
         this._box = null;
         if(this._timeContan)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeContan);
         }
         this._timeContan = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__BufferTips, "yishi.view.tips.BufferTips", []);
  return __BufferTips;
}
deps["yishi.view.tips.BufferTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.datas.playerinfo.PlayerBufferInfo", "yishi.utils.DateFormatter", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.BuildTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __BuildTip extends __Base {
    static $fields(self) {
    self._vBox = null;
    self._line1 = null;
    self._line2 = null;
    self._name = null;
    self._current = null;
    self._currentEffect = null;
    self._currentEffectValue = null;
    self._next = null;
    self._nextEffect = null;
    self._nextEffectValue = null;
    self._nextGrade = null;
    self._gradeContain = null;
    self._grade = null;
    self._gradeValue = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 270;
         this._vBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._vBox.y = 10;
         this._vBox.spacing = 5;
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._line2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._line1.width = this._line2.width = this._bg.width - 15;
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildNameText");
         this._currentEffect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectText");
         this._currentEffectValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectValueText");
         this._nextEffect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectText");
         this._nextEffectValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectValueText");
         this._nextGrade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildNextGradeText");
         this._grade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildText");
         this._gradeValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildValueText");
         this._current = new ($.C("flash.display.Sprite"))();
         this._current.addChild(this._currentEffect);
         this._current.addChild(this._currentEffectValue);
         this._next = new ($.C("flash.display.Sprite"))();
         this._next.addChild(this._nextEffect);
         this._next.addChild(this._nextEffectValue);
         this._gradeContain = new ($.C("flash.display.Sprite"))();
         this._gradeContain.addChild(this._grade);
         this._gradeContain.addChild(this._gradeValue);
         this.addChild(this._vBox);
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc2_ = null;
         if(this.tipData)
         {
            this._vBox.removeAllChild();
            _loc1_ = ($.as(this.tipData, $.C("mvc.module.buildings.BuildInfo"))).templeteInfo;
            this._name.text = _loc1_.BuildingName + " " + $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc1_.BuildingGrade);
            this._currentEffect.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.current");
            this._currentEffectValue.htmlText = _loc1_.Activity + this.getMsAddValue(_loc1_);
            this._currentEffectValue.height = this._currentEffectValue.textHeight + 4;
            this._vBox.addChild(this._name);
            this._vBox.addChild(this._line1);
            this._vBox.addChild(this._current);
            _loc2_ = this.getNextGrade(_loc1_);
            if(!_loc2_)
            {
               this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.maxGrade");
               this._vBox.addChild(this._line2);
               this._vBox.addChild(this._nextGrade);
            }
            else
            {
               this.refreshNextTemp(_loc2_);
               this.refreshPlayerGrade(_loc2_);
            }
            this._vBox.refreshChildPos();
            this._bg.height = this._vBox.displayHeight + 20;
         }
      }
    refreshNextTemp(param1) {
         if(param1)
         {
            this._nextEffect.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.next");
            this._nextEffectValue.htmlText = param1.Activity + this.getMsAddValue(param1);
            this._nextEffectValue.height = this._nextEffectValue.textHeight + 4;
            this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.need");
            this._vBox.addChild(this._next);
            this._vBox.addChild(this._line2);
            this._vBox.addChild(this._nextGrade);
         }
      }
    getMsAddValue(param1) {
         var _loc4_ = 0;
         var _loc2_ = "";
         if(param1.SonType != 901)
         {
            return _loc2_;
         }
         var _loc3_ = $.C("managers.MagicSpringManager").instance.model.checkIsExistBuffer(1);
         if(_loc3_)
         {
            _loc4_ = Math.floor(_loc3_.tempInfo.AddValue * param1.Property1 / 100);
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("MagicSpringFrame.buffer.addText",_loc4_);
         }
         return _loc2_;
      }
    refreshPlayerGrade(param1) {
         if(param1)
         {
            this._grade.text = $.C("manager.LanguageMgr").GetTranslation("SeminaryFrameRightView.command09");
            this._gradeValue.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.gradeValue",this.thane.grades + 1);
            this._gradeValue.height = this._gradeValue.textHeight + 4;
            this._gradeValue.setFrame(2);
            this._vBox.addChild(this._gradeContain);
         }
      }
    get playerEffect() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerEffect;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    getNextGrade(param1) {
         if(param1.NextGradeTemplateId != 0)
         {
            return $.C("yishi.manager.TempleteManager").instance.buildTemplateCate.getTemplateByID($.int(param1.NextGradeTemplateId));
         }
         return null;
      }
    dispose() {
         if(this._line1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         }
         this._line1 = null;
         if(this._line2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line2);
         }
         this._line2 = null;
         if(this._name)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         }
         this._name = null;
         if(this._current)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._current);
         }
         this._current = null;
         if(this._currentEffect)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentEffect);
         }
         this._currentEffect = null;
         if(this._currentEffectValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentEffectValue);
         }
         this._currentEffectValue = null;
         if(this._next)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._next);
         }
         this._next = null;
         if(this._nextEffect)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextEffect);
         }
         this._nextEffect = null;
         if(this._nextEffectValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextEffectValue);
         }
         this._nextEffectValue = null;
         if(this._nextGrade)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextGrade);
         }
         this._nextGrade = null;
         if(this._gradeContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeContain);
         }
         this._gradeContain = null;
         if(this._grade)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._grade);
         }
         this._grade = null;
         if(this._gradeValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeValue);
         }
         this._gradeValue = null;
         if(this._vBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         }
         this._vBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set playerEffect(v) { super.playerEffect = v; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__BuildTip, "yishi.view.tips.BuildTip", []);
  return __BuildTip;
}
deps["yishi.view.tips.BuildTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "managers.MagicSpringManager", "mvc.module.buildings.BuildInfo", "yishi.manager.ArmyManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.BuyAvartarTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __BuyAvartarTip extends __Base {
    static $fields(self) {
    self._pointBmp = null;
    self._selfTipTxt = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._pointBmp = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.PayType");
         this._selfTipTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("worldboss.BuyAvatarFrame.DescriptionTxt");
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance;
         var _loc3_ = 200;
         if(_loc4_.getConfigInfoByConfigName("WorldBoss_Replacement_Price"))
         {
            _loc3_ = parseInt(_loc4_.getConfigInfoByConfigName("WorldBoss_Replacement_Price").ConfigValue);
         }
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("worldboss.BuyAvatarFrame.command02",_loc3_);
         this._selfTipTxt.htmlText = _loc1_;
         var _loc2_ = this._selfTipTxt.getCharBoundaries(this._selfTipTxt.text.indexOf("$"));
         this._pointBmp.setFrame(1);
         this._pointBmp.y = this._selfTipTxt.y;
         this._pointBmp.x = _loc2_.x + 6;
         this._selfTipTxt.htmlText = _loc1_.replace("$","");
         this.addChild(this._selfTipTxt);
         this.addChild(this._pointBmp);
         this._bg.beginChanges();
         this._bg.height = 78;
         this._bg.commitChanges();
      }
    $$updateTransform() {
      }
    get height() {
         return this._bg.height;
      }
    dispose() {
         super.dispose();
         this._pointBmp = null;
         this._selfTipTxt = null;
      }
    set height(v) { super.height = v; }
  }
  $.meta(__BuyAvartarTip, "yishi.view.tips.BuyAvartarTip", []);
  return __BuyAvartarTip;
}
deps["yishi.view.tips.BuyAvartarTip"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.CampaignMapPhysicsTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.MultipleDictionaryTip");
  class __CampaignMapPhysicsTip extends __Base {
    static $fields(self) {
    self._titleTxtStyle = null;
    }
    constructor() {
         super();
      }
    $$updateTransform() {
         var _loc3_ = undefined;
         var _loc1_ = null;
         var _loc5_ = NaN;
         var _loc6_ = 0;
         var _loc2_ = null;
         var _loc4_ = null;
         if($.is(this._data, $.C("yishi.view.tips.MultipleDictionaryInfo")))
         {
            this.removeAllItem();
            _loc3_ = ($.as(this._data, $.C("yishi.view.tips.MultipleDictionaryInfo"))).data;
            for(var _loc7_ in _loc3_[0])
            {
               _loc1_ = this.getTextItem(_loc7_,this.titleTxtStyle);
               this._leftTxtList.push(_loc1_);
               this._rightTxtList.push(null);
               this._maxWidth = _loc1_.textWidth;
            }
            _loc5_ = 0;
            _loc6_ = 1;
            while(_loc6_ < _loc3_.length)
            {
               for(var _loc8_ in _loc3_[_loc6_])
               {
                  _loc2_ = this.getTextItem(_loc8_,this._leftTxtStyle);
                  this._maxLeftTxtWidth = _loc2_.textWidth > this._maxLeftTxtWidth ? _loc2_.textWidth : this._maxLeftTxtWidth;
                  this._leftTxtList.push(_loc2_);
                  _loc4_ = this.getTextItem(_loc3_[_loc6_][_loc8_],this._rightTxtStyle,false);
                  if(_loc4_)
                  {
                     _loc5_ = Number(_loc4_.textWidth > _loc5_ ? _loc4_.textWidth : _loc5_);
                  }
                  this._rightTxtList.push(_loc4_);
               }
               _loc6_++;
            }
            this._maxWidth = Math.max(this._maxLeftTxtWidth + _loc5_,this._maxWidth);
            this.sortList();
         }
      }
    set titleTxtStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._titleTxtStyle == param1)
         {
            return;
         }
         this._titleTxtStyle = param1;
      }
    get titleTxtStyle() {
         return this._titleTxtStyle;
      }
  }
  $.meta(__CampaignMapPhysicsTip, "yishi.view.tips.CampaignMapPhysicsTip", []);
  return __CampaignMapPhysicsTip;
}
deps["yishi.view.tips.CampaignMapPhysicsTip"] = ["yishi.view.tips.MultipleDictionaryInfo", "yishi.view.tips.MultipleDictionaryTip"];

defs["yishi.view.tips.CatRewardTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __CatRewardTips extends __Base {
    static $fields(self) {
    self._rewardTxt = null;
    self._icon = null;
    self._numBg = null;
    self._countTxt = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 182;
         this._bg.height = 75;
         this._rewardTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.catHouseRewardTxt");
         this._numBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.numBg");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.catHouseMaterialIcon");
         this._countTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.catHouseMaterialTxt");
         this.addChild(this._rewardTxt);
         this.addChild(this._numBg);
         this.addChild(this._icon);
         this.addChild(this._countTxt);
      }
    $$updateTransform() {
         var _loc1_ = null;
         if(this.tipData)
         {
            this.clean();
            _loc1_ = $.as(this.tipData, $.C("yishi.datas.templates.CatHouseTemplateInfo"));
            this._icon.setFrame(this.goodsIdToImageId(_loc1_.OutTempId) + 1);
            this._countTxt.text = String(_loc1_.OutTempCount);
            this._rewardTxt.text = $.C("manager.LanguageMgr").GetTranslation("catHouse.CatRewardTips.rewardTxt");
         }
      }
    goodsIdToImageId(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = param1;
         if(param1 == -100)
         {
            _loc2_ = 7;
         }
         else if(param1 < 0)
         {
            _loc2_ = -(_loc2_ + 2000) / 100;
         }
         return _loc2_;
      }
    clean() {
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__CatRewardTips, "yishi.view.tips.CatRewardTips", []);
  return __CatRewardTips;
}
deps["yishi.view.tips.CatRewardTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.templates.CatHouseTemplateInfo", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.CatToyTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __CatToyTips extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._nameTxt = null;
    self._matureTimeTxt = null;
    self._outputTxt = null;
    self._describe = null;
    self._yellowBg = null;
    self._purpleBg = null;
    self._blueBg = null;
    self._greenBg = null;
    self._whiteBg = null;
    self._itemIcon = null;
    self._profileImg = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 237;
         this._yellowBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.yellowItemTipsBg");
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._blueBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blueItemTipsBg");
         this._greenBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.greenItemTipsBg");
         this._whiteBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.whiteItemTipsBg");
         this._itemIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsTotalBox");
         this._matureTimeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodGradeText");
         this._outputTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodGradeText");
         this._nameTxt.x = 76;
         this._nameTxt.y = 15;
         this._nameTxt.width = 145;
         this._totalBox.x = 10;
         this._totalBox.spacing = 4;
         this.addChild(this._yellowBg);
         this.addChild(this._purpleBg);
         this.addChild(this._blueBg);
         this.addChild(this._greenBg);
         this.addChild(this._whiteBg);
         this.addChild(this._itemIcon);
         this._itemIcon.x = 9;
         this.addChild(this._profileImg);
         this._profileImg.x = 8;
         this.addChild(this._nameTxt);
         this.addChild(this._totalBox);
         this._totalBox.y = 55;
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc1_ = null;
         if(this.tipData)
         {
            this.clean();
            _loc2_ = $.as(this.tipData, $.C("yishi.datas.templates.CatHouseTemplateInfo"));
            this._itemIcon.icon = $.C("yishi.utils.IconFactory").getCatHouseIconPath(_loc2_.Icon);
            this._profileImg.setFrame(_loc2_.Profile);
            if(_loc2_)
            {
               this._totalBox.addChild(this._matureTimeTxt);
               this._totalBox.addChild(this._outputTxt);
               _loc1_ = "";
               this._nameTxt.text = _loc2_.TemplateName;
               this._nameTxt.setFrame(_loc2_.Profile);
               if($.int(_loc2_.GrowingMinute / 60) <= 0)
               {
                  _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.needMinutes",_loc2_.GrowingMinute % 60);
               }
               else if(_loc2_.GrowingMinute % 60 == 0)
               {
                  _loc1_ = $.int(_loc2_.GrowingMinute / 60) + $.C("manager.LanguageMgr").GetTranslation("public.time.hour");
               }
               else
               {
                  _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.needHM",$.int(_loc2_.GrowingMinute / 60),_loc2_.GrowingMinute % 60);
               }
               this._matureTimeTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SeedTip.matureTime",_loc1_);
               _loc1_ = _loc2_.OutGold + $.C("manager.LanguageMgr").GetTranslation("mainBar.view.ResourceView.gold");
               this._outputTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SeedTip.output",_loc1_);
            }
            this._totalBox.refreshChildPos();
            this._bg.height = this._totalBox.y + this._totalBox.height + 10;
            this._yellowBg.height = this._bg.height;
            this._purpleBg.height = this._bg.height;
            this._blueBg.height = this._bg.height;
            this._greenBg.height = this._bg.height;
            this._whiteBg.height = this._bg.height;
            this._yellowBg.width = this._bg.width;
            this._purpleBg.width = this._bg.width;
            this._blueBg.width = this._bg.width;
            this._greenBg.width = this._bg.width;
            this._whiteBg.width = this._bg.width;
            this._yellowBg.y = this._bg.y - 3;
            this._purpleBg.y = this._bg.y - 3;
            this._blueBg.y = this._bg.y - 3;
            this._greenBg.y = this._bg.y - 3;
            this._whiteBg.y = this._bg.y - 3;
            this.showProfileBg(_loc2_.Profile);
         }
      }
    showProfileBg(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._bg.visible = false;
         this._yellowBg.visible = false;
         this._purpleBg.visible = false;
         this._blueBg.visible = false;
         this._greenBg.visible = false;
         this._whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               this._whiteBg.visible = true;
               break;
            case 1:
               this._greenBg.visible = true;
               break;
            case 2:
               this._blueBg.visible = true;
               break;
            case 3:
               this._purpleBg.visible = true;
               break;
            case 4:
               this._yellowBg.visible = true;
         }
      }
    clean() {
         while(this._totalBox.numChildren > 0)
         {
            this._totalBox.removeChildAt(this._totalBox.numChildren - 1);
         }
      }
    dispose() {
         if(this._yellowBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._yellowBg);
         }
         this._yellowBg = null;
         if(this._purpleBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._purpleBg);
         }
         this._purpleBg = null;
         if(this._blueBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blueBg);
         }
         this._blueBg = null;
         if(this._greenBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._greenBg);
         }
         this._greenBg = null;
         if(this._whiteBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._whiteBg);
         }
         this._whiteBg = null;
         if(this._itemIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemIcon);
         }
         this._itemIcon = null;
         if(this._profileImg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._profileImg);
         }
         this._profileImg = null;
         if(this._totalBox)
         {
            this._totalBox.dispose();
         }
         this._totalBox = null;
         if(this._nameTxt)
         {
            this._nameTxt.dispose();
         }
         this._nameTxt = null;
         if(this._matureTimeTxt)
         {
            this._matureTimeTxt.dispose();
         }
         this._matureTimeTxt = null;
         if(this._outputTxt)
         {
            this._outputTxt.dispose();
         }
         this._outputTxt = null;
         if(this._describe)
         {
            this._describe.dispose();
         }
         this._describe = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__CatToyTips, "yishi.view.tips.CatToyTips", []);
  return __CatToyTips;
}
deps["yishi.view.tips.CatToyTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.templates.CatHouseTemplateInfo", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.ChildGrowthBufferTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ChildGrowthBufferTips extends __Base {
    static $fields(self) {
    self.curText = null;
    self.nextText = null;
    self.curVbox = null;
    self.nextVbox = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.curText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildCallTips.curText");
         this.nextText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildCallTips.nextText");
         this.curVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildCallTips.curVbox");
         this.nextVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildCallTips.nextVbox");
         this.addChild(this.curText);
         this.addChild(this.curVbox);
         this.addChild(this.nextText);
         this.addChild(this.nextVbox);
         this.curText.text = $.C("manager.LanguageMgr").GetTranslation("ChildGrowthBufferTips.titleText.text");
         this.nextText.text = $.C("manager.LanguageMgr").GetTranslation("ChildGrowthBufferTips.nextText.text");
      }
    $$updateTransform() {
         var _loc1_ = 0;
         var _loc7_ = null;
         var _loc4_ = null;
         var _loc10_ = null;
         var _loc5_ = null;
         var _loc8_ = 0;
         var _loc2_ = null;
         var _loc9_ = null;
         var _loc11_ = 0;
         var _loc3_ = null;
         var _loc6_ = null;
         this.curVbox.removeAllChild();
         this.nextVbox.removeAllChild();
         if(this._data)
         {
            this.curText.text = $.C("manager.LanguageMgr").GetTranslation("ChildGrowthBufferTips.titleText.text");
            _loc1_ = ($.as(this._data, "int")) - 1;
            _loc7_ = [];
            _loc4_ = [];
            _loc10_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc1_,120);
            _loc5_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc1_ + 1,120);
            if(_loc5_)
            {
               _loc4_ = _loc5_.TemplateName.split(",");
               if(!_loc10_)
               {
                  this.curText.text = $.C("manager.LanguageMgr").GetTranslation("ChildGrowthBufferTips.titleText.text") + $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
               }
               else
               {
                  _loc7_ = _loc10_.TemplateName.split(",");
                  _loc8_ = 0;
                  while(_loc8_ < _loc7_.length)
                  {
                     _loc2_ = $.C("yishi.manager.TempleteManager").instance.bufferTemplateCate.getTemplateByID($.int(_loc7_[_loc8_]));
                     if(_loc2_)
                     {
                        _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildCallTips.bufferText");
                        _loc9_.text = _loc2_.BufferName;
                        this.curVbox.addChild(_loc9_);
                     }
                     _loc8_++;
                  }
               }
               _loc11_ = 0;
               while(_loc11_ < _loc4_.length)
               {
                  _loc3_ = $.C("yishi.manager.TempleteManager").instance.bufferTemplateCate.getTemplateByID($.int(_loc4_[_loc11_]));
                  if(_loc3_)
                  {
                     _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildCallTips.bufferText");
                     _loc6_.text = _loc3_.BufferName;
                     this.nextVbox.addChild(_loc6_);
                  }
                  _loc11_++;
               }
               this.curVbox.commitChanges();
               this.nextVbox.commitChanges();
               this.curVbox.y = this.curText.y + 20;
               this.nextText.y = this.curVbox.y + this.curVbox.height + 5;
               this.nextVbox.y = this.nextText.y + 20;
               this._bg.height = this.curVbox.height + this.nextVbox.height + 60;
            }
            else
            {
               this.nextText.text = "";
               this._bg.height = this.curVbox.height + 40;
            }
         }
         this._bg.width = Math.max(320,this.curText.x + this.curText.textWidth + 10,this.nextText.x + this.nextText.textWidth + 10,this.nextVbox.x + this.nextVbox.width + 10,this.curVbox.x + this.curVbox.width + 10);
      }
    sortByKeyValue(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc3_ = $.int(param1);
         var _loc4_ = $.int(param2);
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 1;
      }
    get childModel() {
         return $.C("managers.ChildManager").instance.model;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.curText);
         this.curText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nextText);
         this.nextText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nextVbox);
         this.nextVbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.curVbox);
         this.curVbox = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set childModel(v) { super.childModel = v; }
  }
  $.meta(__ChildGrowthBufferTips, "yishi.view.tips.ChildGrowthBufferTips", []);
  return __ChildGrowthBufferTips;
}
deps["yishi.view.tips.ChildGrowthBufferTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.ChildManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.ChildNSTalentItemTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ChildNSTalentItemTips extends __Base {
    static $fields(self) {
    self.nameText = null;
    self.curDescText = null;
    self.curAddValueText = null;
    self.nextVbox = null;
    self.lineImage = null;
    self.nextText = null;
    self.nextDescText = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 480;
         this.nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildNSTalentItemTips.nameText");
         this.curDescText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildNSTalentItemTips.curDescText");
         this.curAddValueText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildNSTalentItemTips.curAddValueText");
         this.nextVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildNSTalentItemTips.nextVbox");
         this.lineImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildNSTalentItemTips.lineImage");
         this.nextText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildNSTalentItemTips.nextText");
         this.nextDescText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildNSTalentItemTips.nextDescText");
         this.addChild(this.nameText);
         this.addChild(this.curDescText);
         this.addChild(this.curAddValueText);
         this.addChild(this.nextVbox);
         this.nextText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.nextGrade");
      }
    $$updateTransform() {
         var _loc5_ = 0;
         var _loc10_ = null;
         var _loc6_ = 0;
         var _loc3_ = null;
         var _loc8_ = null;
         var _loc1_ = null;
         var _loc9_ = 0;
         var _loc7_ = null;
         var _loc2_ = 0;
         var _loc11_ = 0;
         var _loc4_ = 0;
         if(this.tipData)
         {
            this.nextVbox.removeAllChild();
            _loc5_ = $.int(this.tipData.type);
            _loc10_ = $.as(this.tipData.nsInfo, $.C("mvc.module.children.NursingSpiritInfo"));
            if(_loc10_.lvlIndexDic && _loc10_.lvlIndexDic[_loc5_])
            {
               _loc6_ = $.int(_loc10_.lvlIndexDic[_loc5_]);
            }
            else
            {
               _loc6_ = 0;
            }
            _loc9_ = _loc5_ + 1;
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("planesRewardTip.resistance.typeText" + _loc9_);
            _loc2_ = $.int(_loc10_.lifeWheelInfo.resiGradeArr[_loc5_]);
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc2_,133);
            _loc8_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc6_,132);
            _loc1_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc6_ + 1,132);
            _loc11_ = 0;
            if(_loc8_)
            {
               _loc4_ = $.int(_loc8_.ActiveObject);
               _loc11_ = _loc3_.ActiveObject * _loc8_.ActiveObject / 100;
            }
            else
            {
               _loc11_ = _loc4_ = 0;
            }
            this.nameText.htmlText = $.C("manager.LanguageMgr").GetTranslation("ChildNSTalentItemTips.nameText.text",_loc7_,$.C("manager.LanguageMgr").GetTranslation("public.level2",_loc6_));
            this.curDescText.text = $.C("manager.LanguageMgr").GetTranslation("ChildNSTalentItemTips.curDescText.text",_loc7_,_loc4_);
            this.curAddValueText.text = $.C("manager.LanguageMgr").GetTranslation("ChildNSTalentItemTips.curAddValueText.text",_loc11_);
            if(_loc6_ < 80)
            {
               this.nextDescText.text = $.C("manager.LanguageMgr").GetTranslation("ChildNSTalentItemTips.curDescText.text",_loc7_,_loc1_.ActiveObject);
               this.nextVbox.addChild(this.lineImage);
               this.nextVbox.addChild(this.nextText);
               this.nextVbox.addChild(this.nextDescText);
            }
            this._bg.height = this.nextVbox.y + this.nextVbox.height + 20;
         }
      }
    dispose() {
         if(this.nameText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nameText);
         }
         this.nameText = null;
         if(this.curDescText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.curDescText);
         }
         this.curDescText = null;
         if(this.curAddValueText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.curAddValueText);
         }
         this.curAddValueText = null;
         if(this.nextVbox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nextVbox);
         }
         this.nextVbox = null;
         if(this.lineImage)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.lineImage);
         }
         this.lineImage = null;
         if(this.nextText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nextText);
         }
         this.nextText = null;
         if(this.nextDescText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nextDescText);
         }
         this.nextDescText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
  }
  $.meta(__ChildNSTalentItemTips, "yishi.view.tips.ChildNSTalentItemTips", []);
  return __ChildNSTalentItemTips;
}
deps["yishi.view.tips.ChildNSTalentItemTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "mvc.module.children.NursingSpiritInfo", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.ChildNsEmblemResiUpTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ChildNsEmblemResiUpTips extends __Base {
    static $fields(self) {
    self._vBox = null;
    self._line = null;
    self._name = null;
    self._level = null;
    self.listArr = [129,130,131,135];
    self.attNameList0 = ["Attack","Defence","MagicAttack","MagicDefence","ForceHit","Penetrate","Parry","Live","StunAttr"];
    self.attNameList1 = ["FireResi","WaterResi","WindResi","ElectResi","LightResi","DarkResi"];
    self.attNameList2 = ["ReduceResi"];
    self.attNameList3 = ["Live","Attack","Defence","MagicAttack","MagicDefence"];
    }
    constructor() {
         super();
         this._bg.width = 200;
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.childNsEmblemResiUpNameText");
         this._level = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.childNsEmblemResiUpLevelText");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._line.width = this._bg.width - 16;
         this._line.x = 8;
         this._line.y = 30;
         this._vBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._vBox.y = 35;
         this._vBox.x = 15;
         this._vBox.spacing = 1;
         this.addChild(this._name);
         this.addChild(this._level);
         this.addChild(this._line);
         this.addChild(this._vBox);
      }
    $$updateTransform() {
         var _loc10_ = 0;
         var _loc2_ = null;
         var _loc8_ = null;
         var _loc3_ = 0;
         var _loc9_ = null;
         var _loc4_ = null;
         var _loc11_ = null;
         var _loc5_ = 0;
         var _loc1_ = null;
         var _loc6_ = null;
         var _loc7_ = 0;
         if(this.tipData)
         {
            $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this._vBox);
            _loc10_ = $.int(this.tipData) - 1;
            _loc8_ = this["attNameList" + _loc10_];
            _loc3_ = this.getCurGrade(_loc10_);
            _loc9_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc3_,this.listArr[_loc10_]);
            if(!_loc9_)
            {
               return;
            }
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("ChildNsEmblemResiUpFrame.title.text" + _loc10_);
            _loc11_ = "" + _loc3_;
            if(_loc10_ == 0)
            {
               _loc2_ = $.C("yishi.manager.TempleteManager").instance.skillPropertyTemplateCate.getTemplateByID(_loc9_.ActiveObject);
            }
            _loc5_ = $.int(_loc8_.length);
            _loc6_ = "";
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.childNsEmblemResiUpText");
               if(_loc10_ == 0)
               {
                  _loc6_ = "" + _loc2_[_loc8_[_loc7_]];
               }
               else if(_loc10_ == 3)
               {
                  _loc6_ = "" + _loc9_.TemplateName.split(",")[_loc7_];
               }
               else
               {
                  _loc6_ = "" + _loc9_.ActiveObject;
               }
               _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("ChildNsEmblemResiUpFrame.title.text" + _loc10_ + "" + _loc7_,_loc6_);
               this._vBox.addChild(_loc1_);
               _loc7_ += 1;
            }
            this._name.text = _loc4_;
            this._level.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc11_);
            this._level.x = this._name.x + this._name.textWidth + 8;
            this._vBox.refreshChildPos();
            this._bg.width = this._level.x + this._level.textWidth + 20;
            this._line.width = this._bg.width - 16;
            this._bg.height = 38 + this._vBox.height;
         }
      }
    getCurGrade(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(param1 == 0)
         {
            return this.nsModel.selectedNsChild.emblemLv;
         }
         if(param1 == 1)
         {
            return this.nsModel.selectedNsChild.nursingSpiritInfo.resiGrade;
         }
         if(param1 == 2)
         {
            return this.nsModel.selectedNsChild.nursingSpiritInfo.reduceResiGrade;
         }
         if(param1 == 3)
         {
            return this.nsModel.selectedNsChild.nursingSpiritInfo.awakeGrade;
         }
         return 0;
      }
    get nsModel() {
         return $.C("managers.ChildManager").instance.nsModel;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this._name)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         }
         this._name = null;
         if(this._level)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._level);
         }
         this._level = null;
         if(this._line)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         }
         this._line = null;
         if(this._vBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         }
         this._vBox = null;
         this.listArr = [];
         this.attNameList0 = [];
         this.attNameList1 = [];
         this.attNameList2 = [];
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set nsModel(v) { super.nsModel = v; }
  }
  $.meta(__ChildNsEmblemResiUpTips, "yishi.view.tips.ChildNsEmblemResiUpTips", []);
  return __ChildNsEmblemResiUpTips;
}
deps["yishi.view.tips.ChildNsEmblemResiUpTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.ChildManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.ChildPatrolItemTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ChildPatrolItemTip extends __Base {
    static $fields(self) {
    self.headIcon = null;
    self.parentText = null;
    self.gradeText = null;
    self.nameText = null;
    self.splitLine = null;
    self.attVbox = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.headIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this.parentText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this.gradeText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodTypeText_2");
         this.nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodVocationText");
         this.splitLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this.attVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ChildPatrolItemTip.Attvbox");
         this.addChild(this.headIcon);
         this.addChild(this.parentText);
         this.addChild(this.gradeText);
         this.addChild(this.nameText);
         this.addChild(this.splitLine);
         this.addChild(this.attVbox);
         this.headIcon.x = 15;
         this.headIcon.y = -9;
         this.parentText.x = 81;
         this.parentText.y = 20;
         this.parentText.width = 150;
         this.gradeText.x = 6;
         this.gradeText.y = 60;
         this.nameText.x = 7;
         this.nameText.y = 60;
         this.nameText.width = 250;
         this.splitLine.y = 85;
         this.splitLine.scaleX = 0.95;
         this._bg.height = 300;
      }
    $$updateTransform() {
         var _loc5_ = null;
         var _loc4_ = null;
         var _loc2_ = 0;
         var _loc1_ = null;
         var _loc3_ = null;
         this.cleanData();
         if($.is(this.tipData, $.C("mvc.module.children.ChildData")))
         {
            _loc5_ = this.getAttData();
            this.headIcon.visible = true;
            this.splitLine.visible = true;
            this.headIcon.icon = $.C("yishi.utils.IconFactory").getChildrenHeadSmallIcon(this._data.job,this._data.growthGrade);
            this.parentText.text = this._data.name;
            this.gradeText.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",this._data.growthGrade);
            _loc4_ = $.C("yishi.manager.TempleteManager").instance.childTemplateCate.getTemplateByJobAndGrades(this._data.job,this._data.growthGrade);
            this.nameText.text = _loc4_.JobName;
            _loc2_ = 0;
            while(_loc2_ < 11)
            {
               _loc1_ = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
               _loc3_ = _loc5_[_loc2_];
               if(_loc2_ == 2)
               {
                  _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName0" + _loc3_);
               }
               _loc1_.setData($.C("manager.LanguageMgr").GetTranslation("ChildPatrolItemTip.FashionAttItem.text" + _loc2_,_loc3_));
               this.attVbox.addChild(_loc1_);
               _loc2_++;
            }
            this._bg.height = this.attVbox.y + this.attVbox.height + 5;
         }
      }
    cleanData() {
         this.attVbox.removeAllChild();
         this.headIcon.visible = false;
         this.splitLine.visible = false;
         this.parentText.text = "";
         this.gradeText.text = "";
         this.nameText.text = "";
      }
    getAttData() {
         var _loc1_ = 0;
         var _loc2_ = [];
         if($.is(this.tipData, $.C("mvc.module.children.ChildData")))
         {
            _loc2_[0] = this._data.growthGrade;
            _loc2_[1] = this._data.emblemLv;
            _loc2_[2] = $.C("mvc.module.childpatrol.ChildPatrolCheckCondictionHelper").getChildEquipQualityData($.as(this._data, $.C("mvc.module.children.ChildData")));
            _loc2_[3] = $.C("mvc.module.childpatrol.ChildPatrolCheckCondictionHelper").getChildSkillGradesData($.as(this._data, $.C("mvc.module.children.ChildData")));
            _loc1_ = 0;
            while(_loc1_ < 7)
            {
               _loc2_[_loc1_ + 4] = ($.as(this._data, $.C("mvc.module.children.ChildData"))).ResiValueArr[_loc1_];
               _loc1_++;
            }
         }
         return _loc2_;
      }
    dispose() {
         if(this.headIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.headIcon);
         }
         this.headIcon = null;
         if(this.parentText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.parentText);
         }
         this.parentText = null;
         if(this.gradeText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.gradeText);
         }
         this.gradeText = null;
         if(this.nameText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nameText);
         }
         this.nameText = null;
         if(this.splitLine)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.splitLine);
         }
         this.splitLine = null;
         if(this.attVbox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.attVbox);
         }
         this.attVbox = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ChildPatrolItemTip, "yishi.view.tips.ChildPatrolItemTip", []);
  return __ChildPatrolItemTip;
}
deps["yishi.view.tips.ChildPatrolItemTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "mvc.module.childpatrol.ChildPatrolCheckCondictionHelper", "mvc.module.children.ChildData", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.FashionAttItem"];

defs["yishi.view.tips.ChildPveRewardTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ChildPveRewardTip extends __Base {
    static $fields(self) {
    self._vBox = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassVBox");
         this.addChild(this._vBox);
      }
    $$updateTransform() {
         var _loc3_ = null;
         var _loc6_ = null;
         var _loc1_ = null;
         var _loc2_ = 0;
         var _loc4_ = 0;
         var _loc5_ = 0;
         if(this.tipData)
         {
            this._vBox.removeAllChild();
            _loc3_ = ($.as(this.tipData, "String")).split("|");
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassTitleTxt1");
            _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("childpve.dropTipsTxt");
            this._vBox.addChild(_loc1_);
            while(_loc5_ < _loc3_.length)
            {
               _loc2_ = $.int(String(_loc3_[_loc5_]).split(",")[0]);
               _loc4_ = $.int(String(_loc3_[_loc5_]).split(",")[1]);
               _loc6_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc2_);
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               _loc1_.setFrame(_loc6_.Profile);
               _loc1_.text = _loc6_.TemplateName + "*" + _loc4_;
               this._vBox.addChild(_loc1_);
               _loc5_++;
            }
            this._vBox.refreshChildPos();
            this._bg.width = this._vBox.displayWidth + 20;
            this._bg.height = this._vBox.displayHeight + 20;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         this._vBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
  }
  $.meta(__ChildPveRewardTip, "yishi.view.tips.ChildPveRewardTip", []);
  return __ChildPveRewardTip;
}
deps["yishi.view.tips.ChildPveRewardTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.ChildrenFigureTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ChildrenFigureTip extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._subBox1 = null;
    self._subBox2 = null;
    self._splitLine = null;
    self._splitLine2 = null;
    self._splitLine3 = null;
    self._txtList = null;
    self._goodsList = null;
    self._con = null;
    self._equipIcon = null;
    self._profileImg = null;
    self._title = null;
    self._type = null;
    self._vocation = null;
    self._powerTxt = null;
    self.dreamArenaChildData = null;
    self._attNameList = ["Emblem1","Emblem2","Emblem3","Emblem4","Emblem5","Emblem6","Emblem7","Emblem8","Emblem9","Attack","Defence","MagicAttack","MagicDefence","ForceHit","Penetrate","Parry","Live","StunAttr"];
    self._attStrList = ["tips.ChildrenFigureTip.typeText01","tips.ChildrenFigureTip.typeText02","tips.ChildrenFigureTip.typeText03","tips.ChildrenFigureTip.typeText04","tips.ChildrenFigureTip.typeText05","tips.ChildrenFigureTip.typeText06","tips.ChildrenFigureTip.typeText07","tips.ChildrenFigureTip.typeText17","tips.ChildrenFigureTip.typeText18","tips.ChildrenFigureTip.typeText08","tips.ChildrenFigureTip.typeText09","tips.ChildrenFigureTip.typeText10","tips.ChildrenFigureTip.typeText11","tips.ChildrenFigureTip.typeText12","tips.ChildrenFigureTip.typeText13","tips.ChildrenFigureTip.typeText14","tips.ChildrenFigureTip.typeText15","tips.ChildrenFigureTip.typeText16"];
    }
    constructor() {
         super();
      }
    init() {
         var _loc1_ = null;
         var _loc2_ = 0;
         super.init();
         this._bg.width = 266;
         this._con = new ($.C("flash.display.Sprite"))();
         this._equipIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this._type = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodTypeText_2");
         this._vocation = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodVocationText");
         this._powerTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.pet.PowerTxt");
         this._splitLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._splitLine.x = -7;
         this._splitLine.scaleX = 0.95;
         this._splitLine2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._splitLine2.x = -7;
         this._splitLine2.scaleX = 0.95;
         this._splitLine3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._splitLine3.x = -7;
         this._splitLine3.scaleX = 0.95;
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsTotalBox");
         this._subBox1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsSubBox");
         this._subBox2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsSubBox");
         this._txtList = new $.Vector();
         this._goodsList = new $.Vector();
         this.addChild(this._con);
         this.addChild(this._totalBox);
         _loc2_ = 0;
         while(_loc2_ < this._attNameList.length)
         {
            _loc1_ = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
            if(_loc2_ < 9)
            {
               this._subBox1.addChild(_loc1_);
            }
            else
            {
               this._subBox2.addChild(_loc1_);
            }
            this._txtList.push(_loc1_);
            _loc2_++;
         }
         this._profileImg.setFrame(1);
         this._con.addChild(this._equipIcon);
         this._equipIcon.x = 15;
         this._equipIcon.y = -9;
         this._con.addChild(this._title);
         this._title.x = 71;
         this._title.y = 20;
         this._title.width = 150;
         this._con.addChild(this._profileImg);
         this._profileImg.x = 15;
         this._profileImg.y = 10;
         this._con.addChild(this._type);
         this._type.x = 6;
         this._type.y = 60;
         this._con.addChild(this._vocation);
         this._vocation.x = 0;
         this._vocation.y = 60;
         this._totalBox.x = 10;
         this._totalBox.y = 90;
         this.dreamArenaChildData = new ($.C("mvc.module.children.ChildData"))();
      }
    $$updateTransform() {
         var _loc1_ = null;
         this.clean();
         if($.is(this.tipData, $.C("mvc.module.children.ChildData")))
         {
            this._equipIcon.icon = $.C("yishi.utils.IconFactory").getChildrenHeadSmallIcon(this._data.job,this._data.growthGrade);
            this._title.text = this._data.name;
            this._type.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",this._data.growthGrade);
            _loc1_ = $.C("yishi.manager.TempleteManager").instance.childTemplateCate.getTemplateByJobAndGrades(this._data.job,this._data.growthGrade);
            this._vocation.text = _loc1_.JobName;
            this._powerTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.ap") + String(this._data.fightValue);
            this.refreshView($.as(this._data, $.C("mvc.module.children.ChildData")));
            this._subBox1.refreshChildPos();
            this._subBox2.refreshChildPos();
            this._totalBox.addChild(this._splitLine);
            this._totalBox.addChild(this._subBox1);
            this._totalBox.addChild(this._splitLine2);
            this._totalBox.addChild(this._subBox2);
            this._totalBox.addChild(this._splitLine3);
            this._totalBox.addChild(this._powerTxt);
            this._bg.height = $.int(this._totalBox.y + this._totalBox.height + 10);
         }
         else if(this.tipData && $.is(this.tipData, $.C("yishi.datas.templates.DreamArenaTempInfo")))
         {
            this.setTipsData($.as(this.tipData, $.C("yishi.datas.templates.DreamArenaTempInfo")),this.dreamArenaChildData);
            this._equipIcon.icon = $.C("yishi.utils.IconFactory").getChildrenHeadSmallIcon(this.dreamArenaChildData.job,this.dreamArenaChildData.growthGrade);
            this._type.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",this.dreamArenaChildData.growthGrade);
            _loc1_ = $.C("yishi.manager.TempleteManager").instance.childTemplateCate.getTemplateByJobAndGrades(this.dreamArenaChildData.job,this.dreamArenaChildData.growthGrade);
            this._title.text = _loc1_.JobName;
            this._vocation.text = _loc1_.JobName;
            this.refreshView(this.dreamArenaChildData);
            this._subBox1.refreshChildPos();
            this._subBox2.refreshChildPos();
            this._totalBox.addChild(this._splitLine);
            this._totalBox.addChild(this._subBox1);
            this._totalBox.addChild(this._splitLine2);
            this._totalBox.addChild(this._subBox2);
            this._bg.height = $.int(this._totalBox.y + this._totalBox.height + 10);
         }
      }
    setTipsData(param1, param2) {
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.skillPropertyTemplateCate.getTemplateByID(param1.PropertyId);
         if(!_loc3_)
         {
            return;
         }
         this.dreamArenaChildData.job = ($.as(param1.typeTempInfo, $.C("yishi.datas.templates.ChildTempInfo"))).JobType;
         this.dreamArenaChildData.growthGrade = ($.as(param1.typeTempInfo, $.C("yishi.datas.templates.ChildTempInfo"))).Grades;
         param2.childAttInfo.reduceResi = _loc3_.ReduceResi;
         param2.childAttInfo.fireResi = _loc3_.FireResi;
         param2.childAttInfo.waterResi = _loc3_.WaterResi;
         param2.childAttInfo.electResi = _loc3_.ElectResi;
         param2.childAttInfo.windResi = _loc3_.WindResi;
         param2.childAttInfo.darkResi = _loc3_.DarkResi;
         param2.childAttInfo.lightResi = _loc3_.LightResi;
         param2.childAttInfo.strikeResi = _loc3_.ResiPenetrate;
         param2.childAttInfo.resResistResi = _loc3_.ReduceResiAgainst;
         param2.childAttInfo.attack = _loc3_.Attack;
         param2.childAttInfo.defence = _loc3_.Defence;
         param2.childAttInfo.magicAttack = _loc3_.MagicAttack;
         param2.childAttInfo.magicDefence = _loc3_.MagicDefence;
         param2.childAttInfo.forceHit = _loc3_.ForceHit;
         param2.childAttInfo.penetrate = _loc3_.Penetrate;
         param2.childAttInfo.parry = _loc3_.Parry;
         param2.childAttInfo.hp = _loc3_.Live;
         param2.childAttInfo.stunAttr = _loc3_.StunAttr;
      }
    refreshView(param1) {
         var _loc2_ = 0;
         _loc2_ = 0;
         while(_loc2_ < this._attNameList.length)
         {
            if(_loc2_ < 9)
            {
               this._txtList[_loc2_].setData($.C("manager.LanguageMgr").GetTranslation(this._attStrList[_loc2_]) + " " + param1.childAttInfo.resiArr[_loc2_]);
            }
            else
            {
               this._txtList[_loc2_].setData($.C("manager.LanguageMgr").GetTranslation(this._attStrList[_loc2_]) + " " + param1.childAttInfo.attValueArr[_loc2_ - 9]);
            }
            _loc2_++;
         }
      }
    clean() {
      }
    get model() {
         return $.C("managers.ChildManager").instance.model;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    set model(v) { super.model = v; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__ChildrenFigureTip, "yishi.view.tips.ChildrenFigureTip", []);
  return __ChildrenFigureTip;
}
deps["yishi.view.tips.ChildrenFigureTip"] = ["com.pickgliss.ui.ComponentFactory", "flash.display.Sprite", "manager.LanguageMgr", "managers.ChildManager", "mvc.module.children.ChildData", "yishi.datas.templates.ChildTempInfo", "yishi.datas.templates.DreamArenaTempInfo", "yishi.manager.ArmyManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.FashionAttItem"];

defs["yishi.view.tips.ConsortiaSkillTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ConsortiaSkillTip extends __Base {
    static $fields(self) {
    self._titleTxtStyle = null;
    self._itemTxtStyle = null;
    self._explainTxtStyle = null;
    self._maxWidth = 0;
    self._titleTxt = null;
    self._itemArr = [];
    self._explainArr = [];
    self._container = null;
    }
    constructor() {
         super();
         this.isFollowMouse = false;
         this._container = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._container.spacing = 3;
      }
    $$updateTransform() {
         var _loc3_ = NaN;
         var _loc1_ = null;
         var _loc7_ = null;
         var _loc5_ = 0;
         var _loc4_ = null;
         var _loc6_ = null;
         var _loc2_ = null;
         if($.is(this._data, $.C("yishi.view.tips.ConsortiaSkillTipInfo")))
         {
            this.removeAllItem();
            _loc3_ = 0;
            _loc1_ = ($.as(this._data, $.C("yishi.view.tips.ConsortiaSkillTipInfo"))).data;
            if(_loc1_["title"])
            {
               this._titleTxt = this.getTextItem(_loc1_["title"],this._titleTxtStyle);
               this._maxWidth = this._titleTxt.textWidth > this._maxWidth ? this._titleTxt.textWidth : this._maxWidth;
               this._container.x = this._titleTxt.x;
               this._container.y = this._titleTxt.y + this._titleTxt.height + 5;
            }
            _loc7_ = _loc1_["itemArr"];
            _loc5_ = 0;
            while(_loc5_ < _loc7_.length)
            {
               _loc4_ = this.getTextItem(_loc7_[_loc5_],this._itemTxtStyle);
               this._maxWidth = _loc4_.textWidth > this._maxWidth ? _loc4_.textWidth : this._maxWidth;
               this._itemArr.push(_loc4_);
               this._container.addChild(_loc4_);
               _loc5_++;
            }
            _loc6_ = _loc1_["explainArr"];
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               _loc2_ = this.getTextItem(_loc6_[_loc5_],this._explainTxtStyle);
               this._maxWidth = _loc2_.textWidth > this._maxWidth ? _loc2_.textWidth : this._maxWidth;
               this._explainArr.push(_loc2_);
               this._container.addChild(_loc2_);
               _loc5_++;
            }
            this.addChild(this._container);
            this._bg.width = this._maxWidth + 26;
            this._bg.height = this._container.y + this._container.height + 10;
         }
      }
    removeAllItem() {
         if(this._titleTxt)
         {
            this._titleTxt.parent.removeChild(this._titleTxt);
            this._titleTxt = null;
         }
         for (var _loc2_ of $.values(this._itemArr))
         {
            this._container.removeChild(_loc2_);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc2_);
         }
         this._itemArr.length = 0;
         for (var _loc1_ of $.values(this._explainArr))
         {
            this._container.removeChild(_loc1_);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         this._explainArr.length = 0;
      }
    getTextItem(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if(param1 == null)
         {
            return null;
         }
         var _loc3_ = this.createTxt(param2);
         _loc3_.text = param1;
         this.addChild(_loc3_);
         return _loc3_;
      }
    createTxt(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(param1);
      }
    get titleTxtStyle() {
         return this._titleTxtStyle;
      }
    set titleTxtStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._titleTxtStyle = param1;
      }
    get itemTxtStyle() {
         return this._itemTxtStyle;
      }
    set itemTxtStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._itemTxtStyle = param1;
      }
    get explainTxtStyle() {
         return this._explainTxtStyle;
      }
    set explainTxtStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._explainTxtStyle = param1;
      }
    dispose() {
         if(this._titleTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleTxt);
         }
         this._titleTxt = null;
         if(this._container)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._container);
         }
         this._container = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ConsortiaSkillTip, "yishi.view.tips.ConsortiaSkillTip", []);
  return __ConsortiaSkillTip;
}
deps["yishi.view.tips.ConsortiaSkillTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "yishi.view.tips.BaseTip", "yishi.view.tips.ConsortiaSkillTipInfo"];

defs["yishi.view.tips.ConsrortiaBossRewardTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ConsrortiaBossRewardTips extends __Base {
    static $fields(self) {
    self._txt = null;
    }
    constructor() {
         super();
         this._txt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.commonTipText");
         this._txt.x = 15;
         this._txt.y = 7;
         this.addChild(this._txt);
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc2_ = null;
         if(this.tipData)
         {
            _loc1_ = $.as(this.tipData, "String");
            _loc2_ = /\(/g;
            _loc1_ = _loc1_.replace(_loc2_,"<font color=\'#ffff00\'>");
            _loc2_ = /\[/g;
            _loc1_ = _loc1_.replace(_loc2_,"<font color=\'#00ff00\'>");
            _loc2_ = /\]/g;
            _loc1_ = _loc1_.replace(_loc2_,"</font>");
            _loc2_ = /\)/g;
            _loc1_ = _loc1_.replace(_loc2_,"</font>");
            this._txt.htmlText = _loc1_;
            this._bg.width = this._txt.textWidth + 30;
            this._bg.height = this._txt.textHeight + 20;
         }
      }
  }
  $.meta(__ConsrortiaBossRewardTips, "yishi.view.tips.ConsrortiaBossRewardTips", []);
  return __ConsrortiaBossRewardTips;
}
deps["yishi.view.tips.ConsrortiaBossRewardTips"] = ["com.pickgliss.ui.ComponentFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.ContinuePayRebateChestIconTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ContinuePayRebateChestIconTip extends __Base {
    static $fields(self) {
    self._hbox = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._hbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("xmlui.advanceReward.hbox");
         this.addChild(this._hbox);
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc3_ = null;
         var _loc6_ = null;
         var _loc4_ = null;
         var _loc5_ = $.as(this._data, $.C("funny.datas.FunnyBagData"));
         if(_loc5_ != null)
         {
            this._hbox.beginChanges();
            this._hbox.disposeAllChildren();
            for (var _loc2_ of $.values(this._data.rewardList))
            {
               if(_loc2_.temType == 1)
               {
                  _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("ContinuePayRebateChestIconTip.BaseItemView");
                  _loc3_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
                  _loc3_.templateId = _loc2_.temId;
                  _loc3_.count = _loc2_.count;
                  _loc3_.isBinds = _loc2_.isBind;
                  _loc3_.isHideBinds = true;
                  _loc3_.strengthenGrade = _loc2_.strengthenGrade;
                  _loc1_.data = _loc3_;
                  this._hbox.addChild(_loc1_);
               }
               else if(_loc2_.temType == 2)
               {
                  _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("continuePayRebate.rewardItem.StarBagCell");
                  _loc4_ = new ($.C("mvc.module.star.StarInfo"))();
                  _loc4_.template = $.C("yishi.manager.TempleteManager").instance.starTempalteCate.getTemplateByID(_loc2_.temId);
                  _loc4_.count = _loc2_.count;
                  _loc4_.grade = _loc2_.strengthenGrade;
                  _loc6_.data = _loc4_;
                  _loc6_.acceptDrop = false;
                  _loc6_.lock = false;
                  this._hbox.addChild(_loc6_);
               }
               this._hbox.commitChanges();
               this._bg.width = this._hbox.width + 29;
               this._bg.height = 75;
            }
         }
      }
    dispose() {
         if(this._hbox)
         {
            this._hbox.disposeAllChildren();
            this._hbox.dispose();
            this._hbox = null;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ContinuePayRebateChestIconTip, "yishi.view.tips.ContinuePayRebateChestIconTip", []);
  return __ContinuePayRebateChestIconTip;
}
deps["yishi.view.tips.ContinuePayRebateChestIconTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "funny.datas.FunnyBagData", "mvc.module.star.StarInfo", "yishi.datas.goods.GoodsInfo", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.CropTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __CropTip extends __Base {
    static $fields(self) {
    self._totalVBox = null;
    self._hBox1 = null;
    self._nameTxt = null;
    self._timeTxt = null;
    self._timeValTxt = null;
    self._accelerateTxt = null;
    self._matureProgress = null;
    self._matureProgressBg = null;
    self._matureProgressImg = null;
    self._matureProgressMask = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         if(this._bg.parent)
         {
            this._bg.parent.removeChild(this._bg);
         }
         this._totalVBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.CropTipTotalVBox");
         this._hBox1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.CropTipHBox");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.CropTipNameTxt");
         this._timeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.CropTipTimeTxt");
         this._timeValTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.CropTipTimeTxt");
         this._accelerateTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.CropTipAccelerateTxt");
         this._matureProgressBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.MatureProgressBg");
         this._matureProgressImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.MatureProgressImg");
         this._matureProgressMask = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.MatureProgressMask");
         this._matureProgress = new ($.C("flash.display.Sprite"))();
         this._timeTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.CropTip.remainTime");
         this._matureProgressMask.graphics.beginFill(16777215,1);
         this._matureProgressMask.graphics.drawRect(0,0,133,10);
         this._matureProgressMask.graphics.endFill();
         this._matureProgressImg.mask = this._matureProgressMask;
         this._matureProgress.addChild(this._matureProgressBg);
         this._matureProgress.addChild(this._matureProgressImg);
         this._matureProgress.addChild(this._matureProgressMask);
         this._hBox1.addChild(this._timeTxt);
         this._hBox1.addChild(this._timeValTxt);
         this._totalVBox.addChild(this._nameTxt);
         this.addChild(this._totalVBox);
      }
    $$updateTransform() {
         if($.is(this.tipData, $.C("farm.data.FarmLandInfo")))
         {
            this.showFarmLandTip();
         }
         else if($.is(this.tipData, $.C("farm.data.PetLandInfo")))
         {
            this.showFarmPetTip();
         }
      }
    showFarmLandTip() {
         var _loc2_ = 0;
         var _loc4_ = NaN;
         var _loc1_ = $.as(this.tipData, $.C("farm.data.FarmLandInfo"));
         var _loc3_ = $.int(_loc1_.cropPhase);
         if(_loc1_.cropTemp)
         {
            this._nameTxt.text = _loc1_.cropTemp.TemplateName;
            this._nameTxt.setFrame(_loc1_.cropTemp.Profile);
         }
         else
         {
            this._nameTxt.text = "";
         }
         if(_loc1_.pos >= 1000 && _loc1_.remainMatureMinutes <= 0)
         {
            this._nameTxt.text = "";
            return;
         }
         if(_loc3_ == 3 || _loc3_ == 4)
         {
            if(_loc1_.pos < 1000)
            {
               this._nameTxt.appendText("  " + _loc1_.cropPhaseString);
            }
            else
            {
               this._nameTxt.text = "";
            }
            if(this._hBox1.parent)
            {
               this._hBox1.parent.removeChild(this._hBox1);
            }
            if(this._matureProgress.parent)
            {
               this._matureProgress.parent.removeChild(this._matureProgress);
            }
         }
         else
         {
            _loc2_ = $.int(_loc1_.remainMatureMinutes);
            if(_loc2_ == 0)
            {
               $.C("farm.FarmManager").instance.sendFarmOper(0,0,0);
            }
            _loc4_ = _loc1_.growMinutes / _loc1_.totalMatureMinutes;
            if($.cast($.C("farm.data.FarmLandInfo"), this._data).pos >= 1000)
            {
               _loc4_ = _loc1_.animalGrowMinutes / _loc1_.animalTotalMatureMinutes;
            }
            if(_loc4_ > 1)
            {
               _loc4_ = 1;
            }
            if($.int(_loc2_ / 60) <= 0)
            {
               this._timeValTxt.text = $.C("manager.LanguageMgr").GetTranslation("public.needMinutes",_loc2_ % 60);
            }
            else
            {
               this._timeValTxt.text = $.C("manager.LanguageMgr").GetTranslation("public.needHM",$.int(_loc2_ / 60),_loc2_ % 60);
            }
            this._matureProgressMask.width = this._matureProgressImg.width * _loc4_;
            if(_loc1_.hasAccelerate)
            {
               if(this._accelerateTxt.parent)
               {
                  this._accelerateTxt.parent.removeChild(this._accelerateTxt);
               }
            }
            else
            {
               this._accelerateTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.CropTip.unaccelerated");
               this._matureProgress.addChild(this._accelerateTxt);
            }
            this._totalVBox.addChild(this._hBox1);
            this._totalVBox.addChild(this._matureProgress);
         }
         this._totalVBox.refreshChildPos();
      }
    showFarmPetTip() {
         var _loc2_ = 0;
         var _loc3_ = NaN;
         var _loc1_ = $.as(this.tipData, $.C("farm.data.PetLandInfo"));
         this._nameTxt.text = _loc1_.name;
         this._nameTxt.setFrame(6 + _loc1_.quality);
         if(this._accelerateTxt.parent)
         {
            this._accelerateTxt.parent.removeChild(this._accelerateTxt);
         }
         if(_loc1_.canGains())
         {
            this._nameTxt.appendText("    ");
            if(this._hBox1.parent)
            {
               this._hBox1.parent.removeChild(this._hBox1);
            }
            if(this._matureProgress.parent)
            {
               this._matureProgress.parent.removeChild(this._matureProgress);
            }
         }
         else
         {
            _loc2_ = $.int(_loc1_.remainMatureMinutes);
            _loc3_ = _loc1_.growMinutes / _loc1_.totalMatureMinutes;
            if(_loc3_ > 1)
            {
               _loc3_ = 1;
            }
            if($.int(_loc2_ / 60) <= 0)
            {
               this._timeValTxt.text = $.C("manager.LanguageMgr").GetTranslation("public.needMinutes",_loc2_ % 60);
            }
            else
            {
               this._timeValTxt.text = $.C("manager.LanguageMgr").GetTranslation("public.needHM",$.int(_loc2_ / 60),_loc2_ % 60);
            }
            this._matureProgressMask.width = this._matureProgressImg.width * _loc3_;
            this._totalVBox.addChild(this._hBox1);
            this._totalVBox.addChild(this._matureProgress);
         }
         this._totalVBox.refreshChildPos();
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._matureProgress);
         if(this._totalVBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._totalVBox);
         }
         this._totalVBox = null;
         if(this._hBox1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hBox1);
         }
         this._hBox1 = null;
         if(this._nameTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameTxt);
         }
         this._nameTxt = null;
         if(this._timeTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeTxt);
         }
         this._timeTxt = null;
         if(this._timeValTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeValTxt);
         }
         this._timeValTxt = null;
         if(this._accelerateTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._accelerateTxt);
         }
         this._accelerateTxt = null;
         if(this._matureProgress)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._matureProgress);
         }
         this._matureProgress = null;
         if(this._matureProgressBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._matureProgressBg);
         }
         this._matureProgressBg = null;
         if(this._matureProgressImg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._matureProgressImg);
         }
         this._matureProgressImg = null;
         if(this._matureProgressMask)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._matureProgressMask);
         }
         this._matureProgressMask = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__CropTip, "yishi.view.tips.CropTip", []);
  return __CropTip;
}
deps["yishi.view.tips.CropTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "farm.FarmManager", "farm.data.FarmLandInfo", "farm.data.PetLandInfo", "flash.display.Sprite", "manager.LanguageMgr", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.DaimonSkillTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __DaimonSkillTip extends __Base {
    static $fields(self) {
    self._nameSprite = null;
    self._totalBox = null;
    self._injuryTxt = null;
    self._nameTxt = null;
    self._castTime = null;
    self._coolDown = null;
    self._descTxt = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.totalVBox");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.NameTxt1");
         this._injuryTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.NameTxt2");
         this._castTime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._coolDown = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._descTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.DescTxt");
         this._nameSprite = new ($.C("flash.display.Sprite"))();
         this._bg.width = 200;
         this.addChild(this._totalBox);
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc1_ = null;
         this._totalBox.removeAllChild();
         super.$$updateTransform();
         if(this.tipData)
         {
            if($.is(this.tipData, $.C("yishi.datas.templates.VehicleSkillTempInfo")))
            {
               _loc2_ = $.as(this.tipData, $.C("yishi.datas.templates.VehicleSkillTempInfo"));
               this._nameTxt.text = _loc2_.TemplateName;
               this._injuryTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.DaimonSkillTip.injuryTxt" + _loc2_.InjuryEffect);
               this._castTime.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.castTime",_loc2_.CastTime / 1000);
               this._coolDown.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc2_.CoolDown / 1000);
               this._descTxt.htmlText = _loc2_.Description;
               this._nameSprite.addChild(this._nameTxt);
               this._nameSprite.addChild(this._injuryTxt);
               this._totalBox.addChild(this._nameSprite);
               if(_loc2_.InjuryEffect == 3)
               {
                  this._totalBox.addChild(this._descTxt);
               }
               else
               {
                  this._totalBox.addChild(this._castTime);
                  this._totalBox.addChild(this._coolDown);
                  this._totalBox.addChild(this._descTxt);
               }
            }
            else if($.is(this.tipData, $.C("yishi.datas.templates.VehicleSkillBuffTemplate")))
            {
               _loc1_ = $.as(this.tipData, $.C("yishi.datas.templates.VehicleSkillBuffTemplate"));
               this._nameTxt.text = _loc1_.Name;
               this._descTxt.htmlText = _loc1_.Description;
               this._castTime.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.lastTime",$.int(_loc1_.Duration / 1000));
               this._coolDown.text = $.C("manager.LanguageMgr").GetTranslation("emailII.view.EmailItemView.leftTime",_loc1_.leftTime) + $.C("manager.LanguageMgr").GetTranslation("public.time.second");
               this._totalBox.addChild(this._nameTxt);
               this._totalBox.addChild(this._castTime);
               this._totalBox.addChild(this._coolDown);
               this._totalBox.addChild(this._descTxt);
            }
            else
            {
               this._nameTxt.text = $.C("manager.LanguageMgr").GetTranslation("vehicle.vehicleTech");
               this._descTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("vehicle.vehicleTechDesc");
               this._totalBox.addChild(this._nameTxt);
               this._totalBox.addChild(this._descTxt);
            }
            this._totalBox.refreshChildPos();
            this._bg.height = this._descTxt.y + this._descTxt.textHeight + 20;
            this._bg.width = this._totalBox.displayWidth + 10;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._nameTxt = null;
         this._descTxt = null;
         this._injuryTxt = null;
         this._nameSprite = null;
         this._castTime = null;
         this._coolDown = null;
         super.dispose();
      }
  }
  $.meta(__DaimonSkillTip, "yishi.view.tips.DaimonSkillTip", []);
  return __DaimonSkillTip;
}
deps["yishi.view.tips.DaimonSkillTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.datas.templates.VehicleSkillBuffTemplate", "yishi.datas.templates.VehicleSkillTempInfo", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.DragonTalkerAttTipsItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DragonTalkerAttTipsItem extends __Base {
    static $fields(self) {
    self.flagImg = null;
    self.propTxt = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.flagImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.attributeFlag");
         this.propTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerAttTipsItem.propTxt");
         this.addChild(this.flagImg);
         this.addChild(this.propTxt);
         this.propTxt.x = 14;
      }
    setData(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(param1 == "")
         {
            this.flagImg.visible = false;
            return;
         }
         this.flagImg.visible = true;
         this.propTxt.htmlText = param1;
      }
    setDescWidth(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this.propTxt.width = param1;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.flagImg);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.propTxt);
         super.dispose();
      }
  }
  $.meta(__DragonTalkerAttTipsItem, "yishi.view.tips.DragonTalkerAttTipsItem", []);
  return __DragonTalkerAttTipsItem;
}
deps["yishi.view.tips.DragonTalkerAttTipsItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils"];

defs["yishi.view.tips.DragonTalkerHeroEquipTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __DragonTalkerHeroEquipTips extends __Base {
    static $fields(self) {
    self.back = null;
    self.equipIcon = null;
    self.nameText = null;
    self.descText = null;
    self.castContnier = null;
    self.mountContiner = null;
    self.refreshContiner = null;
    self.refreshTitle = null;
    self.info = null;
    self.tempInfo = null;
    self.index = 0;
    self.symbioteInfo = null;
    }
    constructor() {
         super();
      }
    init() {
         this.back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerHeroEquipTips.back");
         this.equipIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this.nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this.descText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.castSelectedTxt");
         this.castContnier = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerHeroEquipTips.castContnier");
         this.mountContiner = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerHeroEquipTips.mountContiner");
         this.refreshContiner = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerHeroEquipTips.refreshContiner");
         this.refreshTitle = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerHeroEquipTips.refreshTitle");
         this.addChild(this.back);
         this.addChild(this.equipIcon);
         this.addChild(this.nameText);
         this.addChild(this.descText);
         this.addChild(this.castContnier);
         this.addChild(this.mountContiner);
         this.addChild(this.refreshContiner);
         this.refreshTitle.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTipsContent.refreshAdd");
         this.equipIcon.x = 16;
         this.equipIcon.y = 11;
         this.descText.y = 40;
         this.nameText.x = 75;
      }
    $$updateTransform() {
         if(this.tipData)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this.castContnier);
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this.mountContiner);
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this.refreshContiner);
            this.info = $.as(this.tipData, $.C("yishi.datas.goods.GoodsInfo"));
            this.index = $.C("dragontalker.DragonTalkerViewHelper").GetIndexByPos(this.info.pos);
            this.symbioteInfo = this.model.getSymbioteInfoByIndex(this.index);
            this.tempInfo = this.info.templateInfo;
            this.nameText.setFrame(this.tempInfo.Profile);
            this.nameText.text = this.tempInfo.TemplateName;
            this.equipIcon.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(this.tempInfo.TemplateId);
            this.descText.text = $.C("manager.LanguageMgr").GetTranslation("DragonTalkerTalismanTips.equipText.equip");
            this.initAttView();
            this.initGemView();
            this.initRefreshView();
         }
      }
    initAttView() {
         var _loc5_ = 0;
         var _loc10_ = null;
         var _loc1_ = 0;
         var _loc3_ = null;
         var _loc2_ = 0;
         var _loc7_ = 0;
         var _loc9_ = 0;
         var _loc8_ = null;
         var _loc6_ = this.tempInfo.hasValueAtt;
         var _loc4_ = $.int(_loc6_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc10_ = _loc6_[_loc5_];
            _loc1_ = $.int(this.tempInfo[_loc10_]);
            _loc3_ = new ($.C("yishi.view.tips.DragonTalkerAttTipsItem"))();
            _loc2_ = this.getAdd(_loc1_,this.info);
            _loc7_ = this.getNewAdd(_loc1_,this.info);
            _loc9_ = _loc1_ + _loc2_ + this.getConciseValue(_loc2_) + _loc7_ + this.getConciseValue(_loc7_);
            if(this.symbioteInfo.addPercent != 0)
            {
               _loc9_ = Math.floor(this.symbioteInfo.addPercent * _loc9_ / 100);
            }
            _loc8_ = $.C("manager.LanguageMgr").GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc10_,_loc9_);
            _loc3_.setData(_loc8_);
            _loc3_.x = 140 * _loc5_;
            this.castContnier.addChild(_loc3_);
            _loc5_++;
         }
      }
    initGemView() {
         var _loc2_ = 0;
         var _loc3_ = 0;
         var _loc1_ = null;
         if(this.info && this.tempInfo && this.tempInfo.StrengthenMax > 0)
         {
            _loc2_ = this.info.templateInfo.Profile >= 5 ? 4 : 3;
         }
         _loc3_ = 1;
         while(_loc3_ <= _loc2_)
         {
            _loc1_ = new ($.C("yishi.view.tips.HeroGemTipItem"))();
            _loc1_.setData(this.info["join" + _loc3_],this.info.objectId,this.symbioteInfo.addPercent);
            _loc1_.x = _loc3_ % 2 == 0 ? 140 : 0;
            _loc1_.y = _loc3_ / 3 >= 1 ? 45 : 0;
            this.mountContiner.addChild(_loc1_);
            _loc3_++;
         }
      }
    initRefreshView() {
         var _loc5_ = 0;
         var _loc7_ = null;
         var _loc6_ = null;
         var _loc2_ = null;
         var _loc4_ = "";
         var _loc1_ = false;
         this.refreshContiner.addChild(this.refreshTitle);
         _loc5_ = 1;
         while(_loc5_ < 6)
         {
            _loc4_ += this.info["randomSkill" + _loc5_] + ",";
            if(this.info["randomSkill" + _loc5_] != 0)
            {
               _loc1_ = true;
            }
            _loc5_++;
         }
         if(_loc1_ == false)
         {
            _loc4_ = this.info.templateInfo.DefaultSkill;
         }
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoByIds(_loc4_);
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc7_ = $.as(_loc3_[_loc5_], $.C("yishi.datas.templates.SkillTempInfo"));
            if(_loc7_)
            {
               _loc2_ = new ($.C("yishi.view.tips.DragonTalkerAttTipsItem"))();
               _loc2_.setData(this.getRefreshStr(_loc7_,this.info.objectId));
               _loc2_.x = _loc5_ % 2 == 0 ? 0 : 135;
               _loc2_.y = $.int(_loc5_ / 2) * 20 + 20;
               this.refreshContiner.addChild(_loc2_);
            }
            _loc5_++;
         }
      }
    getRefreshStr(param1, param2) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc6_ = 0;
         var _loc10_ = null;
         var _loc4_ = 0;
         var _loc8_ = null;
         var _loc9_ = 0;
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.skillPropertyTemplateCate.getTemplateByID(param1.TemplateId);
         if(!_loc3_)
         {
            return "";
         }
         var _loc7_ = _loc3_.hasValueAtt;
         var _loc5_ = $.int(_loc7_.length);
         var _loc11_ = "";
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc10_ = _loc7_[_loc6_];
            _loc4_ = $.int(_loc3_[_loc10_]);
            _loc8_ = $.C("manager.LanguageMgr").GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc10_,"");
            _loc9_ = _loc4_ + $.C("yishi.utils.GoodsHelp").getConciseValue(_loc4_,this.thane.conciseGrades);
            if(this.symbioteInfo.addPercent != 0)
            {
               _loc9_ = Math.floor(_loc9_ * this.symbioteInfo.addPercent / 100);
            }
            _loc11_ += _loc8_ + _loc9_ + "   ";
            _loc6_++;
         }
         return _loc11_;
      }
    getAdd(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return $.C("yishi.utils.GoodsHelp").getStrengthenAddition(param1,param2.strengthenGrade);
      }
    getNewAdd(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc4_ = 0;
         var _loc3_ = param2.templateInfo;
         if(_loc3_.StrengthenMax > 0 && _loc3_.Profile >= 5 && _loc3_.NeedGrades >= 50)
         {
            if(param2.mouldGrade > 0)
            {
               return $.int($.C("yishi.utils.GoodsHelp").getMouldAddition(param1,this.getPropertyMouldGrade(param2)));
            }
         }
         return 0;
      }
    getConciseValue(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = 0;
         if(this.info.objectId == this.thane.id)
         {
            _loc2_ = $.int($.C("yishi.utils.GoodsHelp").getConciseValue(param1,this.thane.conciseGrades));
         }
         return _loc2_;
      }
    getPropertyMouldGrade(param1) {
         if(param1.mouldGrade < 1)
         {
            return 1;
         }
         if(param1.mouldGrade > param1.MOULD_MAX_GRADE)
         {
            return param1.MOULD_MAX_GRADE;
         }
         return param1.mouldGrade;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get model() {
         return $.C("managers.DragonTalkerManager").instance.model;
      }
    get height() {
         if(this.back)
         {
            return this.back.height;
         }
         return super.height;
      }
    get width() {
         if(this.back)
         {
            return this.back.width;
         }
         return super.width;
      }
    dispose() {
         super.dispose();
      }
    set thane(v) { super.thane = v; }
    set model(v) { super.model = v; }
    set height(v) { super.height = v; }
    set width(v) { super.width = v; }
  }
  $.meta(__DragonTalkerHeroEquipTips, "yishi.view.tips.DragonTalkerHeroEquipTips", []);
  return __DragonTalkerHeroEquipTips;
}
deps["yishi.view.tips.DragonTalkerHeroEquipTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "dragontalker.DragonTalkerViewHelper", "manager.LanguageMgr", "managers.DragonTalkerManager", "yishi.datas.goods.GoodsInfo", "yishi.datas.templates.SkillTempInfo", "yishi.manager.ArmyManager", "yishi.manager.TempleteManager", "yishi.utils.GoodsHelp", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip", "yishi.view.tips.DragonTalkerAttTipsItem", "yishi.view.tips.HeroGemTipItem"];

defs["yishi.view.tips.DragonTalkerSymbioteContrastTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __DragonTalkerSymbioteContrastTips extends __Base {
    static $fields(self) {
    self._talismanTip = null;
    self._equipTip1 = null;
    self._equipTip2 = null;
    self.heroTipsArr = [];
    }
    constructor() {
         super();
      }
    init() {
         this._talismanTip = new ($.C("yishi.view.tips.DragonTalkerTalismanTips"))(2);
         this._equipTip1 = new ($.C("yishi.view.tips.DragonTalkerHeroEquipTips"))();
         this._equipTip2 = new ($.C("yishi.view.tips.DragonTalkerHeroEquipTips"))();
         this.heroTipsArr.push(this._equipTip1);
         this.heroTipsArr.push(this._equipTip2);
      }
    set tipData(param1) {
         var _loc6_ = 0;
         var _loc3_ = 0;
         this.clean();
         var _loc5_ = $.as(param1, "int");
         var _loc4_ = this.model.getEquipTalismanInfoBySontype(_loc5_);
         if(_loc4_)
         {
            this.addChild(this._talismanTip);
            this._talismanTip.tipData = _loc4_;
         }
         var _loc8_ = $.C("dragontalker.DragonTalkerViewHelper").GetEquipPosBySontype(_loc5_);
         var _loc9_ = $.C("yishi.manager.GoodsManager").instance.getHeroGoodsListByTypeAndId(1,this.thane.id);
         var _loc7_ = 4;
         var _loc2_ = $.int(_loc8_.length);
         _loc6_ = 0;
         while(_loc6_ < this.heroTipsArr.length)
         {
            if(_loc6_ < _loc2_)
            {
               _loc3_ = $.int(_loc8_[_loc6_]);
               if(_loc9_[_loc3_ + "_" + _loc7_])
               {
                  this.heroTipsArr[_loc6_].tipData = _loc9_[_loc3_ + "_" + _loc7_];
                  this.addChild(this.heroTipsArr[_loc6_]);
               }
            }
            _loc6_++;
         }
         this.resetPosition();
      }
    resetPosition() {
         var _loc3_ = 0;
         var _loc1_ = null;
         var _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ < this.heroTipsArr.length)
         {
            _loc1_ = this.heroTipsArr[_loc3_];
            if(_loc1_.tipData)
            {
               _loc1_.x = 0;
               _loc1_.y = _loc2_ * 325;
               _loc2_++;
            }
            _loc3_++;
         }
         if(this._talismanTip.tipData)
         {
            this._talismanTip.x = _loc2_ > 0 ? 305 : 0;
            this._talismanTip.y = _loc2_ == 2 ? 180 : 0;
         }
      }
    clean() {
         this._talismanTip.tipData = null;
         this._equipTip1.tipData = null;
         this._equipTip2.tipData = null;
         if(this._talismanTip.parent)
         {
            this.removeChild(this._talismanTip);
         }
         if(this._equipTip1.parent)
         {
            this.removeChild(this._equipTip1);
         }
         if(this._equipTip2.parent)
         {
            this.removeChild(this._equipTip2);
         }
      }
    get model() {
         return $.C("managers.DragonTalkerManager").instance.model;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._talismanTip);
         this._talismanTip = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._equipTip1);
         this._equipTip1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._equipTip2);
         this._equipTip2 = null;
         super.dispose();
      }
    get tipData() { return super.tipData; }
    set model(v) { super.model = v; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__DragonTalkerSymbioteContrastTips, "yishi.view.tips.DragonTalkerSymbioteContrastTips", []);
  return __DragonTalkerSymbioteContrastTips;
}
deps["yishi.view.tips.DragonTalkerSymbioteContrastTips"] = ["com.pickgliss.utils.ObjectUtils", "dragontalker.DragonTalkerViewHelper", "managers.DragonTalkerManager", "yishi.manager.ArmyManager", "yishi.manager.GoodsManager", "yishi.view.tips.BaseTip", "yishi.view.tips.DragonTalkerHeroEquipTips", "yishi.view.tips.DragonTalkerTalismanTips"];

defs["yishi.view.tips.DragonTalkerTalismanContrastTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __DragonTalkerTalismanContrastTips extends __Base {
    static $fields(self) {
    self._talismanTip1 = null;
    self._talismanTip2 = null;
    }
    constructor() {
         super();
      }
    init() {
         this._talismanTip1 = new ($.C("yishi.view.tips.DragonTalkerTalismanTips"))();
         this._talismanTip1.y = 25;
         this._talismanTip2 = new ($.C("yishi.view.tips.DragonTalkerTalismanTips"))();
         this._talismanTip2.y = 25;
      }
    set direction(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         switch(param1)
         {
            case 0:
            case 2:
            case 5:
            case 7:
               this._talismanTip1.x = 0;
               if(this._talismanTip2.tipData)
               {
                  this._talismanTip2.x = this._talismanTip1.x + this._talismanTip1.width + 5;
               }
               break;
            case 1:
            case 3:
            case 4:
            case 6:
               this._talismanTip1.x = 0;
               if(this._talismanTip2.tipData)
               {
                  this._talismanTip2.x = 0;
                  this._talismanTip1.x = this._talismanTip2.x + this._talismanTip2.width + 5;
               }
         }
         this._talismanTip1.x = Math.round(this._talismanTip1.x);
         this._talismanTip1.y = Math.round(this._talismanTip1.y);
         this._talismanTip2.x = Math.round(this._talismanTip2.x);
         this._talismanTip2.y = Math.round(this._talismanTip2.y);
      }
    set tipData(param1) {
         this.clean();
         this._data = param1;
         if(!this._data)
         {
            return;
         }
         var _loc2_ = $.as(this._data, $.C("mvc.module.dragontalker.DragonTalkerTalismanInfo"));
         this.addChild(this._talismanTip1);
         this._talismanTip1.tipData = _loc2_;
         var _loc3_ = this.model.getEquipTalismanInfoBySontype(_loc2_.goodsTempInfo.SonType);
         if(_loc3_ && _loc3_.id != _loc2_.id)
         {
            this.addChild(this._talismanTip2);
            this._talismanTip2.tipData = _loc3_;
         }
      }
    clean() {
         this._talismanTip1.tipData = null;
         this._talismanTip2.tipData = null;
         if(this._talismanTip1.parent)
         {
            this.removeChild(this._talismanTip1);
         }
         if(this._talismanTip2.parent)
         {
            this.removeChild(this._talismanTip2);
         }
      }
    get model() {
         return $.C("managers.DragonTalkerManager").instance.model;
      }
    dispose() {
         if(this._talismanTip2)
         {
            this._talismanTip2.dispose();
         }
         this._talismanTip2 = null;
         if(this._talismanTip1)
         {
            this._talismanTip1.dispose();
         }
         this._talismanTip1 = null;
         super.dispose();
      }
    get direction() { return super.direction; }
    get tipData() { return super.tipData; }
    set model(v) { super.model = v; }
  }
  $.meta(__DragonTalkerTalismanContrastTips, "yishi.view.tips.DragonTalkerTalismanContrastTips", []);
  return __DragonTalkerTalismanContrastTips;
}
deps["yishi.view.tips.DragonTalkerTalismanContrastTips"] = ["managers.DragonTalkerManager", "mvc.module.dragontalker.DragonTalkerTalismanInfo", "yishi.view.tips.BaseTip", "yishi.view.tips.DragonTalkerTalismanTips"];

defs["yishi.view.tips.DragonTalkerTalismanExpTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __DragonTalkerTalismanExpTips extends __Base {
    static $fields(self) {
    self.back = null;
    self.talismanBack = null;
    self.profileBack = null;
    self.talismanIcon = null;
    self.nameText = null;
    self.descText = null;
    self._iconSprite = null;
    }
    constructor() {
         super();
      }
    init() {
         this.back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DragonTalkerTalismanExpTips.back");
         this.talismanBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.talismanBack");
         this.profileBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.profileBack");
         this.talismanIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DragonTalkerTalismanTips.talismanIcon");
         this.nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.nameText");
         this.descText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.descText");
         this.addChild(this.back);
         this.addChild(this.talismanBack);
         this.addChild(this.talismanIcon);
         this.addChild(this.profileBack);
         this.addChild(this.nameText);
         this.addChild(this.descText);
         this.back.width = 249;
         this.talismanIcon.mask = this.createSprite();
         this.descText.text = $.C("manager.LanguageMgr").GetTranslation("DragonTalkerTalismanTips.descText.text");
      }
    createSprite() {
         this._iconSprite = new ($.C("flash.display.Sprite"))();
         this._iconSprite.graphics.beginFill(16777215,1);
         this._iconSprite.graphics.drawCircle(52,62,28);
         this._iconSprite.graphics.endFill();
         this.addChild(this._iconSprite);
         this._iconSprite.mouseChildren = this._iconSprite.mouseEnabled = false;
         return this._iconSprite;
      }
    $$updateTransform() {
         var _loc1_ = null;
         if($.is(this.tipData, $.C("mvc.module.dragontalker.DragonTalkerTalismanInfo")))
         {
            _loc1_ = ($.as(this.tipData, $.C("mvc.module.dragontalker.DragonTalkerTalismanInfo"))).goodsTempInfo;
         }
         else if($.is(this.tipData, $.C("yishi.datas.goods.GoodsInfo")))
         {
            _loc1_ = ($.as(this.tipData, $.C("yishi.datas.goods.GoodsInfo"))).templateInfo;
         }
         if(_loc1_)
         {
            this.talismanBack.setFrame(_loc1_.SonType - 401);
            this.profileBack.setFrame(_loc1_.Profile);
            this.talismanIcon.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(_loc1_.TemplateId);
            this.nameText.text = _loc1_.TemplateName;
            this.nameText.setFrame(_loc1_.Profile);
         }
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__DragonTalkerTalismanExpTips, "yishi.view.tips.DragonTalkerTalismanExpTips", []);
  return __DragonTalkerTalismanExpTips;
}
deps["yishi.view.tips.DragonTalkerTalismanExpTips"] = ["com.pickgliss.ui.ComponentFactory", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.dragontalker.DragonTalkerTalismanInfo", "yishi.datas.goods.GoodsInfo", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.DragonTalkerTalismanTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __DragonTalkerTalismanTips extends __Base {
    static $fields(self) {
    self.back = null;
    self.talismanBack = null;
    self.profileBack = null;
    self.talismanIcon = null;
    self.nameText = null;
    self.intensifyContiner = null;
    self.numImage = null;
    self.addImg = null;
    self.equipText = null;
    self.attText = null;
    self.attVbox = null;
    self.suitText = null;
    self.suitVbox = null;
    self._iconSprite = null;
    self.tipType = 0;
    }
    constructor(param1 = 1) {
         super();
         this.tipType = param1;
      }
    init() {
         this.back = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.DragonTalkerTalismanTips.back");
         this.talismanBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.talismanBack");
         this.profileBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.profileBack");
         this.talismanIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DragonTalkerTalismanTips.talismanIcon");
         this.nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.nameText");
         this.intensifyContiner = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.intensifyContiner");
         this.addImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.addImg");
         this.numImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.tips.numImg");
         this.equipText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.equipText");
         this.attText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.attText");
         this.attVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.attVbox");
         this.suitText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitText");
         this.suitVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitVbox");
         this.addChild(this.back);
         this.addChild(this.talismanBack);
         this.addChild(this.talismanIcon);
         this.addChild(this.profileBack);
         this.addChild(this.nameText);
         this.addChild(this.addImg);
         this.addChild(this.intensifyContiner);
         this.addChild(this.equipText);
         this.addChild(this.attText);
         this.addChild(this.attVbox);
         this.addChild(this.suitText);
         this.addChild(this.suitVbox);
         this.talismanIcon.mask = this.createSprite();
         this.addImg.visible = this.intensifyContiner.visible = false;
         this.addImg.x = 180;
         this.addImg.y = 60;
         this.attText.text = $.C("manager.LanguageMgr").GetTranslation("DragonTalkerTalismanTips.attText.text");
         this.suitText.text = $.C("manager.LanguageMgr").GetTranslation("DragonTalkerTalismanTips.suitText.text");
      }
    createSprite() {
         this._iconSprite = new ($.C("flash.display.Sprite"))();
         this._iconSprite.graphics.beginFill(16777215,1);
         this._iconSprite.graphics.drawCircle(50,60,28);
         this._iconSprite.graphics.endFill();
         this.addChild(this._iconSprite);
         this._iconSprite.mouseChildren = this._iconSprite.mouseEnabled = false;
         return this._iconSprite;
      }
    $$updateTransform() {
         var _loc22_ = null;
         var _loc1_ = null;
         var _loc27_ = false;
         var _loc4_ = false;
         var _loc15_ = null;
         var _loc10_ = false;
         var _loc13_ = null;
         var _loc18_ = 0;
         var _loc11_ = null;
         var _loc12_ = null;
         var _loc24_ = 0;
         var _loc5_ = null;
         var _loc8_ = 0;
         var _loc21_ = null;
         var _loc6_ = null;
         var _loc2_ = null;
         var _loc23_ = 0;
         var _loc17_ = 0;
         var _loc7_ = 0;
         var _loc26_ = null;
         var _loc9_ = 0;
         var _loc20_ = null;
         var _loc14_ = 0;
         var _loc3_ = null;
         var _loc19_ = null;
         var _loc25_ = null;
         this.attVbox.removeAllChild();
         this.suitVbox.removeAllChild();
         var _loc16_ = 0;
         if($.is(this.tipData, $.C("mvc.module.dragontalker.DragonTalkerTalismanInfo")))
         {
            _loc15_ = $.as(this.tipData, $.C("mvc.module.dragontalker.DragonTalkerTalismanInfo"));
            if(_loc15_.isNew)
            {
               $.C("managers.DragonTalkerManager").instance.sendDragonTalkerTalismanReq(4,_loc15_.id);
            }
            _loc1_ = _loc15_.goodsTempInfo;
            _loc22_ = _loc15_.suitTempInfo;
            _loc27_ = Boolean(_loc15_.isSelf);
            _loc4_ = _loc15_.isEquip && _loc27_;
            if(_loc15_.grade > 0)
            {
               this.addImg.visible = this.intensifyContiner.visible = true;
               $.C("yishi.utils.NumberViewUtils").refreshValue(_loc15_.grade,this.intensifyContiner,this.numImage,19,22,15,19,"0123456789");
            }
            else
            {
               this.addImg.visible = this.intensifyContiner.visible = false;
            }
            _loc10_ = this.tipType != 1;
            $.C("dragontalker.DragonTalkerViewHelper").SetPropTextView(1,this.attVbox,_loc15_,_loc10_);
         }
         else if($.is(this.tipData, $.C("yishi.datas.goods.GoodsInfo")))
         {
            _loc1_ = ($.as(this.tipData, $.C("yishi.datas.goods.GoodsInfo"))).templateInfo;
            _loc22_ = $.C("yishi.manager.TempleteManager").instance.suitTemplateCate.getTemplateByID(_loc1_.SuiteId);
            _loc4_ = false;
            _loc27_ = false;
            this.addImg.visible = this.intensifyContiner.visible = false;
            _loc13_ = _loc1_.hasValueAtt;
            _loc18_ = $.int(_loc13_.length);
            _loc11_ = "";
            _loc16_ = 0;
            while(_loc16_ < _loc18_)
            {
               _loc12_ = _loc13_[_loc16_];
               _loc24_ = $.int(_loc1_[_loc12_]);
               _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerIntensifyView.mainAttText");
               _loc11_ = $.C("manager.LanguageMgr").GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc12_,_loc24_);
               _loc5_.htmlText = _loc11_;
               _loc5_.setFrame(_loc1_.Profile);
               this.attVbox.addChild(_loc5_);
               _loc16_++;
            }
            _loc16_ = 0;
            while(_loc16_ < 3)
            {
               _loc8_ = _loc16_ + 4;
               _loc12_ = "Property" + _loc8_;
               _loc24_ = $.int(_loc1_[_loc12_]);
               _loc21_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerIntensifyView.randomText");
               if(_loc24_ != 0)
               {
                  _loc21_.htmlText = "???";
                  _loc21_.setFrame(_loc1_.Profile);
               }
               else
               {
                  _loc21_.htmlText = $.C("manager.LanguageMgr").GetTranslation("DragonTalkerIntensifyView.randomText.typeText" + _loc16_);
                  _loc21_.setFrame(7);
               }
               this.attVbox.addChild(_loc21_);
               _loc16_++;
            }
         }
         if(_loc1_)
         {
            this.talismanBack.setFrame(_loc1_.SonType - 400);
            this.profileBack.setFrame(_loc1_.Profile);
            this.talismanIcon.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(_loc1_.TemplateId);
            this.nameText.text = _loc1_.TemplateName;
            this.nameText.setFrame(_loc1_.Profile);
            _loc4_ ? (this.equipText.text = $.C("manager.LanguageMgr").GetTranslation("DragonTalkerTalismanTips.equipText.equip")) : (this.equipText.text = "");
         }
         if(_loc22_)
         {
            _loc6_ = _loc22_.tempArr;
            _loc2_ = _loc22_.propertyArr;
            _loc23_ = $.int(_loc6_.length);
            _loc17_ = $.int(_loc2_.length);
            _loc7_ = 0;
            _loc16_ = 0;
            while(_loc16_ < _loc23_)
            {
               _loc26_ = _loc6_[_loc16_];
               _loc9_ = $.int(_loc22_[_loc26_]);
               if(_loc4_ && _loc27_ && Boolean(this.model.getIsEquipByTempId(_loc9_)))
               {
                  _loc7_++;
               }
               _loc16_++;
            }
            _loc16_ = 0;
            while(_loc16_ < _loc17_)
            {
               _loc20_ = _loc2_[_loc16_];
               _loc14_ = $.int(_loc22_[_loc20_]);
               _loc3_ = _loc20_.substring(_loc20_.length - 1);
               _loc19_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitTempText");
               _loc25_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[_loc14_];
               _loc19_.text = "(" + _loc7_ + "/" + _loc3_ + ")" + _loc25_.Description;
               _loc19_.height = _loc19_.textHeight + 8;
               this.suitVbox.addChild(_loc19_);
               _loc7_ < $.int(_loc3_) || !_loc27_ || !_loc4_ ? _loc19_.setFrame(1) : _loc19_.setFrame(2);
               _loc16_++;
            }
         }
      }
    get height() {
         if(this.back)
         {
            return this.back.height;
         }
         return super.height;
      }
    get width() {
         if(this.back)
         {
            return this.back.width;
         }
         return super.width;
      }
    get model() {
         return $.C("managers.DragonTalkerManager").instance.model;
      }
    dispose() {
         super.dispose();
      }
    set height(v) { super.height = v; }
    set width(v) { super.width = v; }
    set model(v) { super.model = v; }
  }
  $.meta(__DragonTalkerTalismanTips, "yishi.view.tips.DragonTalkerTalismanTips", []);
  return __DragonTalkerTalismanTips;
}
deps["yishi.view.tips.DragonTalkerTalismanTips"] = ["com.pickgliss.ui.ComponentFactory", "dragontalker.DragonTalkerViewHelper", "flash.display.Sprite", "manager.LanguageMgr", "managers.DragonTalkerManager", "mvc.module.dragontalker.DragonTalkerTalismanInfo", "yishi.datas.goods.GoodsInfo", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.utils.NumberViewUtils", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.DragonTitanFightingTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __DragonTitanFightingTips extends __Base {
    static $fields(self) {
    self._titanSkill = null;
    self._totalBox = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         $.C("yishi.utils.MsgMan").addObserver("DragonTitanEvent.TITAN_SKILL_USE",this,$.bind(this, "_titanSkillUseHandle"));
         this._titanSkill = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTitanFightingTips.titanSkill");
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("changejob.branchTotalBox");
         this._bg.width = 286;
         this._titanSkill.text = $.C("manager.LanguageMgr").GetTranslation("DragonTitanFightingTips.titanSkill");
         this.addChild(this._totalBox);
      }
    _titanSkillUseHandle(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this.$$updateTransform();
      }
    $$updateTransform() {
         var _loc6_ = null;
         var _loc5_ = 0;
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc1_ = null;
         this.clean();
         this._totalBox.addChild(this._titanSkill);
         var _loc2_ = $.C("battle.BattleManager").getInstance().battleModel.getRoleById($.as(this.tipData, "int"));
         if(!_loc2_)
         {
            return;
         }
         this._titanSkill.text = $.C("manager.LanguageMgr").GetTranslation("DragonTitanFightingTips.titanSkill") + "(" + _loc2_.roleName + ")";
         if($.is(_loc2_, $.C("yishi.datas.objects.HeroRoleInfo")))
         {
            _loc6_ = $.as(_loc2_, $.C("yishi.datas.objects.HeroRoleInfo"));
            _loc5_ = 0;
            while(_loc5_ < _loc6_.titanSkill.length)
            {
               _loc3_ = $.C("yishi.manager.TempleteManager").instance.getSkillById(_loc6_.titanSkill[_loc5_]);
               if(_loc3_)
               {
                  _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
                  this._totalBox.addChild(_loc4_);
                  _loc1_ = new ($.C("yishi.view.tips.DragonTitanSkillTipsItem"))();
                  _loc1_.index = _loc5_;
                  _loc1_.state = _loc6_.titanSkillUsed[_loc5_];
                  _loc1_.data = _loc3_;
                  this._totalBox.addChild(_loc1_);
               }
               _loc5_++;
            }
         }
         this._totalBox.spacing = -3;
         this._bg.height = this._totalBox.height + 20;
      }
    clean() {
         this._totalBox.removeAllChild();
      }
    dispose() {
         if(this._totalBox)
         {
            this._totalBox.dispose();
         }
         this._totalBox = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    set thane(v) { super.thane = v; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__DragonTitanFightingTips, "yishi.view.tips.DragonTitanFightingTips", []);
  return __DragonTitanFightingTips;
}
deps["yishi.view.tips.DragonTitanFightingTips"] = ["battle.BattleManager", "com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "yishi.datas.objects.HeroRoleInfo", "yishi.manager.ArmyManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.MsgMan", "yishi.view.tips.BaseTip", "yishi.view.tips.DragonTitanSkillTipsItem"];

defs["yishi.view.tips.DragonTitanSkillTipsItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __DragonTitanSkillTipsItem extends __Base {
    static $fields(self) {
    self.index = 0;
    self.state = 0;
    self._data = null;
    self._skillName = null;
    self._skillDesc = null;
    self._icon = null;
    }
    constructor() {
         super();
         this.initView();
         this.initEvent();
      }
    initView() {
         this._skillName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTitanSkillTipsItem.skillName");
         this._skillDesc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTitanSkillTipsItem.skillDesc");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("dragontitan.DragonTitanSkillTipsItem.icon");
         this.addChild(this._skillName);
         this.addChild(this._skillDesc);
         this.addChild(this._icon);
      }
    freshView() {
      }
    set data(param1) {
         this._data = param1;
         if(!this._data)
         {
            this._skillName.htmlText = $.C("manager.LanguageMgr").GetTranslation("DragonTitanSkillTipsItem.round" + this.index);
            this._skillDesc.text = "";
            return;
         }
         this._skillName.htmlText = $.C("manager.LanguageMgr").GetTranslation("DragonTitanSkillTipsItem.round" + this.index) + "  <font color=\'#299fdb\'>" + this._data.TemplateName + "</font>";
         if(this.state == 1)
         {
            this._skillName.htmlText += " <font color=\'#cd0000\'>" + $.C("manager.LanguageMgr").GetTranslation("DragonTitanSkillTipsItem.isUsed") + "</font>";
         }
         else if(this.state == 2)
         {
            this._skillName.htmlText += " <font color=\'#6F6F6F\'>" + $.C("manager.LanguageMgr").GetTranslation("DragonTitanSkillTipsItem.notCanUse") + "</font>";
         }
         this._skillDesc.text = this._data.Description;
         this._icon.icon = $.C("yishi.utils.IconFactory").getCommonIconPath(this._data.Icons);
      }
    initEvent() {
      }
    removeEvent() {
      }
    unInitView() {
      }
    dispose() {
         this.removeEvent();
         this.unInitView();
         super.dispose();
      }
    get data() {
         return this._data;
      }
  }
  $.meta(__DragonTitanSkillTipsItem, "yishi.view.tips.DragonTitanSkillTipsItem", []);
  return __DragonTitanSkillTipsItem;
}
deps["yishi.view.tips.DragonTitanSkillTipsItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "manager.LanguageMgr", "yishi.utils.IconFactory"];

defs["yishi.view.tips.DragonTitanTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __DragonTitanTips extends __Base {
    static $fields(self) {
    self._titanId = 0;
    self._icon = null;
    self._titanName = null;
    self._titanSkill = null;
    self._totalBox = null;
    self._attack = null;
    self._magicAttack = null;
    self._defence = null;
    self._magicDefence = null;
    self._parry = null;
    self._live = null;
    self._forceHit = null;
    self._strength = null;
    self._tenacity = null;
    self._penetrate = null;
    self._stunAttr = null;
    self._qualiLimit = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("dragontitan.DragonTitanTips.icon");
         this._titanName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTitanTips.titanName");
         this._titanSkill = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTitanTips.titanSkill");
         this._attack = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._magicAttack = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._defence = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._magicDefence = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._parry = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._live = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._forceHit = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._strength = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._tenacity = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._penetrate = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._stunAttr = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._qualiLimit = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTitanTips.VBox");
         this._bg.width = 286;
         this.addChild(this._icon);
         this.addChild(this._titanName);
         this.addChild(this._totalBox);
      }
    $$updateTransform() {
         this.clean();
         this._titanId = $.as(this.tipData, "int");
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.titanTemplateCate.getTemplateById(this._titanId);
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.getSkillById(parseInt(_loc3_.SkillIds));
         this._icon.icon = $.C("yishi.utils.IconFactory").getCommonIconPath(_loc3_.AvatarPath);
         this._titanName.text = _loc3_.TemplateName;
         this.addSplitLine();
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip13");
         this.updateAttributeTxt(this._attack,_loc1_,_loc3_.Attack);
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip15");
         this.updateAttributeTxt(this._magicAttack,_loc1_,_loc3_.MagicAttack);
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip14");
         this.updateAttributeTxt(this._defence,_loc1_,_loc3_.Defence);
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip16");
         this.updateAttributeTxt(this._magicDefence,_loc1_,_loc3_.MagicDefence);
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip19");
         this.updateAttributeTxt(this._parry,_loc1_,_loc3_.Parry);
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip11");
         this.updateAttributeTxt(this._live,_loc1_,_loc3_.Live);
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip10");
         this.updateAttributeTxt(this._forceHit,_loc1_,_loc3_.ForceHit);
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip23","");
         this.updateAttributeTxt(this._strength,_loc1_,_loc3_.Strength);
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip24","");
         this.updateAttributeTxt(this._tenacity,_loc1_,_loc3_.Tenacity);
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip15");
         this.updateAttributeTxt(this._penetrate,_loc1_,_loc3_.Penetrate);
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Dingli");
         this.updateAttributeTxt(this._stunAttr,_loc1_,_loc3_.StunAttr);
         _loc1_ = $.C("manager.LanguageMgr").GetTranslation("DragonTitanTips.QualiLimit");
         this.updateAttributeTxt(this._qualiLimit,_loc1_,_loc3_.QualiLimit);
         this.addSplitLine();
         this._titanSkill.htmlText = $.C("manager.LanguageMgr").GetTranslation("DragonTitanTips.skillInfo",_loc2_.TemplateName,_loc2_.Description);
         this._totalBox.addChild(this._titanSkill);
         this._bg.height = this._totalBox.y + this._totalBox.height + 10;
      }
    updateAttributeTxt(param1, param2, param3) {
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if (typeof param3 !== "number") param3 = Number(param3);
         if(param3 != 0)
         {
            param1.setData(param2 + " +" + param3);
            this._totalBox.addChild(param1);
         }
      }
    addSplitLine() {
         var _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._totalBox.addChild(_loc1_);
      }
    clean() {
         this._totalBox.removeAllChild();
      }
    dispose() {
         if(this._totalBox)
         {
            this._totalBox.dispose();
         }
         this._totalBox = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    set thane(v) { super.thane = v; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__DragonTitanTips, "yishi.view.tips.DragonTitanTips", []);
  return __DragonTitanTips;
}
deps["yishi.view.tips.DragonTitanTips"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "yishi.manager.ArmyManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.FashionAttItem"];

defs["yishi.view.tips.DreamArenaPetTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __DreamArenaPetTips extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._subBox1 = null;
    self._subBox2 = null;
    self._blackKingBg = null;
    self._redBg = null;
    self._yellowBg = null;
    self._purpleBg = null;
    self._blueBg = null;
    self._greenBg = null;
    self._whiteBg = null;
    self._splitLine = null;
    self._splitLine2 = null;
    self._hbox = null;
    self._strengthCoeTxt = null;
    self._armorCoeTxt = null;
    self._intellectCoeTxt = null;
    self._staminaCoeTxt = null;
    self._hpTxt = null;
    self._physicsAttackTxt = null;
    self._physicsDefenseTxt = null;
    self._magicAttackTxt = null;
    self._magicDefenseTxt = null;
    self._con = null;
    self._equipIcon = null;
    self._profileImg = null;
    self._title = null;
    self._petSkillIcon = null;
    self._type = null;
    self._vocation = null;
    self._strengthMc = null;
    self._hBox = null;
    self._expTxt = null;
    self.petData = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 237;
         this._blackKingBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blackItemTipsBg");
         this._redBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.redItemTipsBg");
         this._yellowBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.yellowItemTipsBg");
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._blueBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blueItemTipsBg");
         this._greenBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.greenItemTipsBg");
         this._whiteBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.whiteItemTipsBg");
         this._con = new ($.C("flash.display.Sprite"))();
         this._equipIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this._petSkillIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.PetTypeImage");
         this._type = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodTypeText_2");
         this._vocation = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodVocationText");
         this._strengthMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tip.pet.PropertyCoeBar");
         this._expTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("pet.ExpTxt");
         this._hBox = new ($.C("com.pickgliss.ui.controls.container.HBox"))();
         this._splitLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._splitLine.x = -7;
         this._splitLine.scaleX = 0.95;
         this._splitLine2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._splitLine2.x = -7;
         this._splitLine2.scaleX = 0.95;
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsTotalBox");
         this._subBox1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsSubBox");
         this._subBox2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsSubBox");
         this._strengthCoeTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._armorCoeTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._intellectCoeTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._staminaCoeTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._hpTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._physicsAttackTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._physicsDefenseTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._magicAttackTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._magicDefenseTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this.addChild(this._blackKingBg);
         this.addChild(this._redBg);
         this.addChild(this._yellowBg);
         this.addChild(this._purpleBg);
         this.addChild(this._blueBg);
         this.addChild(this._greenBg);
         this.addChild(this._whiteBg);
         this._profileImg.setFrame(1);
         this._con.addChild(this._equipIcon);
         this._equipIcon.x = 15;
         this._equipIcon.y = 1;
         this._con.addChild(this._title);
         this._title.x = 140;
         this._title.y = 20;
         this._con.addChild(this._petSkillIcon);
         this._petSkillIcon.x = 235;
         this._petSkillIcon.y = 15;
         this._con.addChild(this._profileImg);
         this._profileImg.x = 15;
         this._profileImg.y = 10;
         this._con.addChild(this._type);
         this._type.x = 6;
         this._type.y = 65;
         this._con.addChild(this._vocation);
         this._vocation.x = 45;
         this._vocation.y = 65;
         this._con.addChild(this._hBox);
         this._hBox.x = 150;
         this._hBox.y = 45;
         this._con.addChild(this._strengthMc);
         this._strengthMc.x = 18;
         this._strengthMc.y = 87;
         this._con.addChild(this._expTxt);
         this._expTxt.x = 52;
         this._expTxt.y = 87;
         this._expTxt.width = 140;
         this._totalBox.x = 10;
         this._totalBox.y = 110;
         this.petData = new ($.C("mvc.module.pet.PetData"))();
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc3_ = 0;
         var _loc2_ = 0;
         this.clean();
         if(this.tipData && $.is(this.tipData, $.C("yishi.datas.templates.DreamArenaTempInfo")))
         {
            this.setPetTipData($.as(this.tipData, $.C("yishi.datas.templates.DreamArenaTempInfo")),this.petData);
            _loc1_ = $.C("yishi.manager.TempleteManager").instance.skillPropertyTemplateCate.getTemplateByID(($.as(this.tipData, $.C("yishi.datas.templates.DreamArenaTempInfo"))).PropertyId);
            this._equipIcon.icon = $.C("yishi.utils.IconFactory").getPetHeadItemIcon(this.petData.templateId);
            this._profileImg.setFrame(this.petData.quality);
            this._bg.visible = false;
            this.hidenBg(this.petData.quality);
            this.showStar(this.petData);
            this._title.setFrame(this.petData.quality);
            this._title.text = this.petData.name;
            this._type.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",this.petData.grade);
            this._vocation.text = this.petData.getLevelString();
            if(this.petData.upgradeTemplte)
            {
               this._expTxt.text = this.petData.curExp + " / " + this.petData.upgradeTemplte.Data;
               _loc3_ = Math.floor(this.petData.curExp * 100 / this.petData.upgradeTemplte.Data);
               this._strengthMc.gotoAndStop(_loc3_);
            }
            else
            {
               this._expTxt.text = "MAX";
               this._strengthMc.gotoAndStop(100);
            }
            _loc2_ = this.petData.template.PetType - 100;
            if(_loc2_ < 7)
            {
               this._petSkillIcon.setFrame(_loc2_);
            }
            else if(_loc2_ == 17)
            {
               this._petSkillIcon.setFrame(7);
            }
            else if(_loc2_ == 18)
            {
               this._petSkillIcon.setFrame(8);
            }
            else if(_loc2_ == 19)
            {
               this._petSkillIcon.setFrame(9);
            }
            this.initAttribute(this.petData,_loc1_);
            this.addChild(this._con);
            this.addChild(this._totalBox);
            this._totalBox.addChild(this._splitLine);
            this._totalBox.addChild(this._subBox1);
            this._totalBox.addChild(this._splitLine2);
            this._totalBox.addChild(this._subBox2);
            this._bg.height = $.int(this._totalBox.y + this._totalBox.height);
            this._blackKingBg.width = this._redBg.width = this._yellowBg.width = this._purpleBg.width = this._blueBg.width = this._greenBg.width = this._whiteBg.width = this._bg.width = 280;
            this._blackKingBg.height = this._redBg.height = this._yellowBg.height = this._purpleBg.height = this._blueBg.height = this._greenBg.height = this._whiteBg.height = this._bg.height;
         }
      }
    setPetTipData(param1, param2) {
         param2.templateId = param1.TypeTemplateId;
         param2.quality = 6;
         param2.grade = 80;
         param2.name = param2.template.TemplateName;
         param2.temQuality = 31;
         param2.coeStrength = param2.coeStrengthLimit = $.int(param2.template.PowerApt.split(",")[1]);
         param2.coeArmor = param2.coeArmorLimit = $.int(param2.template.ArmorApt.split(",")[1]);
         param2.coeIntellect = param2.coeIntellectLimit = $.int(param2.template.IntelApt.split(",")[1]);
         param2.coeStamina = param2.coeStaminaLimit = $.int(param2.template.PhysiApt.split(",")[1]);
      }
    showStar(param1) {
         var _loc4_ = null;
         var _loc3_ = 0;
         var _loc6_ = 0;
         var _loc5_ = null;
         var _loc2_ = param1.qualityUpgradeTemplateInfo;
         if(_loc2_ == null)
         {
            return;
         }
         _loc3_ = param1.temQuality % 5 == 0 ? 5 : param1.temQuality % 5;
         if(param1.temQuality > 25)
         {
            _loc4_ = "asset.pet.bigMoonLightLevelImg";
         }
         else
         {
            _loc4_ = "asset.pet.StarLevelLightImg";
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap(_loc4_);
            this._hBox.addChild(_loc5_);
            _loc6_++;
         }
      }
    initAttribute(param1, param2) {
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("pet.strengthCoe");
         this.updateAttributeTxt(this._strengthCoeTxt,_loc3_,this._subBox1,param1.coeStrength + " / " + param1.coeStrengthLimit);
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("pet.armorCoe");
         this.updateAttributeTxt(this._armorCoeTxt,_loc3_,this._subBox1,param1.coeArmor + " / " + param1.coeArmorLimit);
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("pet.intellectCoe");
         this.updateAttributeTxt(this._intellectCoeTxt,_loc3_,this._subBox1,param1.coeIntellect + " / " + param1.coeIntellectLimit);
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("pet.staminaCoe");
         this.updateAttributeTxt(this._staminaCoeTxt,_loc3_,this._subBox1,param1.coeStamina + " / " + param1.coeStaminaLimit);
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("pet.hp");
         this.updateAttributeTxt(this._hpTxt,_loc3_,this._subBox2,param2.Live.toString());
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip06");
         this.updateAttributeTxt(this._physicsAttackTxt,_loc3_,this._subBox2,param2.Attack.toString());
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip07");
         this.updateAttributeTxt(this._physicsDefenseTxt,_loc3_,this._subBox2,param2.Defence.toString());
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip08");
         this.updateAttributeTxt(this._magicAttackTxt,_loc3_,this._subBox2,param2.MagicAttack.toString());
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip09");
         this.updateAttributeTxt(this._magicDefenseTxt,_loc3_,this._subBox2,param2.MagicDefence.toString());
      }
    updateAttributeTxt(param1, param2, param3, param4) {
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         if(param4 != "0")
         {
            param1.setData(param2 + " " + param4);
            param3.addChild(param1);
         }
      }
    clean() {
         this._hBox.removeAllChild();
         this._subBox1.removeAllChild();
         this._subBox2.removeAllChild();
         this._totalBox.removeAllChild();
         if(this._con.parent)
         {
            this._con.parent.removeChild(this._con);
         }
         if(this._totalBox.parent)
         {
            this._totalBox.parent.removeChild(this._totalBox);
         }
      }
    hidenBg(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._blackKingBg.visible = false;
         this._redBg.visible = false;
         this._yellowBg.visible = false;
         this._purpleBg.visible = false;
         this._blueBg.visible = false;
         this._greenBg.visible = false;
         this._whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               this._whiteBg.visible = true;
               break;
            case 1:
               this._greenBg.visible = true;
               break;
            case 2:
               this._blueBg.visible = true;
               break;
            case 3:
               this._purpleBg.visible = true;
               break;
            case 4:
               this._yellowBg.visible = true;
               break;
            case 5:
               this._redBg.visible = true;
               break;
            case 6:
               this._blackKingBg.visible = true;
         }
      }
  }
  $.meta(__DreamArenaPetTips, "yishi.view.tips.DreamArenaPetTips", []);
  return __DreamArenaPetTips;
}
deps["yishi.view.tips.DreamArenaPetTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.HBox", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.pet.PetData", "yishi.datas.templates.DreamArenaTempInfo", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.FashionAttItem"];

defs["yishi.view.tips.DreamArenaTalismanTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __DreamArenaTalismanTips extends __Base {
    static $fields(self) {
    self.back = null;
    self.profileBack = null;
    self.talismanIcon = null;
    self.nameText = null;
    self.splitLine = null;
    self.suitText = null;
    self.suitVbox = null;
    self._iconSprite = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 237;
         this.profileBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.profileBack");
         this.talismanIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("DragonTalkerTalismanTips.talismanIcon");
         this.nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.nameText");
         this.suitText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitText");
         this.suitVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitVbox");
         this.splitLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this.addChild(this.talismanIcon);
         this.addChild(this.profileBack);
         this.addChild(this.nameText);
         this.addChild(this.splitLine);
         this.addChild(this.suitText);
         this.addChild(this.suitVbox);
         this.talismanIcon.y = 12;
         this.profileBack.y = 10;
         this.nameText.y = 25;
         this.suitText.y = 85;
         this.suitVbox.y = 115;
         this.splitLine.x = -7;
         this.splitLine.y = 90;
         this.splitLine.scaleX = 0.95;
         this.talismanIcon.mask = this.createSprite();
         this.suitText.text = $.C("manager.LanguageMgr").GetTranslation("DragonTalkerTalismanTips.suitText.text");
      }
    createSprite() {
         this._iconSprite = new ($.C("flash.display.Sprite"))();
         this._iconSprite.graphics.beginFill(16777215,1);
         this._iconSprite.graphics.drawCircle(50,45,28);
         this._iconSprite.graphics.endFill();
         this.addChild(this._iconSprite);
         this._iconSprite.mouseChildren = this._iconSprite.mouseEnabled = false;
         return this._iconSprite;
      }
    $$updateTransform() {
         var _loc7_ = null;
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc6_ = null;
         var _loc1_ = null;
         var _loc8_ = null;
         this.suitVbox.removeAllChild();
         var _loc5_ = 0;
         if(this.tipData && $.is(this.tipData, $.C("yishi.datas.templates.DreamArenaTempInfo")))
         {
            _loc2_ = $.as(($.as(this.tipData, $.C("yishi.datas.templates.DreamArenaTempInfo"))).typeTempInfo, $.C("yishi.datas.templates.GoodsTemplateInfo"));
            _loc7_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[($.as(this.tipData, $.C("yishi.datas.templates.DreamArenaTempInfo"))).Skill1];
            _loc4_ = $.C("yishi.manager.TempleteManager").instance.skillTemplateDic[($.as(this.tipData, $.C("yishi.datas.templates.DreamArenaTempInfo"))).Skill2];
            if(_loc2_)
            {
               this.profileBack.setFrame(_loc2_.Profile);
               this.talismanIcon.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(_loc2_.TemplateId);
               this.nameText.text = _loc2_.TemplateName;
               this.nameText.setFrame(_loc2_.Profile);
            }
            _loc3_ = [_loc7_,_loc4_];
            _loc8_ = "";
            _loc5_ = 0;
            while(_loc5_ < 2)
            {
               _loc6_ = $.as(_loc3_[_loc5_], $.C("yishi.datas.templates.SkillTempInfo"));
               if(_loc6_)
               {
                  _loc8_ = _loc5_ == 0 ? "(2/2)" : "(4/4)";
                  _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DragonTalkerTalismanTips.suitTempText");
                  _loc1_.text = _loc8_ + _loc6_.Description;
                  _loc1_.height = _loc1_.textHeight + 8;
                  this.suitVbox.addChild(_loc1_);
                  _loc1_.setFrame(2);
               }
               _loc5_++;
            }
            this._bg.height = $.int(this.suitVbox.y + this.suitVbox.height + 5);
         }
      }
    get model() {
         return $.C("managers.DragonTalkerManager").instance.model;
      }
    dispose() {
         super.dispose();
      }
    set model(v) { super.model = v; }
  }
  $.meta(__DreamArenaTalismanTips, "yishi.view.tips.DreamArenaTalismanTips", []);
  return __DreamArenaTalismanTips;
}
deps["yishi.view.tips.DreamArenaTalismanTips"] = ["com.pickgliss.ui.ComponentFactory", "flash.display.Sprite", "manager.LanguageMgr", "managers.DragonTalkerManager", "yishi.datas.templates.DreamArenaTempInfo", "yishi.datas.templates.GoodsTemplateInfo", "yishi.datas.templates.SkillTempInfo", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.EastBlessTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __EastBlessTips extends __Base {
    static $fields(self) {
    self._title1 = null;
    self._vbox = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 190;
         this._title1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.EastBlessTips.Title");
         this._vbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.EastBlessTips.vbox");
         this.addChild(this._title1);
         this.addChild(this._vbox);
      }
    $$updateTransform() {
         var _loc7_ = null;
         var _loc2_ = 0;
         var _loc4_ = null;
         var _loc6_ = null;
         var _loc1_ = null;
         var _loc3_ = null;
         var _loc5_ = 0;
         if(this.tipData)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._vbox);
            _loc7_ = $.as(this.tipData, "Array");
            _loc2_ = $.int(_loc7_.length);
            this._title1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.EastBlessTips.titileTxt");
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc3_ = $.as(_loc7_[_loc5_], $.C("mvc.module.gamehall.GameHallBlessInfo"));
               if(_loc3_ && _loc3_.skillTempInfo)
               {
                  _loc4_ = new ($.C("flash.display.Sprite"))();
                  _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.EastBlessTips.blessName");
                  _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.EastBlessTips.blessLevel");
                  _loc6_.text = _loc3_.skillTempInfo.TemplateName;
                  if(_loc3_.level >= _loc3_.skillTempInfo.Grades)
                  {
                     _loc1_.setFrame(2);
                  }
                  else
                  {
                     _loc1_.setFrame(1);
                  }
                  _loc1_.text = _loc3_.level + "/" + _loc3_.skillTempInfo.Grades;
                  _loc1_.x = _loc6_.x + _loc6_.textWidth + 10;
                  _loc4_.addChild(_loc6_);
                  _loc4_.addChild(_loc1_);
                  this._vbox.addChild(_loc4_);
               }
               _loc5_++;
            }
         }
         this._bg.height = this._vbox.height + 35;
      }
    dispose() {
         if(this._title1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title1);
         }
         this._title1 = null;
         if(this._vbox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vbox);
         }
         this._vbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__EastBlessTips, "yishi.view.tips.EastBlessTips", []);
  return __EastBlessTips;
}
deps["yishi.view.tips.EastBlessTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.gamehall.GameHallBlessInfo", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.EquipConciseTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __EquipConciseTips extends __Base {
    static $fields(self) {
    self._vBox = null;
    self._line1 = null;
    self._name = null;
    self._level = null;
    self._head = null;
    self._current = null;
    self._currentValue = null;
    self._currentCon = null;
    self._next = null;
    self._nextValue = null;
    self._nextCon = null;
    }
    constructor() {
         super();
         this._bg.width = 210;
         this._vBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._vBox.y = 13;
         this._vBox.x = 11;
         this._vBox.spacing = 5;
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._line1.width = this._bg.width - 15;
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.EquipConciseTips.Name");
         this._level = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.EquipConciseTips.Value");
         this._head = new ($.C("flash.display.Sprite"))();
         this._head.addChild(this._name);
         this._head.addChild(this._level);
         this._current = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.EquipConciseTips.Name");
         this._currentValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.EquipConciseTips.Value");
         this._currentCon = new ($.C("flash.display.Sprite"))();
         this._currentCon.addChild(this._current);
         this._currentCon.addChild(this._currentValue);
         this._next = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.EquipConciseTips.Name");
         this._nextValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.EquipConciseTips.Value");
         this._nextCon = new ($.C("flash.display.Sprite"))();
         this._nextCon.addChild(this._next);
         this._nextCon.addChild(this._nextValue);
         this.addChild(this._vBox);
         this._name.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.ConciseFrame.TitleTxt");
         this._current.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.JewelFrame.JewelCurrentEffTxt");
         this._next.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.JewelFrame.JewelNextEffTxt");
      }
    $$updateTransform() {
         var _loc2_ = 0;
         var _loc1_ = null;
         if(this.tipData)
         {
            _loc2_ = $.int(($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).conciseGrades);
            this._vBox.removeAllChild();
            this._level.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc2_);
            this._currentValue.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.ConciseFrame.EffValueTxt",$.C("yishi.utils.GoodsHelp").getConciseEffecyByGrade(_loc2_));
            _loc1_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc2_ + 1,117);
            this._name.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.ConciseFrame.TitleTxt");
            if(_loc1_)
            {
               this._nextValue.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.ConciseFrame.EffValueTxt",$.C("yishi.utils.GoodsHelp").getConciseEffecyByGrade(_loc2_ + 1));
            }
            else
            {
               this._nextValue.text = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.PawnLevelUpFrame.command03");
            }
            this._vBox.addChild(this._head);
            this._vBox.addChild(this._line1);
            this._vBox.addChild(this._currentCon);
            this._vBox.addChild(this._nextCon);
            this._vBox.refreshChildPos();
            this._bg.height = 190;
         }
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._head);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._currentCon);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._nextCon);
         if(this._vBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         }
         this._vBox = null;
         if(this._line1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         }
         this._line1 = null;
         if(this._name)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         }
         this._name = null;
         if(this._level)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._level);
         }
         this._level = null;
         if(this._head)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._head);
         }
         this._head = null;
         if(this._current)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._current);
         }
         this._current = null;
         if(this._currentValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentValue);
         }
         this._currentValue = null;
         if(this._currentCon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentCon);
         }
         this._currentCon = null;
         if(this._next)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._next);
         }
         this._next = null;
         if(this._nextValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextValue);
         }
         this._nextValue = null;
         if(this._nextCon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextCon);
         }
         this._nextCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__EquipConciseTips, "yishi.view.tips.EquipConciseTips", []);
  return __EquipConciseTips;
}
deps["yishi.view.tips.EquipConciseTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.datas.playerinfo.ThaneInfo", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.GoodsHelp", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.ExtraBufferTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ExtraBufferTips extends __Base {
    static $fields(self) {
    self._title1 = null;
    self._content1 = null;
    self._title2 = null;
    self._content2 = null;
    self._splitLine = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 245;
         this._title1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ExtraBufferTitle");
         this._content1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ExtraBufferContent");
         this._title2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ExtraBufferTitle");
         this._content2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ExtraBufferContent");
         this._splitLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.TaskTraceLine");
         this.addChild(this._title1);
         this.addChild(this._content1);
      }
    $$updateTransform() {
         var _loc1_ = 0;
         if(this.tipData)
         {
            this._title1.text = this.tipData["title1"].toString();
            this._content1.htmlText = this.tipData["content1"].toString();
            this._content1.height = this._content1.textHeight + 5;
            if(this.tipData.hasOwnProperty("title2") && Boolean(this.tipData.hasOwnProperty("content2")))
            {
               this._title2.text = this.tipData["title2"].toString();
               this._content2.htmlText = this.tipData["content2"].toString();
               this._content2.height = this._content2.textHeight + 5;
               this._splitLine.y = this._content1.y + this._content1.height + 5;
               this._title2.y = this._splitLine.y + 5;
               this._content2.y = this._title2.y + 18;
               this.addChild(this._title2);
               this.addChild(this._content2);
               this.addChild(this._splitLine);
               this._bg.height = this._content2.y + this._content2.height + 10;
               _loc1_ = this._content1.textWidth + 25;
               _loc1_ = $.int(this._content2.textWidth + 25 > _loc1_ ? this._content2.textWidth + 25 : _loc1_);
               this._bg.width = _loc1_ > 245 ? _loc1_ : 245;
            }
            else
            {
               if(this._title2.parent)
               {
                  this._title2.parent.removeChild(this._title2);
               }
               if(this._content2.parent)
               {
                  this._content2.parent.removeChild(this._content2);
               }
               if(this._splitLine.parent)
               {
                  this._splitLine.parent.removeChild(this._splitLine);
               }
               this._bg.height = this._content1.y + this._content1.height + 10;
               _loc1_ = $.int(this._content1.textWidth);
               _loc1_ = this._content1.textWidth > this._title1.textWidth ? this._content1.textWidth + 20 : this._title1.textWidth + 20;
               this._bg.width = _loc1_ > 245 ? _loc1_ : 245;
            }
            if(this._splitLine)
            {
               this._splitLine.width = this._bg.width - 3;
            }
         }
      }
    dispose() {
         if(this._title1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title1);
         }
         this._title1 = null;
         if(this._content1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._content1);
         }
         this._content1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ExtraBufferTips, "yishi.view.tips.ExtraBufferTips", []);
  return __ExtraBufferTips;
}
deps["yishi.view.tips.ExtraBufferTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.ExtralKingTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ExtralKingTips extends __Base {
    static $fields(self) {
    self._title = null;
    self._item = null;
    self._kingInfo = null;
    self._box = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._bg.width = 155;
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("kingcontract.tips.titleTxt");
         this._title.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.resourceBar.ExtraBufferTitle4");
         this._box = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.TipContain");
         this._box.y = 40;
         this.addChild(this._title);
         this.addChild(this._box);
      }
    $$updateTransform() {
         var _loc1_ = 0;
         this._box.removeAllChild();
         if($.is(this._data, "Array") && $.is(this._data[0], $.C("mvc.module.kingcontract.KingContractInfo")))
         {
            _loc1_ = 0;
            while(_loc1_ < this._data.length)
            {
               if(this._data[_loc1_].templateId != 1)
               {
                  if(this._data[_loc1_].templateId != 3)
                  {
                     if(this._data[_loc1_].templateId != 7)
                     {
                        this._kingInfo = $.as(this._data[_loc1_], $.C("mvc.module.kingcontract.KingContractInfo"));
                        this._item = new ($.C("yishi.view.tips.KingTipItem"))();
                        this._item.data = this._kingInfo;
                        this._box.addChild(this._item);
                     }
                  }
               }
               _loc1_++;
            }
            this._box.refreshChildPos();
            this._bg.height = this._box.y + this._box.height + 10;
         }
         this._bg.width = this._box.x + this._box.width + 10;
         if(this._bg.width < 160)
         {
            this._bg.width = 160;
         }
      }
    dispose() {
         this._data = null;
         if(this._title)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         }
         this._title = null;
         if(this._item)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._item);
         }
         this._item = null;
         if(this._kingInfo)
         {
            this._kingInfo = null;
         }
         if(this._box)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._box);
         }
         this._box = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ExtralKingTips, "yishi.view.tips.ExtralKingTips", []);
  return __ExtralKingTips;
}
deps["yishi.view.tips.ExtralKingTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "mvc.module.kingcontract.KingContractInfo", "yishi.view.tips.BaseTip", "yishi.view.tips.KingTipItem"];

defs["yishi.view.tips.FavourTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __FavourTip extends __Base {
    static $fields(self) {
    self._font1 = null;
    self._font2 = null;
    self._font3 = null;
    self._levelTxt = null;
    self._pcntTxt = null;
    self._teamTxt = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._font1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.favour.FontI");
         this._font1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.FavourTip.font1");
         this._font2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.favour.FontII");
         this._font2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.FavourTip.font2");
         this._font3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.favour.FontIII");
         this._font3.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.FavourTip.font3");
         this._levelTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.favour.LevelTxt");
         this._pcntTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.favour.pcntTxt");
         this._teamTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.favour.teamTxt");
         this.addChild(this._font1);
         this.addChild(this._font3);
         this._font3.y = 28;
         this.addChild(this._levelTxt);
         this.addChild(this._pcntTxt);
      }
    $$updateTransform() {
         var _loc1_ = null;
         if($.is(this._data, $.C("yishi.datas.playerinfo.ThaneInfo")))
         {
            if(this._data.friendGrade < 10)
            {
               _loc1_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByTypeAndLevelAndID(this._data.friendGrade + 1,6,0);
            }
            this._levelTxt.text = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",this._data.friendGrade);
            if(_loc1_ && this._data.friendGrade > 0)
            {
               this._pcntTxt.text = this._data.friendGp + " / " + _loc1_.Data;
            }
            else
            {
               this._pcntTxt.text = "--";
            }
            this._teamTxt.text = this._data.friendGrade + "%";
         }
         this._bg.width = 260;
         this._bg.height = 85;
      }
    dispose() {
         if(this._font1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._font1);
         }
         this._font1 = null;
         if(this._font2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._font2);
         }
         this._font2 = null;
         if(this._font3)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._font3);
         }
         this._font3 = null;
         if(this._levelTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levelTxt);
         }
         this._levelTxt = null;
         if(this._pcntTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._pcntTxt);
         }
         this._pcntTxt = null;
         if(this._teamTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._teamTxt);
         }
         this._teamTxt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__FavourTip, "yishi.view.tips.FavourTip", []);
  return __FavourTip;
}
deps["yishi.view.tips.FavourTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.playerinfo.ThaneInfo", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.FoisonHornRewardTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __FoisonHornRewardTips extends __Base {
    static $fields(self) {
    self._title = null;
    self._content = null;
    self._goodsTxt = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._bg.width = 380;
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("foisonHorn.tips.titleTxt");
         this._content = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("foisonHorn.tips.contentTxt");
         this._goodsTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("foisonHorn.tips.goodsTxt");
         this.addChild(this._title);
         this.addChild(this._content);
         this.addChild(this._goodsTxt);
         this._title.text = $.C("manager.LanguageMgr").GetTranslation("foisonHornRewardTips.titleTxt");
         this._content.text = $.C("manager.LanguageMgr").GetTranslation("foisonHornRewardTips.contentTxt");
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc4_ = null;
         var _loc1_ = null;
         var _loc3_ = 0;
         if($.is(this._data, "String"))
         {
            _loc2_ = this._data.split("|");
            _loc6_ = "";
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc1_ = _loc2_[_loc3_].split(",");
               if(_loc1_.length == 2)
               {
                  _loc5_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID($.int(_loc1_[0]));
                  if(_loc5_)
                  {
                     if(_loc6_ != "")
                     {
                        _loc6_ += "\n";
                     }
                     _loc4_ = $.C("yishi.utils.GoodsHelp").getGoodColorString(_loc5_.Profile);
                     _loc6_ += "<font color=" + _loc4_ + ">" + _loc5_.TemplateName + " *" + _loc1_[1] + "</font>";
                  }
               }
               _loc3_++;
            }
            this._goodsTxt.height = Math.max(20 * _loc2_.length,20);
            this._goodsTxt.htmlText = _loc6_;
            this._bg.height = this._goodsTxt.y + this._goodsTxt.height;
         }
      }
    dispose() {
         this._data = null;
         if(this._title)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         }
         this._title = null;
         if(this._content)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._content);
         }
         this._content = null;
         if(this._goodsTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goodsTxt);
         }
         this._goodsTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__FoisonHornRewardTips, "yishi.view.tips.FoisonHornRewardTips", []);
  return __FoisonHornRewardTips;
}
deps["yishi.view.tips.FoisonHornRewardTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.manager.TempleteManager", "yishi.utils.GoodsHelp", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.FundBuyItemTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __FundBuyItemTip extends __Base {
    static $fields(self) {
    self._vbox = null;
    self._consumeHbox = null;
    self._consumeTxt = null;
    self._consumeTxt2 = null;
    self._splitLine = null;
    self._list = null;
    self._isNewbie = false;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._list = [];
         this._vbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("fund.fundBuyItemTipVbox");
         this._consumeHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("fund.consumeHBox");
         this._consumeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("fund.consumeTxt");
         this._splitLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.TaskTraceLine");
         this._splitLine.width = 220;
         this.addChild(this._vbox);
         this._vbox.addChild(this._consumeHbox);
         this._consumeTxt2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("fund.consumeTxt");
      }
    $$updateTransform() {
         var _loc11_ = null;
         var _loc8_ = null;
         var _loc6_ = 0;
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc13_ = null;
         var _loc10_ = 0;
         var _loc5_ = null;
         var _loc7_ = 0;
         var _loc1_ = null;
         this._isNewbie = $.C("managers.FundManager").instance.isNewbie;
         this.uint();
         var _loc12_ = $.as(this.tipData, $.C("mvc.module.fund.ActiveParmaInfo"));
         var _loc3_ = this._isNewbie ? 1 : 0;
         this._consumeTxt.text = $.C("manager.LanguageMgr").GetTranslation("fund.fundBuyItemTip.consumeTxt" + _loc3_);
         this._consumeHbox.addChild(this._consumeTxt);
         if(_loc12_.costDiamond > 0)
         {
            _loc11_ = new ($.C("fund.FundItem"))();
            _loc11_.show({
               "type":"0",
               "num":_loc12_.costDiamond,
               "itemTempleteId":"-400"
            });
            this._consumeHbox.addChild(_loc11_);
            this._list.push(_loc11_);
         }
         if(_loc12_.costContract > 0)
         {
            _loc8_ = new ($.C("fund.FundItem"))();
            _loc8_.show({
               "type":"0",
               "num":_loc12_.costContract,
               "itemTempleteId":"2125044"
            });
            this._consumeHbox.addChild(_loc8_);
            this._list.push(_loc8_);
         }
         this._consumeTxt2.text = $.C("manager.LanguageMgr").GetTranslation("fund.fundBuyItemTip.consumeTxt2");
         this._consumeHbox.addChild(this._consumeTxt2);
         this._vbox.addChild(this._splitLine);
         var _loc9_ = $.int(_loc12_.harvestCount);
         _loc6_ = 0;
         while(_loc6_ < _loc9_)
         {
            _loc4_ = new ($.C("com.pickgliss.ui.controls.container.HBox"))();
            _loc4_.spacing = 5;
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("fund.dayTxt");
            _loc13_ = _loc12_.getInfos[_loc6_];
            _loc10_ = $.int(_loc13_.itemInfos.length);
            if(this._isNewbie)
            {
               _loc2_.text = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc13_.interval);
            }
            else
            {
               _loc2_.text = $.C("manager.LanguageMgr").GetTranslation("fund.fundBuyItemTip.dayTxt" + _loc6_);
            }
            _loc4_.addChild(_loc2_);
            _loc7_ = 0;
            while(_loc7_ < _loc10_)
            {
               _loc4_.x = 10;
               _loc5_ = _loc13_.itemInfos[_loc7_];
               _loc1_ = new ($.C("fund.FundItem"))();
               _loc1_.show({
                  "type":"0",
                  "num":_loc5_.count,
                  "itemTempleteId":_loc5_.templateId
               });
               this._list.push(_loc1_);
               _loc4_.addChild(_loc1_);
               _loc7_++;
            }
            this._list.push(_loc4_);
            this._vbox.addChild(_loc4_);
            _loc6_++;
         }
         this._vbox.refreshChildPos();
         this._bg.width = this._vbox.width + 20;
         this._bg.height = this._vbox.height + this._vbox.y + 4;
      }
    uint() {
         var _loc1_ = null;
         var _loc2_ = 0;
         if(this._consumeTxt2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._consumeTxt2);
         }
         _loc2_ = this._list.length - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = this._list.pop();
            if(_loc1_)
            {
               _loc1_.dispose();
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
            }
            _loc2_--;
         }
      }
    dispose() {
         this.uint();
         if(this._consumeTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._consumeTxt);
         }
         this._consumeTxt = null;
         if(this._consumeTxt2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._consumeTxt2);
         }
         this._consumeTxt2 = null;
         if(this._splitLine)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._splitLine);
         }
         this._splitLine = null;
         if(this._consumeHbox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._consumeHbox);
         }
         this._consumeHbox = null;
      }
  }
  $.meta(__FundBuyItemTip, "yishi.view.tips.FundBuyItemTip", []);
  return __FundBuyItemTip;
}
deps["yishi.view.tips.FundBuyItemTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.HBox", "com.pickgliss.utils.ObjectUtils", "fund.FundItem", "manager.LanguageMgr", "managers.FundManager", "mvc.module.fund.ActiveParmaInfo", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.GloryRoadRivalTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __GloryRoadRivalTip extends __Base {
    static $fields(self) {
    self._bmps = null;
    self._txts = null;
    self._mutiBg02 = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         var _loc3_ = 0;
         var _loc4_ = null;
         var _loc1_ = null;
         this._mutiBg02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("gloryroad.attribute.line");
         this.addChild(this._mutiBg02);
         var _loc2_ = 10;
         this._bmps = [];
         this._txts = [];
         _loc3_ = 0;
         while(_loc3_ < 12)
         {
            _loc4_ = this.addCompoentToThis("asset.gloryroad.attImg" + _loc3_,true);
            _loc4_.x = 10;
            _loc4_.y = _loc2_;
            _loc1_ = this.addCompoentToThis("gloryroad.attribute.attTxt",false);
            _loc1_.x = 110;
            _loc1_.y = _loc2_;
            _loc2_ += 20;
            if(_loc3_ == 6)
            {
               _loc2_ += 10;
            }
            _loc3_++;
         }
      }
    addCompoentToThis(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc3_ = null;
         if(param2)
         {
            _loc3_ = new ($.C("flash.display.Bitmap"))($.C("com.pickgliss.utils.ClassUtils").CreatInstance(param1));
            this._bmps.push(_loc3_);
         }
         else
         {
            _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("gloryroad.attribute.attTxt");
            this._txts.push(_loc3_);
         }
         this.addChild(_loc3_);
         return _loc3_;
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc2_ = 0;
         if(this.tipData)
         {
            _loc1_ = $.as(this.tipData, $.C("mvc.module.gloryroad.GloryRoadMirrorInfo"));
            _loc3_ = _loc1_.getAttValues();
            _loc4_ = 0;
            _loc2_ = $.int(_loc3_.length);
            while(_loc4_ < _loc2_)
            {
               $.cast($.C("com.pickgliss.ui.text.FilterFrameText"), this._txts[_loc4_]).text = _loc3_[_loc4_];
               _loc4_++;
            }
            this._bg.width = 200;
            this._bg.height = 266;
         }
      }
  }
  $.meta(__GloryRoadRivalTip, "yishi.view.tips.GloryRoadRivalTip", []);
  return __GloryRoadRivalTip;
}
deps["yishi.view.tips.GloryRoadRivalTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.text.FilterFrameText", "com.pickgliss.utils.ClassUtils", "flash.display.Bitmap", "mvc.module.gloryroad.GloryRoadMirrorInfo", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.GoddessBufferTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __GoddessBufferTip extends __Base {
    static $fields(self) {
    self._buffDesText = null;
    self._title = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._buffDesText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.goddess.buffdesTxt");
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.goddess.buffTitleTxt");
         this._bg.width = 180;
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc2_ = null;
         if(this.tipData)
         {
            _loc1_ = this.tipData.title;
            _loc2_ = this.tipData.buffTemp;
            this._title.text = _loc1_;
            this._buffDesText.htmlText = _loc2_.BufferName;
            this._buffDesText.height = this._buffDesText.numLines * 17;
            this._bg.height = this._buffDesText.y + this._buffDesText.height + 10;
            this.addChild(this._buffDesText);
            this.addChild(this._title);
         }
      }
  }
  $.meta(__GoddessBufferTip, "yishi.view.tips.GoddessBufferTip", []);
  return __GoddessBufferTip;
}
deps["yishi.view.tips.GoddessBufferTip"] = ["com.pickgliss.ui.ComponentFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.GuildFBAreaBoxTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __GuildFBAreaBoxTip extends __Base {
    static $fields(self) {
    self._desTxt = null;
    self._list = null;
    self._itemList = null;
    self.Max = 8;
    }
    constructor() {
         super();
      }
    init() {
         var _loc1_ = null;
         var _loc2_ = 0;
         super.init();
         this._bg.width = 295;
         this._desTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.guildfb.areaNodeTipTitle");
         this._list = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("ui.guildfb.areaBoxTitleList",[4]);
         this._itemList = new $.Vector();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("feedBackFrame.BaseItemView");
            this._itemList[_loc2_] = _loc1_;
            _loc2_++;
         }
         this.addChild(this._desTxt);
         this.addChild(this._list);
      }
    $$updateTransform() {
         var _loc6_ = null;
         var _loc2_ = null;
         var _loc4_ = 0;
         var _loc3_ = null;
         var _loc8_ = null;
         var _loc5_ = null;
         var _loc7_ = 0;
         var _loc1_ = $.as(this.tipData, "Array");
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildrenFromStage(this._list);
         if(_loc1_ != null)
         {
            _loc6_ = $.C("yishi.manager.TempleteManager").instance.guildFBTempCate.getOneNode(_loc1_[0],_loc1_[1]);
            if(_loc6_)
            {
               this._desTxt.text = $.C("manager.LanguageMgr").GetTranslation("guildfb.areaRewardBoxTip.Title",_loc6_.conciseName);
               _loc2_ = $.C("yishi.manager.TempleteManager").instance.guildFBDropTempCate.getTempInfos(_loc6_.AreaDropId);
               _loc4_ = $.int(_loc2_.length);
               this._list.beginChanges();
               _loc7_ = 0;
               while(_loc7_ < 8)
               {
                  _loc3_ = this._itemList[_loc7_];
                  if(_loc7_ < _loc4_)
                  {
                     _loc5_ = _loc2_[_loc7_];
                     _loc8_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
                     _loc8_.templateId = _loc5_.ItemId;
                     _loc8_.count = _loc5_.Count;
                     _loc8_.isBinds = _loc5_.IsBind;
                     _loc8_.validDate = _loc5_.ValidDate;
                     _loc3_.data = _loc8_;
                     this._list.addChild(_loc3_);
                  }
                  else
                  {
                     _loc3_.data = null;
                  }
                  _loc7_++;
               }
               this._list.commitChanges();
               this._bg.height = this._list.y + this._list.height + 15;
            }
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._desTxt);
         this._desTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._list);
         this._list = null;
         for (var _loc1_ of $.values(this._itemList))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         this._itemList = null;
         super.dispose();
      }
  }
  $.meta(__GuildFBAreaBoxTip, "yishi.view.tips.GuildFBAreaBoxTip", []);
  return __GuildFBAreaBoxTip;
}
deps["yishi.view.tips.GuildFBAreaBoxTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.goods.GoodsInfo", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.GuildFbOneBuffTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __GuildFbOneBuffTip extends __Base {
    static $fields(self) {
    self._guildfbTipTitle = null;
    self._guildfbTipContentDes = null;
    self._guildfbTipFlgDes = null;
    self._guildfbTipFlgTitle = null;
    self._guildfbBuffIcon = null;
    self._sp = null;
    self._line = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._guildfbTipTitle = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.guildfb.guildfbTipTitle");
         this._guildfbTipContentDes = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.guildfb.guildfbTipContentDes");
         this._guildfbTipFlgDes = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.guildfb.guildfbTipFlgDes");
         this._guildfbTipFlgTitle = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.guildfb.guildfbTipFlgTitle");
         this._guildfbBuffIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("ui.guildfb.guildfbBuffIcon");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._sp = new ($.C("flash.display.Sprite"))();
         this.addChild(this._guildfbTipTitle);
         this.addChild(this._guildfbTipContentDes);
         this.addChild(this._guildfbBuffIcon);
         this.addChild(this._sp);
         this._sp.addChild(this._line);
         this._sp.addChild(this._guildfbTipFlgTitle);
         this._sp.addChild(this._guildfbTipFlgDes);
         this._bg.width = 340;
      }
    $$updateTransform() {
         var _loc1_ = 0;
         var _loc2_ = null;
         if(this.tipData != null)
         {
            _loc1_ = $.int(this.tipData);
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(_loc1_);
            if(_loc2_)
            {
               this._guildfbBuffIcon.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc2_.Icons);
               this._guildfbTipTitle.text = _loc2_.TemplateName;
               this._guildfbTipContentDes.text = _loc2_.Description;
               this._guildfbTipFlgTitle.text = $.C("manager.LanguageMgr").GetTranslation("vehicle.condition");
               this._guildfbTipFlgDes.text = _loc2_.OwnRequirements;
               this._guildfbTipContentDes.height = this._guildfbTipContentDes.numLines * 20;
               this._sp.y = this._guildfbTipContentDes.y + this._guildfbTipContentDes.numLines * 20 + 2;
               this._guildfbTipFlgDes.height = this._guildfbTipFlgDes.numLines * 20;
               this._bg.height = this._sp.y + this._sp.height + 5;
            }
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._guildfbTipTitle);
         this._guildfbTipTitle = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._guildfbTipContentDes);
         this._guildfbTipContentDes = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._guildfbTipFlgDes);
         this._guildfbTipFlgDes = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._guildfbTipFlgTitle);
         this._guildfbTipFlgTitle = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._guildfbBuffIcon);
         this._guildfbBuffIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         this._line = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__GuildFbOneBuffTip, "yishi.view.tips.GuildFbOneBuffTip", []);
  return __GuildFbOneBuffTip;
}
deps["yishi.view.tips.GuildFbOneBuffTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.GuildFbPreviewBuffTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __GuildFbPreviewBuffTip extends __Base {
    static $fields(self) {
    self._hbox = null;
    self._itemList = null;
    }
    constructor() {
         super();
      }
    init() {
         this._hbox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._itemList = new $.Vector();
         this.addChild(this._hbox);
      }
    $$updateTransform() {
         var _loc3_ = 0;
         var _loc1_ = null;
         var _loc4_ = 0;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildrenFromStage(this._hbox);
         var _loc2_ = $.as(this.tipData, "Array");
         if(_loc2_ != null)
         {
            this._hbox.beginChanges();
            _loc3_ = $.int(_loc2_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(_loc4_ >= this._itemList.length)
               {
                  _loc1_ = new ($.C("yishi.view.tips.GuildFbOneBuffTip"))();
                  this._itemList.push(_loc1_);
               }
               else
               {
                  _loc1_ = this._itemList[_loc4_];
               }
               _loc1_.tipData = _loc2_[_loc4_];
               this._hbox.addChild(_loc1_);
               _loc4_++;
            }
            this._hbox.commitChanges();
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hbox);
         this._hbox = null;
         super.dispose();
         this._itemList = null;
      }
  }
  $.meta(__GuildFbPreviewBuffTip, "yishi.view.tips.GuildFbPreviewBuffTip", []);
  return __GuildFbPreviewBuffTip;
}
deps["yishi.view.tips.GuildFbPreviewBuffTip"] = ["com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "yishi.view.tips.BaseTip", "yishi.view.tips.GuildFbOneBuffTip"];

defs["yishi.view.tips.HeroGemTipItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __HeroGemTipItem extends __Base {
    static $fields(self) {
    self.notJoinImg = null;
    self.lockImg = null;
    self.gemItem = null;
    self.gemProfileImg = null;
    self.effectTxt = null;
    self.symbiotePrecent = 0;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.notJoinImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.equipGemBg");
         this.lockImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.equipHoldClosed02");
         this.gemItem = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tip.equipGemIcon");
         this.effectTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.gemAddStr");
         this.gemProfileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg02");
         this.addChild(this.notJoinImg);
         this.addChild(this.lockImg);
         this.addChild(this.gemItem);
         this.addChild(this.gemProfileImg);
         this.addChild(this.effectTxt);
      }
    setData(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc4_ = null;
         if(param1 > 0)
         {
            this.symbiotePrecent = param3;
            _loc4_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(param1);
            this.notJoinImg.visible = false;
            this.lockImg.visible = false;
            this.gemItem.visible = true;
            this.gemProfileImg.visible = true;
            this.gemProfileImg.setFrame(_loc4_.Profile);
            this.gemItem.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(param1);
            this.effectTxt.setFrame(3);
            this.effectTxt.htmlText = this.getDiscription(param1,param2);
         }
         else
         {
            this.notJoinImg.visible = true;
            this.lockImg.visible = false;
            this.effectTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.InlayItem.value02");
            this.effectTxt.setFrame(2);
            if(param1 == -1)
            {
               this.effectTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.InlayItem.value01");
               this.effectTxt.setFrame(1);
               this.lockImg.visible = true;
            }
            this.gemItem.visible = false;
            this.gemProfileImg.visible = false;
         }
         this.effectTxt.y = 9 - (this.effectTxt.numLines - 1) * 9;
      }
    getDiscription(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc7_ = 0;
         var _loc10_ = null;
         var _loc3_ = 0;
         var _loc12_ = null;
         var _loc11_ = null;
         var _loc6_ = "";
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(param1);
         var _loc9_ = _loc4_.hasValueAtt;
         var _loc5_ = $.int(_loc9_.length);
         var _loc8_ = new $.Vector();
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc10_ = _loc9_[_loc7_];
            _loc3_ = $.int(_loc4_[_loc10_]);
            _loc8_.push(_loc3_);
            _loc6_ += $.C("manager.LanguageMgr").GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc10_,"");
            _loc7_++;
         }
         if(_loc4_.SonType == 228)
         {
            _loc12_ = _loc6_.split(" ");
            _loc11_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(param1);
            switch($.int(_loc8_.length) - 2)
            {
               case 0:
                  _loc6_ = _loc12_[0] + " " + Math.floor(this.getAddDiscription(_loc11_.Property5,param2,_loc8_[0]) * this.symbiotePrecent / 100) + "\n" + _loc12_[1] + " " + Math.floor(this.getAddDiscription(_loc11_.Property6,param2,_loc8_[1]) * this.symbiotePrecent / 100);
                  break;
               default:
                  _loc6_ += Math.floor(this.getAddDiscription(param1,param2) * this.symbiotePrecent / 100);
            }
         }
         else
         {
            _loc6_ += Math.floor(this.getAddDiscription(param1,param2,_loc8_[0]) * this.symbiotePrecent / 100);
         }
         return _loc6_;
      }
    getAddDiscription(param1, param2, param3 = -1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if (typeof param3 !== "number" || (param3 | 0) !== param3) param3 = $.int(param3);
         var _loc5_ = 0;
         var _loc6_ = 0;
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(param1);
         if(param2 == this.thane.id)
         {
            _loc5_ = $.uint(param3 > 0 ? param3 : _loc4_.totalAttribute);
            _loc6_ = _loc5_ * $.C("yishi.utils.GoodsHelp").getJewelEffecyByGrade(this.thane.jewelGrades) / 100;
            if(this.thane.jewelGrades >= 80 && this.playerinfo.vocationGrades > 0)
            {
               _loc6_ = _loc5_ * $.C("yishi.utils.GoodsHelp").getSeniorJewelEffecyByGrade(this.thane.seniorStoreGrade) / 100;
            }
            if(_loc6_ > 0)
            {
               _loc6_ += $.C("yishi.utils.GoodsHelp").getConciseValue(_loc6_ + _loc5_,this.thane.conciseGrades);
            }
            return _loc5_ + _loc6_;
         }
         return 0;
      }
    get playerinfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.gemItem);
         this.gemItem = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.effectTxt);
         this.effectTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.notJoinImg);
         this.notJoinImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.lockImg);
         this.lockImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.gemProfileImg);
         this.gemProfileImg = null;
         super.dispose();
      }
    set playerinfo(v) { super.playerinfo = v; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__HeroGemTipItem, "yishi.view.tips.HeroGemTipItem", []);
  return __HeroGemTipItem;
}
deps["yishi.view.tips.HeroGemTipItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.manager.ArmyManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.GoodsHelp", "yishi.utils.IconFactory"];

defs["yishi.view.tips.HeroProfileTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __HeroProfileTip extends __Base {
    static $fields(self) {
    self._content = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 235;
         this._bg.height = 65;
         this._content = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.HerprofileTipAsset");
         this.addChild(this._content);
      }
    dispose() {
         if(this._content)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._content);
         }
         this._content = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__HeroProfileTip, "yishi.view.tips.HeroProfileTip", []);
  return __HeroProfileTip;
}
deps["yishi.view.tips.HeroProfileTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.HeroTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __HeroTip extends __Base {
    static $fields(self) {
    self._contain = null;
    self._nameText = null;
    self._levelText = null;
    self._vocationText = null;
    self._attackContain = null;
    self._attackText = null;
    self._attackTextSet = null;
    self._agilityContain = null;
    self._agilityText = null;
    self._agilityTextSet = null;
    self._spiritContain = null;
    self._spiritText = null;
    self._spiritTextSet = null;
    self._growthContain = null;
    self._growthText = null;
    self._growthTextSet = null;
    self._captainContain = null;
    self._captainText = null;
    self._captainTextSet = null;
    self._line1 = null;
    self._line2 = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 140;
         this._bg.height = 200;
         this._contain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.TipContain");
         this._nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroNameText");
         this._contain.addChild(this._nameText);
         this._levelText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroLevelText");
         this._contain.addChild(this._levelText);
         this._vocationText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroVocationText");
         this._contain.addChild(this._vocationText);
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._contain.addChild(this._line1);
         this._growthContain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._growthText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroGrowthText");
         this._growthText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.HeroTip.growth");
         this._growthTextSet = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroGrowthValueText");
         this._growthContain.addChild(this._growthText);
         this._growthContain.addChild(this._growthTextSet);
         this._contain.addChild(this._growthContain);
         this._line2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._contain.addChild(this._line2);
         this._attackContain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._attackText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroAttackText");
         this._attackText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.HeroTip.attack");
         this._attackTextSet = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroAttackValueText");
         this._attackContain.addChild(this._attackText);
         this._attackContain.addChild(this._attackTextSet);
         this._contain.addChild(this._attackContain);
         this._agilityContain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._agilityText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroAgilityText");
         this._agilityText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.HeroTip.agility");
         this._agilityTextSet = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroAgilityValueText");
         this._agilityContain.addChild(this._agilityText);
         this._agilityContain.addChild(this._agilityTextSet);
         this._contain.addChild(this._agilityContain);
         this._spiritContain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._spiritText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroAbilityText");
         this._spiritText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.HeroTip.spirit");
         this._spiritTextSet = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroAbilityValueText");
         this._spiritContain.addChild(this._spiritText);
         this._spiritContain.addChild(this._spiritTextSet);
         this._contain.addChild(this._spiritContain);
         this._captainContain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._captainText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroCaptainText");
         this._captainText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.HeroTip.captain");
         this._captainTextSet = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroCaptainValueText");
         this._captainContain.addChild(this._captainText);
         this._captainContain.addChild(this._captainTextSet);
         this._contain.addChild(this._captainContain);
         this.addChild(this._contain);
      }
    $$updateTransform() {
         if(this.tipData)
         {
            this._nameText.setFrame(1);
            this._nameText.text = ($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).nickName;
            this._levelText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.HeroTip.level") + ":" + ($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).grades;
            this._vocationText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.HeroTip.vocation") + ":" + this.getJob(this.tipData);
            this._attackTextSet.text = ($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).baseProperty.baseAgilityPoint.toString();
            this._agilityTextSet.text = ($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).baseProperty.baseAgilityPoint.toString();
            this._spiritTextSet.text = ($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).baseProperty.baseIntellectPoint.toString();
            this._growthTextSet.text = "0";
            this._captainTextSet.text = ($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).baseProperty.baseCaptainPoint.toString();
         }
      }
    getJob(param1) {
         var _loc2_ = $.int(($.as(param1, $.C("yishi.datas.playerinfo.ThaneInfo"))).templateInfo.Job);
         switch(_loc2_ - 1)
         {
            case 0:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.datas.consant.JobType.Name02");
            case 1:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.datas.consant.JobType.Name03");
            case 2:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.datas.consant.JobType.Name04");
            default:
               return "";
         }
      }
    dispose() {
         if(this._contain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contain);
         }
         this._contain = null;
         if(this._nameText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameText);
         }
         this._nameText = null;
         if(this._levelText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levelText);
         }
         this._levelText = null;
         if(this._vocationText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vocationText);
         }
         this._vocationText = null;
         if(this._attackContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._attackContain);
         }
         this._attackContain = null;
         if(this._attackText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._attackText);
         }
         this._attackText = null;
         if(this._attackTextSet)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._attackTextSet);
         }
         this._attackTextSet = null;
         if(this._agilityContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._agilityContain);
         }
         this._agilityContain = null;
         if(this._agilityText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._agilityText);
         }
         this._agilityText = null;
         if(this._agilityTextSet)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._agilityTextSet);
         }
         this._agilityTextSet = null;
         if(this._spiritContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._spiritContain);
         }
         this._spiritContain = null;
         if(this._spiritText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._spiritText);
         }
         this._spiritText = null;
         if(this._spiritTextSet)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._spiritTextSet);
         }
         this._spiritTextSet = null;
         if(this._growthContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._growthContain);
         }
         this._growthContain = null;
         if(this._growthText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._growthText);
         }
         this._growthText = null;
         if(this._growthTextSet)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._growthTextSet);
         }
         this._growthTextSet = null;
         if(this._captainContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._captainContain);
         }
         this._captainContain = null;
         if(this._captainText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._captainText);
         }
         this._captainText = null;
         if(this._captainTextSet)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._captainTextSet);
         }
         this._captainTextSet = null;
         if(this._line1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         }
         this._line1 = null;
         if(this._line2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line2);
         }
         this._line2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__HeroTip, "yishi.view.tips.HeroTip", []);
  return __HeroTip;
}
deps["yishi.view.tips.HeroTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.playerinfo.ThaneInfo", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.IntensifyTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __IntensifyTip extends __Base {
    static $fields(self) {
    self._intensifyIcon = null;
    self._goodstip1 = null;
    self._goodstip2 = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.parent && this._bg.parent.removeChild(this._bg);
         this._goodstip1 = new ($.C("yishi.view.tips.goods.EquipTip"))();
         this._goodstip2 = new ($.C("yishi.view.tips.goods.EquipTip"))();
         this._goodstip2.x = this._goodstip1.width + 80;
         this._intensifyIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         this.addChild(this._goodstip1);
         this.addChild(this._goodstip2);
         this.addChild(this._intensifyIcon);
      }
    set tipData(param1) {
         this._data = param1;
         this._goodstip1.tipData = this._data;
         var _loc2_ = $.as(this._data, $.C("yishi.datas.goods.GoodsInfo"));
         if(_loc2_)
         {
            if(_loc2_.strengthenGrade >= _loc2_.templateInfo.StrengthenMax)
            {
               this._intensifyIcon.parent && this._intensifyIcon.parent.removeChild(this._intensifyIcon);
               this._goodstip2.parent && this._goodstip2.parent.removeChild(this._goodstip2);
               return;
            }
            this._goodstip2.parent || this.addChild(this._goodstip2);
            this._intensifyIcon.parent || this.addChild(this._intensifyIcon);
            this._intensifyIcon.x = this._goodstip1.x + this._goodstip1.width - 16;
            this._intensifyIcon.y = this._goodstip1.y + (this._goodstip1.height - this._intensifyIcon.height) / 2;
            _loc2_ = this.getNextGrade(_loc2_);
            this._goodstip2.tipData = _loc2_;
            this._goodstip2.x = this._goodstip1.x + this._goodstip1.width + 29;
         }
      }
    getNextGrade(param1) {
         var _loc2_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
         $.C("com.pickgliss.utils.ObjectUtils").copyProperties(_loc2_,param1,true);
         _loc2_.strengthenGrade = param1.strengthenGrade + 1;
         _loc2_.mouldGrade = param1.mouldGrade;
         _loc2_.mouldRank = param1.mouldRank;
         _loc2_.mouldStar = param1.mouldStar;
         _loc2_.isBinds = true;
         return _loc2_;
      }
    dispose() {
         if(this._intensifyIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._intensifyIcon);
         }
         this._intensifyIcon = null;
         if(this._goodstip1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goodstip1);
         }
         this._goodstip1 = null;
         if(this._goodstip2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goodstip2);
         }
         this._goodstip2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get tipData() { return super.tipData; }
  }
  $.meta(__IntensifyTip, "yishi.view.tips.IntensifyTip", []);
  return __IntensifyTip;
}
deps["yishi.view.tips.IntensifyTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "yishi.datas.goods.GoodsInfo", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.EquipTip"];

defs["yishi.view.tips.JewelSuitTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __JewelSuitTips extends __Base {
    static $fields(self) {
    self._vBox = null;
    self._line1 = null;
    self._name = null;
    self._level = null;
    self._head = null;
    self._current = null;
    self._currentValue = null;
    self._currentCon = null;
    self._next = null;
    self._nextValue = null;
    self._nextCon = null;
    }
    constructor() {
         super();
         this._bg.width = 260;
         this._vBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._vBox.y = 13;
         this._vBox.x = 11;
         this._vBox.spacing = 5;
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._line1.width = this._bg.width - 15;
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.JewelTipName");
         this._level = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.JewelTipValue");
         this._head = new ($.C("flash.display.Sprite"))();
         this._head.addChild(this._name);
         this._head.addChild(this._level);
         this._current = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.JewelTipName");
         this._currentValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.JewelTipValue");
         this._currentValue.x = 86;
         this._currentCon = new ($.C("flash.display.Sprite"))();
         this._currentCon.addChild(this._current);
         this._currentCon.addChild(this._currentValue);
         this._next = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.JewelTipName");
         this._nextValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.JewelTipValue");
         this._nextValue.x = 86;
         this._nextCon = new ($.C("flash.display.Sprite"))();
         this._nextCon.addChild(this._next);
         this._nextCon.addChild(this._nextValue);
         this.addChild(this._vBox);
         this._name.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.JewelFrame.JewelNameTxt");
         this._level.x = this._name.x + this._name.textWidth + 5;
         this._current.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.JewelFrame.JewelCurrentEffTxt");
         this._next.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.JewelFrame.JewelNextEffTxt");
      }
    $$updateTransform() {
         var _loc2_ = 0;
         var _loc1_ = null;
         if(this.tipData)
         {
            _loc2_ = $.int(($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).jewelGrades);
            this._vBox.removeAllChild();
            this._level.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc2_);
            this._currentValue.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",$.C("yishi.utils.GoodsHelp").getJewelEffecyByGrade(_loc2_));
            _loc1_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc2_ + 1,15);
            this._name.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.JewelFrame.JewelNameTxt");
            if(($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).jewelGrades >= 80 && ($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).vocationGrades > 0)
            {
               _loc2_ = $.int(($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).seniorStoreGrade);
               this._name.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.JewelFrame.JewelTitleTxt02");
               this._level.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc2_);
               this._currentValue.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",$.C("yishi.utils.GoodsHelp").getSeniorJewelEffecyByGrade(_loc2_));
               _loc1_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc2_ + 1,104);
            }
            if(_loc1_)
            {
               if(($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).jewelGrades >= 80 && ($.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"))).vocationGrades > 0)
               {
                  this._nextValue.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",$.C("yishi.utils.GoodsHelp").getSeniorJewelEffecyByGrade(_loc2_ + 1));
               }
               else
               {
                  this._nextValue.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",$.C("yishi.utils.GoodsHelp").getJewelEffecyByGrade(_loc2_ + 1));
               }
            }
            else
            {
               _loc1_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc2_,15);
               this._nextValue.text = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.PawnLevelUpFrame.command03");
            }
            this._vBox.addChild(this._head);
            this._vBox.addChild(this._line1);
            this._vBox.addChild(this._currentCon);
            this._vBox.addChild(this._nextCon);
            this._vBox.refreshChildPos();
            this._bg.height = 100;
         }
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._head);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._currentCon);
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._nextCon);
         if(this._vBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         }
         this._vBox = null;
         if(this._line1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         }
         this._line1 = null;
         if(this._name)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         }
         this._name = null;
         if(this._level)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._level);
         }
         this._level = null;
         if(this._head)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._head);
         }
         this._head = null;
         if(this._current)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._current);
         }
         this._current = null;
         if(this._currentValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentValue);
         }
         this._currentValue = null;
         if(this._currentCon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentCon);
         }
         this._currentCon = null;
         if(this._next)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._next);
         }
         this._next = null;
         if(this._nextValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextValue);
         }
         this._nextValue = null;
         if(this._nextCon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextCon);
         }
         this._nextCon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__JewelSuitTips, "yishi.view.tips.JewelSuitTips", []);
  return __JewelSuitTips;
}
deps["yishi.view.tips.JewelSuitTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.datas.playerinfo.ThaneInfo", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.GoodsHelp", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.KingTipItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __KingTipItem extends __Base {
    static $fields(self) {
    self._describe = null;
    self._timeTxt = null;
    self._kingInfo = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._describe = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("kingcontract.tips.DiscribeTxt");
         this._timeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("kingcontract.tips.Time");
         this._describe.setFrame(1);
         this._timeTxt.setFrame(1);
         this.addChild(this._describe);
         this.addChild(this._timeTxt);
      }
    set data(param1) {
         if(this._kingInfo)
         {
            this._kingInfo.removeEventListener("change",$.bind(this, "__changeHandler"));
            this._kingInfo.removeEventListener("complete",$.bind(this, "__completeHandler"));
         }
         if(!param1)
         {
            return;
         }
         this._kingInfo = param1;
         this._describe.text = this._kingInfo.template.Name;
         this._describe.height = this._describe.textHeight + this._describe.numLines * 4;
         this._describe.width = 135;
         var _loc2_ = Number(this._kingInfo.leftTime);
         if(_loc2_ > 0)
         {
            this.__changeHandler(null);
         }
         else
         {
            this._describe.setFrame(2);
            this._timeTxt.setFrame(2);
            this.setTimeTxt($.C("manager.LanguageMgr").GetTranslation("kingcontract.view.CloseTxt"));
         }
         this._kingInfo.addEventListener("change",$.bind(this, "__changeHandler"));
         this._kingInfo.addEventListener("complete",$.bind(this, "__completeHandler"));
      }
    __changeHandler(param1) {
         var _loc2_ = "";
         if(this._kingInfo.leftTime >= 86400)
         {
            _loc2_ = $.int(this._kingInfo.leftTime / 86400) + $.C("manager.LanguageMgr").GetTranslation("public.day");
         }
         else if(this._kingInfo.leftTime >= 3600)
         {
            _loc2_ = $.int(this._kingInfo.leftTime / 3600) + $.C("manager.LanguageMgr").GetTranslation("public.time.hour");
         }
         else if(this._kingInfo.leftTime >= 60)
         {
            _loc2_ = $.int(this._kingInfo.leftTime / 60) + $.C("manager.LanguageMgr").GetTranslation("public.minute");
         }
         else
         {
            _loc2_ = this._kingInfo.leftTime + $.C("manager.LanguageMgr").GetTranslation("task.view.TaskMobilePhoneView.Text1");
         }
         this.setTimeTxt(_loc2_);
      }
    __completeHandler(param1) {
         this._describe.setFrame(2);
         this._timeTxt.setFrame(2);
         this.setTimeTxt($.C("manager.LanguageMgr").GetTranslation("kingcontract.view.CloseTxt"));
      }
    setTimeTxt(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._timeTxt.text = param1;
         this._timeTxt.x = 180 - this._timeTxt.textWidth;
         this._timeTxt.width = this._timeTxt.textWidth + 3;
      }
    dispose() {
         if(this._kingInfo)
         {
            this._kingInfo.removeEventListener("change",$.bind(this, "__changeHandler"));
            this._kingInfo.removeEventListener("complete",$.bind(this, "__completeHandler"));
            this._kingInfo = null;
         }
         if(this._timeTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeTxt);
         }
         this._timeTxt = null;
         if(this._describe)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._describe);
         }
         this._describe = null;
      }
    get data() { return super.data; }
  }
  $.meta(__KingTipItem, "yishi.view.tips.KingTipItem", ["Disposeable"]);
  return __KingTipItem;
}
deps["yishi.view.tips.KingTipItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr"];

defs["yishi.view.tips.KingTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __KingTips extends __Base {
    static $fields(self) {
    self._title = null;
    self._day = null;
    self._describe = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._bg.width = 210;
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("kingcontract.tips.titleTxt");
         this._day = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("kingcontract.tips.dayTxt");
         this._describe = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("kingcontract.tips.DiscribeTxt");
         this.addChild(this._title);
         this.addChild(this._day);
         this.addChild(this._describe);
      }
    $$updateTransform() {
         var _loc1_ = null;
         if($.is(this._data, $.C("mvc.module.kingcontract.KingContractInfo")))
         {
            _loc1_ = $.as(this._data, $.C("mvc.module.kingcontract.KingContractInfo"));
            this._title.text = _loc1_.template.Name;
            this._day.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.KingTips.Limit");
            this._day.x = this._title.x + this._title.textWidth + 5;
            this._describe.text = _loc1_.template.Description;
            this._describe.x = 10;
            this._describe.y = 40;
            this._describe.height = this._describe.textHeight + this._describe.numLines * 4;
            this._bg.height = this._describe.y + this._describe.height + 15;
         }
         this._bg.width = this._day.x + this._day.textWidth + 20;
         if(this._bg.width < 190)
         {
            this._bg.width = 190;
         }
      }
    dispose() {
         this._data = null;
         if(this._title)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         }
         this._title = null;
         if(this._day)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._day);
         }
         this._day = null;
         if(this._describe)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._describe);
         }
         this._describe = null;
         super.dispose();
      }
  }
  $.meta(__KingTips, "yishi.view.tips.KingTips", []);
  return __KingTips;
}
deps["yishi.view.tips.KingTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "mvc.module.kingcontract.KingContractInfo", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.LandUpTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __LandUpTip extends __Base {
    static $fields(self) {
    self._vBox = null;
    self._line1 = null;
    self._line2 = null;
    self._name = null;
    self._current = null;
    self._currentEffect = null;
    self._currentEffectValue = null;
    self._next = null;
    self._nextEffect = null;
    self._nextEffectValue = null;
    self._nextGrade = null;
    self._gradeContain = null;
    self._grade = null;
    self._gradeValue = null;
    self._preContain = null;
    self._preBuild = null;
    self._preBuildValue = null;
    self._resource = null;
    self._needResource = null;
    self._needResourceValue = null;
    self._needResourceValueII = null;
    self._time = null;
    self._needTime = null;
    self._timeIcon = null;
    self._needTimeValue = null;
    self._outputUpPercent = 0;
    self._timeDownPercent = 0;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 245;
         this._vBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._vBox.y = 10;
         this._vBox.spacing = 5;
         this._timeDownPercent = $.int($.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("FarmCrop_Mature_Percent").ConfigValue);
         this._outputUpPercent = $.int($.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("FarmCrop_Gains_Percent").ConfigValue);
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._line2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._line1.width = this._line2.width = this._bg.width - 15;
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildNameText");
         this._currentEffect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectText");
         this._currentEffectValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectValueText");
         this._nextEffect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectText");
         this._nextEffectValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectValueText");
         this._nextGrade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildNextGradeText");
         this._preBuild = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildText");
         this._preBuildValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildValueText");
         this._grade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildText");
         this._gradeValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildValueText");
         this._needResource = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildText");
         this._needResource.y = 4;
         this._needResourceValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildResourcesValueText");
         this._needResourceValue.autoSize = "left";
         this._needResourceValue.x = 175;
         this._needResourceValue.y = 5;
         this._needResourceValueII = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildResourcesValueText");
         this._needResourceValueII.autoSize = "left";
         this._needResourceValueII.y = 6;
         this._needTime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildText");
         this._needTimeValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildValueText");
         this._needTimeValue.x += 15;
         this._timeIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.TimeIcon");
         this._current = new ($.C("flash.display.Sprite"))();
         this._current.addChild(this._currentEffect);
         this._current.addChild(this._currentEffectValue);
         this._next = new ($.C("flash.display.Sprite"))();
         this._next.addChild(this._nextEffect);
         this._next.addChild(this._nextEffectValue);
         this._gradeContain = new ($.C("flash.display.Sprite"))();
         this._gradeContain.addChild(this._grade);
         this._gradeContain.addChild(this._gradeValue);
         this._preContain = new ($.C("flash.display.Sprite"))();
         this._preContain.addChild(this._preBuild);
         this._preContain.addChild(this._preBuildValue);
         this._resource = new ($.C("com.pickgliss.ui.core.Component"))();
         this._time = new ($.C("com.pickgliss.ui.core.Component"))();
         this._time.addChild(this._needTime);
         this._time.addChild(this._timeIcon);
         this._time.addChild(this._needTimeValue);
         this.addChild(this._vBox);
      }
    $$updateTransform() {
         var _loc1_ = null;
         if(this.tipData)
         {
            this._vBox.removeAllChild();
            _loc1_ = $.as(this.tipData, $.C("farm.data.FarmInfo"));
            this._name.text = $.C("manager.LanguageMgr").GetTranslation("farm.view.FarmBuildLayer.landLevelTip",_loc1_.landGrade);
            this._currentEffect.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.current");
            if(_loc1_.landGrade - 1 > 0)
            {
               this._currentEffectValue.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.LandUpTip.buff",(_loc1_.landGrade - 1) * this._outputUpPercent,(_loc1_.landGrade - 1) * this._timeDownPercent);
            }
            else
            {
               this._currentEffectValue.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
            }
            this._currentEffectValue.height = this._currentEffectValue.textHeight + 4;
            this._vBox.addChild(this._name);
            this._vBox.addChild(this._line1);
            this._vBox.addChild(this._current);
            if(_loc1_.landGrade >= 10)
            {
               this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.maxGrade");
               this._vBox.addChild(this._line2);
               this._vBox.addChild(this._nextGrade);
            }
            else
            {
               this.refreshNextGrade(_loc1_);
               this.refreshFarmGrade(_loc1_);
               this.refreshResource(_loc1_);
            }
            this._vBox.refreshChildPos();
            this._bg.height = this._vBox.displayHeight + 20;
         }
      }
    refreshNextGrade(param1) {
         if(param1)
         {
            this._nextEffect.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.next");
            if(param1.landGrade > 0)
            {
               this._nextEffectValue.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.LandUpTip.buff",param1.landGrade * this._outputUpPercent,param1.landGrade * this._timeDownPercent);
            }
            else
            {
               this._nextEffectValue.text = $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
            }
            this._nextEffectValue.height = this._nextEffectValue.textHeight + 4;
            this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.need");
            this._vBox.addChild(this._next);
            this._vBox.addChild(this._line2);
            this._vBox.addChild(this._nextGrade);
         }
      }
    refreshFarmGrade(param1) {
         if(param1 && param1.grade < 30)
         {
            this._grade.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.LandUpTip.farmGrade");
            this._gradeValue.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",30);
            this._gradeValue.height = this._gradeValue.textHeight + 4;
            this._gradeValue.setFrame(2);
            this._gradeValue.x = 140;
            this._vBox.addChild(this._gradeContain);
         }
      }
    refreshResource(param1) {
         var _loc2_ = 0;
         while(this._resource.numChildren > 0)
         {
            this._resource.removeChildAt(0);
         }
         this._needResource.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.needResource");
         var _loc3_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("FarmLand_Points").ConfigValue.split(",");
         if(param1.landGrade - 1 > _loc3_.length)
         {
            _loc2_ = $.int(_loc3_[_loc3_.length - 1]);
         }
         else
         {
            _loc2_ = $.int(_loc3_[param1.landGrade - 1]);
         }
         var _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.SmallPointImg");
         _loc4_.x = 157;
         _loc4_.y = 4;
         this._needResourceValue.text = _loc2_ + "  ";
         this.playerInfo.point + this.playerInfo.giftToken < _loc2_ ? this._needResourceValue.setFrame(2) : this._needResourceValue.setFrame(1);
         this._resource.addChild(this._needResource);
         this._resource.addChild(_loc4_);
         this._resource.addChild(this._needResourceValue);
         this._vBox.addChild(this._resource);
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    dispose() {
         if(this._line1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         }
         this._line1 = null;
         if(this._line2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line2);
         }
         this._line2 = null;
         if(this._name)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         }
         this._name = null;
         if(this._current)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._current);
         }
         this._current = null;
         if(this._currentEffect)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentEffect);
         }
         this._currentEffect = null;
         if(this._currentEffectValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentEffectValue);
         }
         this._currentEffectValue = null;
         if(this._next)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._next);
         }
         this._next = null;
         if(this._nextEffect)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextEffect);
         }
         this._nextEffect = null;
         if(this._nextEffectValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextEffectValue);
         }
         this._nextEffectValue = null;
         if(this._nextGrade)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextGrade);
         }
         this._nextGrade = null;
         if(this._preContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._preContain);
         }
         this._preContain = null;
         if(this._gradeContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeContain);
         }
         this._gradeContain = null;
         if(this._grade)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._grade);
         }
         this._grade = null;
         if(this._gradeValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeValue);
         }
         this._gradeValue = null;
         if(this._preBuild)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._preBuild);
         }
         this._preBuild = null;
         if(this._preBuildValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._preBuildValue);
         }
         this._preBuildValue = null;
         if(this._resource)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resource);
         }
         this._resource = null;
         if(this._needResource)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._needResource);
         }
         this._needResource = null;
         if(this._needResourceValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._needResourceValue);
         }
         this._needResourceValue = null;
         if(this._needResourceValueII)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._needResourceValueII);
         }
         this._needResourceValueII = null;
         if(this._time)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._time);
         }
         this._time = null;
         if(this._needTime)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._needTime);
         }
         this._needTime = null;
         if(this._timeIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeIcon);
         }
         this._timeIcon = null;
         if(this._needTimeValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._needTimeValue);
         }
         this._needTimeValue = null;
         if(this._vBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         }
         this._vBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set thane(v) { super.thane = v; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__LandUpTip, "yishi.view.tips.LandUpTip", []);
  return __LandUpTip;
}
deps["yishi.view.tips.LandUpTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "farm.data.FarmInfo", "flash.display.Sprite", "manager.LanguageMgr", "yishi.manager.ArmyManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.MagicCardLvUpTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __MagicCardLvUpTips extends __Base {
    static $fields(self) {
    self._nameTxt = null;
    self._lvTxt = null;
    self._skillNameTxt0 = null;
    self._line01 = null;
    self._nextLvTxt = null;
    self._skillNameTxt1 = null;
    self._lvUpNeedItemCount = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 250;
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.magiccardNameTxt");
         this._lvTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.magiccardLvTxt");
         this._skillNameTxt0 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.magiccardSkillNameTxt");
         this._line01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line01.width = 210;
         this._nextLvTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.magiccardnextLvTxt");
         this._skillNameTxt1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.magiccardSkillNameTxt");
         this._lvUpNeedItemCount = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.magiccardLvUpNeedItemTxt");
         this.addChild(this._nameTxt);
         this.addChild(this._lvTxt);
         this.addChild(this._skillNameTxt0);
         this.addChild(this._line01);
         this.addChild(this._nextLvTxt);
         this.addChild(this._skillNameTxt1);
         this.addChild(this._lvUpNeedItemCount);
      }
    clear() {
         this._nameTxt.text = "";
         this._lvTxt.text = "";
         this._skillNameTxt0.text = "";
         if(this._line01 && this.contains(this._line01))
         {
            this.removeChild(this._line01);
         }
         this._nextLvTxt.text = "";
         this._skillNameTxt1.text = "";
         this._lvUpNeedItemCount.text = "";
      }
    $$updateTransform() {
         var _loc5_ = 0;
         var _loc6_ = null;
         var _loc1_ = null;
         this.clear();
         this._nameTxt.text = $.cast($.C("mvc.module.card.MagicCardInfo"), this.tipData).templateName;
         this._lvTxt.y = this._nameTxt.y + 10;
         this._lvTxt.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",$.cast($.C("mvc.module.card.MagicCardInfo"), this.tipData).grades);
         var _loc4_ = $.C("yishi.manager.TempleteManager").instance.magicCardTemplateCate.getTempInfoByTypePosGrades($.cast($.C("mvc.module.card.MagicCardInfo"), this.tipData).types,$.cast($.C("mvc.module.card.MagicCardInfo"), this.tipData).pos,$.cast($.C("mvc.module.card.MagicCardInfo"), this.tipData).grades);
         this._skillNameTxt0.y = this._nameTxt.y + 30;
         var _loc3_ = _loc4_.SkillTempIds.split(",");
         var _loc2_ = "";
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(_loc3_[_loc5_]);
            _loc2_ += _loc6_.TemplateName;
            if(_loc5_ < _loc3_.length - 1)
            {
               _loc2_ += ",";
            }
            _loc5_++;
         }
         this._skillNameTxt0.text = _loc2_;
         if($.cast($.C("mvc.module.card.MagicCardInfo"), this.tipData).grades < $.C("yishi.manager.TempleteManager").instance.magicCardTemplateCate.maxGP)
         {
            this._line01.y = this._skillNameTxt0.y + this._skillNameTxt0.textHeight + 15;
            this._nextLvTxt.y = this._line01.y + 15;
            this._nextLvTxt.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.next");
            _loc1_ = $.C("yishi.manager.TempleteManager").instance.magicCardTemplateCate.getTempInfoByTypePosGrades($.cast($.C("mvc.module.card.MagicCardInfo"), this.tipData).types,$.cast($.C("mvc.module.card.MagicCardInfo"), this.tipData).pos,$.cast($.C("mvc.module.card.MagicCardInfo"), this.tipData).grades + 1);
            _loc3_ = _loc1_.SkillTempIds.split(",");
            _loc2_ = "";
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc6_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(_loc3_[_loc5_]);
               _loc2_ += _loc6_.TemplateName;
               if(_loc5_ < _loc3_.length - 1)
               {
                  _loc2_ += ",";
               }
               _loc5_++;
            }
            this._skillNameTxt1.y = this._nextLvTxt.y + 30;
            this._skillNameTxt1.text = _loc2_;
            this._lvUpNeedItemCount.y = this._skillNameTxt1.y + 55;
            this._lvUpNeedItemCount.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MagicCardLvUpTips._lvUpNeedItemCount",_loc1_.NeedMagicDust);
            this._lvUpNeedItemCount.setFrame(1);
            if(_loc1_.NeedMagicDust > $.C("managers.PlayerCurrencyManager").instance.currencyInfo.magicDust.amount)
            {
               this._lvUpNeedItemCount.setFrame(2);
            }
            this._bg.height = this._lvUpNeedItemCount.y + 55;
         }
         else
         {
            this._lvTxt.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",$.cast($.C("mvc.module.card.MagicCardInfo"), this.tipData).grades);
            this._bg.height = this._skillNameTxt0.y + this._skillNameTxt0.textHeight + 50;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameTxt);
         this._nameTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lvTxt);
         this._lvTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillNameTxt0);
         this._skillNameTxt0 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line01);
         this._line01 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextLvTxt);
         this._nextLvTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillNameTxt1);
         this._skillNameTxt1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lvUpNeedItemCount);
         this._lvUpNeedItemCount = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__MagicCardLvUpTips, "yishi.view.tips.MagicCardLvUpTips", []);
  return __MagicCardLvUpTips;
}
deps["yishi.view.tips.MagicCardLvUpTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.PlayerCurrencyManager", "mvc.module.card.MagicCardInfo", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.MapPhysicsTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.MultipleDictionaryTip");
  class __MapPhysicsTip extends __Base {
    static $fields(self) {
    self._titleTxtStyle = null;
    }
    constructor() {
         super();
      }
    $$updateTransform() {
         var _loc3_ = undefined;
         var _loc1_ = null;
         var _loc6_ = null;
         var _loc5_ = 0;
         var _loc2_ = null;
         var _loc4_ = null;
         if($.is(this._data, $.C("yishi.view.tips.MultipleDictionaryInfo")))
         {
            this.removeAllItem();
            _loc3_ = ($.as(this._data, $.C("yishi.view.tips.MultipleDictionaryInfo"))).data;
            for(var _loc7_ in _loc3_[0])
            {
               _loc1_ = this.getTextItem(_loc7_,this.titleTxtStyle);
               this._leftTxtList.push(_loc1_);
               this._rightTxtList.push(null);
               this._maxWidth = _loc1_.textWidth;
            }
            if(_loc3_.length > 1)
            {
               _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.tipsLineImg");
               this._leftTxtList.push(_loc6_);
               this._rightTxtList.push(null);
            }
            _loc5_ = 1;
            while(_loc5_ < _loc3_.length)
            {
               for(var _loc8_ in _loc3_[_loc5_])
               {
                  if(_loc8_.split("|")[0] == "downTime")
                  {
                     this.creatDownTime(_loc8_.split("|")[1],$.int(_loc3_[_loc5_][_loc8_]));
                  }
                  else
                  {
                     _loc2_ = this.getTextItem(_loc8_,this._leftTxtStyle);
                     this._maxLeftTxtWidth = _loc2_.textWidth > this._maxLeftTxtWidth ? _loc2_.textWidth : this._maxLeftTxtWidth;
                     this._leftTxtList.push(_loc2_);
                     _loc4_ = this.getTextItem(_loc3_[_loc5_][_loc8_],this._rightTxtStyle,false);
                     if($.is(_loc4_, $.C("com.pickgliss.ui.text.FilterFrameText")))
                     {
                        this._maxWidth = this._maxLeftTxtWidth + _loc4_.textWidth + 20 > this._maxWidth ? this._maxLeftTxtWidth + _loc4_.textWidth + 20 : this._maxWidth;
                     }
                     this._rightTxtList.push(_loc4_);
                  }
               }
               _loc5_++;
            }
            this.sortList();
         }
      }
    creatDownTime(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = this.getTextItem(param1,this._leftTxtStyle);
         this._maxLeftTxtWidth = _loc3_.textWidth > this._maxLeftTxtWidth ? _loc3_.textWidth : this._maxLeftTxtWidth;
         this._leftTxtList.push(_loc3_);
         var _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("Tips.TimeDownView");
         _loc4_.timeCount = param2;
         this._maxWidth = this._maxLeftTxtWidth + _loc4_.width + 20 > this._maxWidth ? this._maxLeftTxtWidth + _loc4_.width + 20 : this._maxWidth;
         this.addChild(_loc4_);
         this._rightTxtList.push(_loc4_);
      }
    sortList() {
         var _loc3_ = 0;
         var _loc1_ = this.dictionY;
         var _loc2_ = this.dictionX;
         _loc3_ = 0;
         while(_loc3_ < this._leftTxtList.length)
         {
            if(_loc3_ == 1)
            {
               this._leftTxtList[_loc3_].x = _loc1_ - 5;
               this._leftTxtList[_loc3_].y = _loc2_;
               _loc2_ += 10;
               this.addChild(this._leftTxtList[_loc3_]);
            }
            else
            {
               this._leftTxtList[_loc3_].x = _loc1_;
               this._leftTxtList[_loc3_].y = _loc2_;
               if(this._rightTxtList[_loc3_])
               {
                  this._rightTxtList[_loc3_].x = this._maxLeftTxtWidth + this._leftTxtList[_loc3_].x + 20;
                  this._rightTxtList[_loc3_].y = _loc2_;
               }
               _loc2_ += this._leftTxtList[_loc3_].textHeight + 10;
            }
            _loc3_++;
         }
         this._bg.width = this._maxWidth + 32;
         this._bg.height = _loc2_;
         if(this._leftTxtList[1])
         {
            this._leftTxtList[1].width = this._bg.width;
         }
      }
    set titleTxtStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._titleTxtStyle == param1)
         {
            return;
         }
         this._titleTxtStyle = param1;
      }
    get titleTxtStyle() {
         return this._titleTxtStyle;
      }
  }
  $.meta(__MapPhysicsTip, "yishi.view.tips.MapPhysicsTip", []);
  return __MapPhysicsTip;
}
deps["yishi.view.tips.MapPhysicsTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.text.FilterFrameText", "yishi.view.tips.MultipleDictionaryInfo", "yishi.view.tips.MultipleDictionaryTip"];

defs["yishi.view.tips.MapVehicleBuffTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __MapVehicleBuffTip extends __Base {
    static $fields(self) {
    self._nameSprite = null;
    self._totalBox = null;
    self._injuryTxt = null;
    self._nameTxt = null;
    self._castTime = null;
    self._coolDown = null;
    self._descTxt = null;
    self._timer = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.totalVBox");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.NameTxt1");
         this._injuryTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.NameTxt2");
         this._castTime = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._coolDown = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._descTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("DaimonSkillTip.DescTxt");
         this._nameSprite = new ($.C("flash.display.Sprite"))();
         this._bg.width = 205;
         this.addChild(this._totalBox);
      }
    $$updateTransform() {
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc1_ = null;
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__onTimerHandler"));
            this._timer = null;
         }
         this._totalBox.removeAllChild();
         super.$$updateTransform();
         if(this.tipData)
         {
            if($.is(this.tipData, $.C("yishi.datas.templates.VehicleSkillTempInfo")))
            {
               _loc4_ = $.as(this.tipData, $.C("yishi.datas.templates.VehicleSkillTempInfo"));
               this._nameTxt.text = _loc4_.TemplateName;
               this._injuryTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.DaimonSkillTip.injuryTxt" + _loc4_.InjuryEffect);
               this._castTime.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.castTime",_loc4_.CastTime / 1000);
               this._coolDown.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc4_.CoolDown / 1000);
               this._descTxt.htmlText = _loc4_.Description;
               this._nameSprite.addChild(this._nameTxt);
               this._nameSprite.addChild(this._injuryTxt);
               this._totalBox.addChild(this._nameSprite);
               if(_loc4_.InjuryEffect == 3)
               {
                  this._totalBox.addChild(this._descTxt);
               }
               else
               {
                  this._totalBox.addChild(this._castTime);
                  this._totalBox.addChild(this._coolDown);
                  this._totalBox.addChild(this._descTxt);
               }
            }
            else if($.is(this.tipData, $.C("yishi.datas.templates.VehicleSkillBuffTemplate")))
            {
               _loc2_ = $.as(this.tipData, $.C("yishi.datas.templates.VehicleSkillBuffTemplate"));
               this._nameTxt.text = _loc2_.Name;
               this._descTxt.htmlText = _loc2_.Description;
               this._totalBox.addChild(this._nameTxt);
               this._totalBox.addChild(this._descTxt);
            }
            else if($.is(this.tipData, $.C("map.campaign.data.skill.MapBuffHurtData")))
            {
               _loc3_ = $.as(this.tipData, $.C("map.campaign.data.skill.MapBuffHurtData"));
               _loc1_ = _loc3_.buffTemplate;
               this._nameTxt.text = _loc1_.Name;
               this._descTxt.htmlText = _loc1_.Description;
               this._totalBox.addChild(this._nameTxt);
               if(_loc1_.Duration != -1)
               {
                  this._castTime.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.lastTime",$.int(_loc1_.Duration / 1000));
                  this._coolDown.text = $.C("manager.LanguageMgr").GetTranslation("emailII.view.EmailItemView.leftTime",_loc3_.leftTime) + $.C("manager.LanguageMgr").GetTranslation("public.time.second");
                  this._timer = new ($.C("flash.utils.Timer"))(1000);
                  this._timer.start();
                  this._timer.addEventListener("timer",$.bind(this, "__onTimerHandler"));
                  this._totalBox.addChild(this._castTime);
                  this._totalBox.addChild(this._coolDown);
               }
               this._totalBox.addChild(this._descTxt);
            }
            this._totalBox.refreshChildPos();
            this._bg.height = this._descTxt.y + this._descTxt.textHeight + 20;
            this._bg.width = this._totalBox.width + 10;
         }
      }
    __onTimerHandler(param1) {
         var _loc2_ = null;
         if(this.tipData)
         {
            _loc2_ = this.tipData;
            if(this._coolDown)
            {
               this._coolDown.text = $.C("manager.LanguageMgr").GetTranslation("emailII.view.EmailItemView.leftTime",_loc2_.leftTime) + $.C("manager.LanguageMgr").GetTranslation("public.time.second");
            }
         }
      }
    dispose() {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener("timer",$.bind(this, "__onTimerHandler"));
            this._timer = null;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         this._nameTxt = null;
         this._descTxt = null;
         this._injuryTxt = null;
         this._nameSprite = null;
         this._castTime = null;
         this._coolDown = null;
         super.dispose();
      }
  }
  $.meta(__MapVehicleBuffTip, "yishi.view.tips.MapVehicleBuffTip", []);
  return __MapVehicleBuffTip;
}
deps["yishi.view.tips.MapVehicleBuffTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.utils.Timer", "manager.LanguageMgr", "map.campaign.data.skill.MapBuffHurtData", "yishi.datas.templates.VehicleSkillBuffTemplate", "yishi.datas.templates.VehicleSkillTempInfo", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.MarryTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __MarryTip extends __Base {
    static $fields(self) {
    self._vBox = null;
    self._purpleBg = null;
    self._itemIcon = null;
    self._profileImg = null;
    self._itemNameTxt = null;
    self._itemNameLevel = null;
    self._partnerName = null;
    self._splitLine01 = null;
    self._splitLine02 = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassVBox");
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._itemIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._splitLine01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._splitLine02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._partnerName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.MarryTip.LoverName");
         this._splitLine01.width = 220;
         this._splitLine02.width = 220;
         this.addChild(this._vBox);
         this._purpleBg.y = 0;
         this._itemIcon.x = 9;
         this._profileImg.x = 8;
      }
    $$updateTransform() {
         var _loc13_ = null;
         var _loc9_ = null;
         var _loc14_ = null;
         var _loc18_ = null;
         var _loc1_ = null;
         var _loc3_ = null;
         var _loc12_ = null;
         var _loc4_ = null;
         var _loc15_ = null;
         var _loc10_ = null;
         var _loc2_ = 0;
         var _loc16_ = 0;
         var _loc5_ = 0;
         var _loc17_ = null;
         var _loc11_ = null;
         var _loc7_ = 0;
         var _loc8_ = 0;
         var _loc6_ = 0;
         if(this.tipData)
         {
            this._vBox.y = 10;
            this._vBox.removeAllChild();
            if(this._itemNameTxt && this._itemNameTxt.parent)
            {
               this._itemNameTxt.parent.removeChild(this._itemNameTxt);
            }
            if(this._itemNameLevel && this._itemNameLevel.parent)
            {
               this._itemNameLevel.parent.removeChild(this._itemNameLevel);
            }
            _loc13_ = $.as(this.tipData, $.C("mvc.module.marry.MarryTipData"));
            _loc18_ = new ($.C("flash.utils.Dictionary"))();
            _loc1_ = [];
            _loc4_ = "";
            this._partnerName.visible = true;
            if(_loc13_.type == 1)
            {
               _loc1_ = $.C("yishi.manager.TempleteManager").instance.getTemplatesByType(36);
               _loc1_.sortOn("TemplateId",16);
               _loc2_ = $.int(_loc1_.length);
               _loc16_ = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc2_)
               {
                  if(_loc1_[_loc5_].TemplateId > $.C("managers.MarryManager").instance.model.marriageData.happyInfo.happyGp)
                  {
                     if(_loc1_[_loc5_ - 1])
                     {
                        _loc2_ = $.int(_loc1_[_loc5_ - 1].Grades);
                     }
                     _loc16_ = $.int(_loc1_[_loc5_].TemplateId);
                     break;
                  }
                  _loc5_++;
               }
               _loc17_ = $.C("yishi.manager.TempleteManager").instance.campaignBufferTemplate.getTemplateByTypeAndGrades(30,_loc2_);
               if(_loc17_ == null)
               {
                  this._vBox.refreshChildPos();
                  this._bg.width = this._vBox.displayWidth + 20;
                  this._bg.height = this._vBox.displayHeight + 20;
                  this.hidendProfileBg();
                  this.setChildIndex(this._vBox,this.numChildren - 1);
                  return;
               }
               _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               _loc9_.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MarryTip.BuffName",_loc17_.Grades);
               _loc9_.setFrame(8);
               if(!$.C("yishi.utils.StringHelper").isNullOrEmpty(_loc17_.Description))
               {
                  _loc11_ = _loc17_.Description.split("|");
                  _loc7_ = 0;
                  while(_loc7_ < _loc11_.length)
                  {
                     _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                     _loc9_.text = _loc11_[_loc7_];
                     _loc9_.setFrame(2);
                     this._vBox.addChild(_loc9_);
                     _loc7_++;
                  }
               }
               _loc17_ = $.C("yishi.manager.TempleteManager").instance.campaignBufferTemplate.getTemplateByTypeAndGrades(30,_loc2_ + 1);
               if(_loc17_ == null)
               {
                  this._vBox.refreshChildPos();
                  this._bg.width = this._vBox.displayWidth + 20;
                  this._bg.height = this._vBox.displayHeight + 20;
                  this.hidendProfileBg();
                  this.setChildIndex(this._vBox,this.numChildren - 1);
                  return;
               }
               _loc14_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.TaskTraceLine");
               this._vBox.addChild(_loc14_);
               _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               _loc9_.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MarryTip.NextGrades",_loc16_);
               _loc9_.setFrame(4);
               this._vBox.addChild(_loc9_);
               _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               _loc9_.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MarryTip.BuffName",_loc2_ + 1);
               _loc9_.setFrame(8);
               this._vBox.addChild(_loc9_);
               if(!$.C("yishi.utils.StringHelper").isNullOrEmpty(_loc17_.Description))
               {
                  _loc11_ = _loc17_.Description.split("|");
                  _loc8_ = 0;
                  while(_loc8_ < _loc11_.length)
                  {
                     _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                     _loc9_.text = _loc11_[_loc8_];
                     _loc9_.setFrame(2);
                     this._vBox.addChild(_loc9_);
                     _loc8_++;
                  }
               }
            }
            else if(_loc13_.type == 2)
            {
               this._vBox.y = 54;
               this._profileImg.setFrame(4);
               _loc3_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc13_.grades,36);
               if(_loc3_ == null)
               {
                  return;
               }
               this._itemNameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               this._itemNameTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MarryTip.RingGradesName",_loc13_.grades);
               this._itemNameTxt.setFrame(3);
               this._itemNameLevel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.marryTipNameLevel");
               this._itemNameLevel.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MarryTip.RingGradesNameLevel",_loc13_.grades);
               this._itemIcon.icon = $.C("yishi.utils.IconFactory").getMarryRingIcon(_loc13_.grades > 9 ? 9 : _loc13_.grades);
               if(_loc13_.nickNameB)
               {
                  this._partnerName.htmlText = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MarryTip.LoverName",_loc13_.nickNameB);
               }
               else
               {
                  this._partnerName.htmlText = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MarryTip.LoverNameNull");
               }
               this._itemNameLevel.y = 36;
               this._itemNameLevel.x = 106;
               this._itemNameTxt.x = 75;
               this._itemNameTxt.y = 15;
            }
            else if(_loc13_.type == 3)
            {
               _loc3_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc13_.grades,36);
               if(_loc3_ == null)
               {
                  this.hidendProfileBg();
                  this.setChildIndex(this._vBox,this.numChildren - 1);
                  return;
               }
               _loc1_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoByIds(_loc13_.skillId);
               _loc6_ = 0;
               while(_loc6_ < _loc1_.length)
               {
                  _loc12_ = $.as(_loc1_[_loc6_], $.C("yishi.datas.templates.SkillTempInfo"));
                  if(_loc12_ == null)
                  {
                     break;
                  }
                  if(_loc12_.UseWay == 1)
                  {
                     _loc4_ += $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MarryTip.SkillDecribe1",_loc12_.Description) + "\n";
                     _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                     _loc9_.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MarryTip.SkillName") + _loc12_.TemplateName + "  " + $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc12_.Grades);
                     _loc9_.setFrame(3);
                     _loc9_.setTextFormat($.C("com.pickgliss.ui.ComponentFactory").Instance.model.getSet("tips.SinglePassRewardTxt_t8"),_loc9_.length - 2,_loc9_.length);
                     this._vBox.addChild(_loc9_);
                     _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                     _loc9_.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc12_.CoolDown / 1000);
                     _loc9_.setFrame(8);
                     this._vBox.addChild(_loc9_);
                  }
                  else if(_loc12_.UseWay == 2)
                  {
                     _loc4_ += $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MarryTip.SkillDecribe2",_loc12_.Description) + "\n";
                  }
                  _loc6_++;
               }
               _loc9_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.MarryTipsDescribeText");
               _loc9_.htmlText = _loc4_;
               this._vBox.addChild(_loc9_);
               this._partnerName.visible = false;
            }
            this._vBox.refreshChildPos();
            this._bg.width = this._vBox.displayWidth + 20;
            this._bg.height = this._vBox.y + this._vBox.displayHeight + 10;
            this.hidendProfileBg();
            if(_loc13_.type == 2)
            {
               if(this._bg.width < 237)
               {
                  this._bg.width = 237;
               }
               this._itemIcon.visible = true;
               this._profileImg.visible = true;
               this._purpleBg.width = this._bg.width;
               this._purpleBg.height = this._bg.height;
               this.showProfileBg(4);
               this.addChild(this._itemNameLevel);
               this.addChild(this._itemNameTxt);
               this.addChild(this._partnerName);
            }
            this.setChildIndex(this._vBox,this.numChildren - 1);
         }
      }
    hidendProfileBg() {
         this._bg.visible = true;
         if(this._purpleBg.parent)
         {
            this.removeChild(this._purpleBg);
         }
         if(this._itemIcon.parent)
         {
            this.removeChild(this._itemIcon);
         }
         if(this._profileImg.parent)
         {
            this.removeChild(this._profileImg);
         }
      }
    showProfileBg(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._bg.visible = false;
         this.addChild(this._purpleBg);
         this.addChild(this._itemIcon);
         this.addChild(this._profileImg);
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get info() {
         return $.C("managers.MarryManager").instance.model.selfMarryInfo;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         this._vBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
    set thane(v) { super.thane = v; }
    set info(v) { super.info = v; }
  }
  $.meta(__MarryTip, "yishi.view.tips.MarryTip", []);
  return __MarryTip;
}
deps["yishi.view.tips.MarryTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.utils.Dictionary", "manager.LanguageMgr", "managers.MarryManager", "mvc.module.marry.MarryTipData", "yishi.datas.templates.SkillTempInfo", "yishi.manager.ArmyManager", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.utils.StringHelper", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.MazeFloorTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __MazeFloorTips extends __Base {
    static $fields(self) {
    self._title = null;
    self._totalVBox = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 240;
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.MazeFloorTipTitleText");
         this._title.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.MazeFloorTips.title");
         this._totalVBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.StarsTotalBox");
         this._totalVBox.width = this._bg.width;
         this._totalVBox.y = this._title.y + this._title.height + 5;
         this.addChild(this._title);
         this.addChild(this._totalVBox);
      }
    $$updateTransform() {
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc1_ = null;
         if(this.tipData)
         {
            this.clean();
            _loc3_ = $.as(this.tipData, "Array");
            for (var _loc2_ of $.values(_loc3_))
            {
               _loc4_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID($.int(_loc2_));
               if(_loc4_)
               {
                  _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.MazeFloorTipGoodText");
                  _loc1_.text = _loc4_.TemplateName;
                  _loc1_.setFrame(_loc4_.Profile);
                  this._totalVBox.addChild(_loc1_);
               }
            }
            this._bg.height = this._totalVBox.y + this._totalVBox.height + 10;
            this._bg.width = this._totalVBox.x + this._totalVBox.width + 10;
         }
      }
    clean() {
         var _loc1_ = null;
         while(this._totalVBox.numChildren > 0)
         {
            _loc1_ = this._totalVBox.getChildAt(0);
            this._totalVBox.removeChild(_loc1_);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
      }
    dispose() {
         if(this._title)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         }
         this._title = null;
         if(this._totalVBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._totalVBox);
         }
         this._totalVBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__MazeFloorTips, "yishi.view.tips.MazeFloorTips", []);
  return __MazeFloorTips;
}
deps["yishi.view.tips.MazeFloorTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.MountTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __MountTip extends __Base {
    static $fields(self) {
    self._txt01 = null;
    self._txt02 = null;
    self._txt03 = null;
    self._txt04 = null;
    self._txt05 = null;
    self._txt06 = null;
    self._scoreTxt = null;
    self._lvlText = null;
    self._areaType = null;
    self._txtNoOpen = null;
    self._starBar = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._txt01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxt01");
         this._txt02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxt02");
         this._txt03 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxt03");
         this._txt04 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxtNeed");
         this._txt05 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxt04");
         this._txt06 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxt06");
         this._scoreTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxtNeed");
         this._txtNoOpen = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxt05");
         this._lvlText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.curlvlText");
         this._areaType = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.areaType");
         this._starBar = new ($.C("yishi.view.base.StarBar"))();
         this._starBar.x = this._txt01.x;
         this._lvlText.x = this._txt01.x;
         this._areaType.y = this._txt01.y;
         this.addChild(this._txt01);
         this.addChild(this._starBar);
         this.addChild(this._lvlText);
         this.addChild(this._txt02);
         this.addChild(this._txt03);
         this.addChild(this._txt04);
         this.addChild(this._scoreTxt);
         this.addChild(this._txt05);
         this.addChild(this._txt06);
         this.addChild(this._txtNoOpen);
         this.addChild(this._areaType);
      }
    $$updateTransform() {
         var _loc23_ = null;
         var _loc2_ = null;
         var _loc9_ = null;
         var _loc7_ = null;
         var _loc20_ = null;
         var _loc5_ = null;
         var _loc4_ = null;
         var _loc21_ = null;
         var _loc13_ = 0;
         var _loc18_ = null;
         var _loc10_ = null;
         var _loc24_ = 0;
         var _loc16_ = 0;
         var _loc3_ = 0;
         var _loc11_ = 0;
         var _loc1_ = 0;
         var _loc6_ = 0;
         var _loc17_ = 0;
         var _loc14_ = 0;
         var _loc15_ = 0;
         var _loc8_ = 0;
         var _loc19_ = null;
         var _loc22_ = null;
         var _loc12_ = null;
         this._txt01.htmlText = "";
         this._txt02.htmlText = "";
         this._txt03.htmlText = "";
         this._txt04.htmlText = "";
         this._txt05.htmlText = "";
         this._txt06.htmlText = "";
         this._txtNoOpen.htmlText = "";
         this._scoreTxt.htmlText = "";
         this._starBar.visible = false;
         this._lvlText.visible = false;
         this._areaType.setFrame(1);
         if(this.tipData)
         {
            if($.is(this.tipData, "String"))
            {
               this._txtNoOpen.text = $.as(this.tipData, "String");
               this._bg.height = 40;
               this._bg.width = 195;
            }
            if($.is(this.tipData, $.C("yishi.datas.templates.MountTemplate")))
            {
               _loc23_ = $.as(this.tipData, $.C("yishi.datas.templates.MountTemplate"));
               _loc2_ = $.C("managers.MountsManager").instance.avatarList.getWildSoulInfo(_loc23_.TemplateId);
               _loc9_ = $.C("managers.MountsManager").instance.avatarList.getMountKingInfo(_loc23_.TemplateId);
               _loc7_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
               _loc20_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName("mount_king_level_add_property");
               _loc5_ = _loc20_.ConfigValue.split(",");
               if($.C("managers.MountsManager").instance.canShowStar(_loc23_.TemplateId))
               {
                  this._starBar.visible = true;
                  this._starBar.count = _loc23_.maxStarGrade;
                  this._starBar.progress = _loc2_.star;
               }
               _loc4_ = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips01").split("|");
               _loc21_ = "";
               _loc13_ = $.int(_loc23_.Speed);
               _loc18_ = [0,0,0,0];
               _loc10_ = [_loc23_.Power,_loc23_.Intellect,_loc23_.Physique,_loc23_.Agility,_loc23_.ExpandLevel,_loc13_];
               if(_loc2_ && _loc23_.MountType != 4 && _loc2_.star > 0)
               {
                  _loc24_ = parseInt(_loc23_.starAddList[_loc2_.star - 1]);
                  _loc18_ = [_loc24_,_loc24_,_loc24_,_loc24_];
               }
               else if(_loc23_.MountType == 4 && _loc9_)
               {
                  this._lvlText.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc9_.grade);
                  this._lvlText.visible = true;
                  _loc16_ = _loc23_.Power + _loc9_.grade * parseInt(_loc5_[0]);
                  _loc3_ = _loc23_.Intellect + _loc9_.grade * parseInt(_loc5_[1]);
                  _loc11_ = _loc23_.Physique + _loc9_.grade * parseInt(_loc5_[2]);
                  _loc1_ = _loc23_.Agility + _loc9_.grade * parseInt(_loc5_[3]);
                  _loc6_ = _loc16_ * _loc9_.extraStar * 0.01;
                  _loc17_ = _loc3_ * _loc9_.extraStar * 0.01;
                  _loc14_ = _loc11_ * _loc9_.extraStar * 0.01;
                  _loc15_ = _loc1_ * _loc9_.extraStar * 0.01;
                  _loc18_ = [_loc6_,_loc17_,_loc14_,_loc15_];
                  _loc10_ = [_loc16_,_loc3_,_loc11_,_loc1_,_loc23_.ExpandLevel,_loc13_];
               }
               if(_loc4_.length >= _loc10_.length)
               {
                  _loc8_ = 0;
                  while(_loc8_ < _loc10_.length)
                  {
                     if(_loc8_ < 4)
                     {
                        if(!(_loc10_[_loc8_] == 0 && _loc18_[_loc8_] == 0))
                        {
                           _loc21_ += $.C("yishi.utils.StringHelper").format(_loc4_[_loc8_],_loc10_[_loc8_]);
                           if(_loc18_[_loc8_] != 0)
                           {
                              _loc21_ += " +" + _loc18_[_loc8_] + "<br/>";
                           }
                           else
                           {
                              _loc21_ += "<br/>";
                           }
                        }
                     }
                     else if(_loc10_[_loc8_] != 0)
                     {
                        _loc21_ += $.C("yishi.utils.StringHelper").format(_loc4_[_loc8_],_loc10_[_loc8_]) + "<br/>";
                     }
                     _loc8_++;
                  }
               }
               this._scoreTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("mountTip.soulscore",_loc23_.SoulScore);
               this._areaType.setFrame(_loc23_.Area + 1);
               if(_loc23_.MountType == 0)
               {
                  if(_loc2_)
                  {
                     this._txt01.htmlText = _loc23_.TemplateName;
                     this._txt02.htmlText = _loc21_;
                     this._txt03.htmlText = _loc23_.Description;
                     if(this._starBar.visible)
                     {
                        this._starBar.y = this._txt01.y + this._txt01.textHeight + 5;
                        this._txt02.y = this._txt01.y + this._txt01.textHeight + 32;
                     }
                     else if(this._lvlText.visible)
                     {
                        this._lvlText.y = this._txt01.y + this._txt01.textHeight + 8;
                        this._txt02.y = this._txt01.y + this._txt01.textHeight + 32;
                     }
                     else
                     {
                        this._txt02.y = this._txt01.y + this._txt01.textHeight + 10;
                     }
                     if(this._txt02.textHeight == 0)
                     {
                        this._scoreTxt.y = this._txt02.y;
                     }
                     else
                     {
                        this._scoreTxt.y = this._txt02.y + this._txt02.textHeight + 10;
                     }
                     if(this._scoreTxt.textHeight == 0)
                     {
                        this._txt03.y = this._scoreTxt.y;
                     }
                     else
                     {
                        this._txt03.y = this._scoreTxt.y + this._scoreTxt.textHeight + 10;
                     }
                     if(this._txt03.textHeight == 0)
                     {
                        this._txt06.y = this._txt03.y;
                     }
                     else
                     {
                        this._txt06.y = this._txt03.y + this._txt03.textHeight + 10;
                     }
                     if(this.isFlying(_loc23_.TemplateId))
                     {
                        this._txt06.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips06");
                     }
                     else
                     {
                        this._txt06.htmlText = "";
                     }
                     if(this._scoreTxt.textHeight == 0 && this._txt03.textHeight == 0 && this._txt06.textHeight == 0)
                     {
                        this._bg.height = this._txt06.y + this._txt06.textHeight + 5;
                     }
                     else
                     {
                        this._bg.height = this._txt06.y + this._txt06.textHeight + 15;
                     }
                  }
                  else
                  {
                     this._txtNoOpen.text = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips03",_loc23_.Property2);
                     this._scoreTxt.htmlText = "";
                     this._bg.height = 40;
                  }
               }
               else
               {
                  this._txt01.htmlText = _loc23_.TemplateName;
                  this._txt02.htmlText = _loc21_;
                  this._txt03.htmlText = _loc23_.Description;
                  _loc19_ = [];
                  if(_loc23_.NeedMountGrade > 0)
                  {
                     _loc19_.push($.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips.NeedGrade",_loc23_.NeedMountGrade));
                  }
                  if(_loc23_.NeedItemId != 0)
                  {
                     _loc22_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc23_.NeedItemId);
                     if(_loc22_)
                     {
                        _loc19_.push(_loc22_.TemplateName);
                     }
                  }
                  if(_loc23_.MountType == 3)
                  {
                     if($.C("yishi.manager.ArmyManager").instance.thane.IsVipAndNoExpirt)
                     {
                        this._txt04.htmlText = "";
                        this._txt05.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.VIPMountsTips");
                     }
                     else
                     {
                        this._txt04.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.VIPMountsNeedTips");
                        this._txt05.htmlText = "";
                     }
                  }
                  else
                  {
                     if(_loc2_ == null && _loc19_.length > 0)
                     {
                        _loc12_ = _loc19_.join("\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                        this._txt04.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.MountTip.NeedGood",_loc12_);
                     }
                     if(_loc2_ && _loc2_.validity != 0)
                     {
                        if(_loc2_.validity < 0)
                        {
                           this._txt05.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.forever");
                        }
                        else
                        {
                           this._txt05.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips02",_loc2_.validity);
                        }
                     }
                     else
                     {
                        this._txt05.htmlText = "";
                     }
                  }
                  if(this.isFlying(_loc23_.TemplateId))
                  {
                     this._txt06.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips06");
                  }
                  else
                  {
                     this._txt06.htmlText = "";
                  }
                  if(this._starBar.visible)
                  {
                     this._starBar.y = this._txt01.y + this._txt01.textHeight + 5;
                     this._txt02.y = this._txt01.y + this._txt01.textHeight + 32;
                  }
                  else if(this._lvlText.visible)
                  {
                     this._lvlText.y = this._txt01.y + this._txt01.textHeight + 8;
                     this._txt02.y = this._txt01.y + this._txt01.textHeight + 32;
                  }
                  else
                  {
                     this._txt02.y = this._txt01.y + this._txt01.textHeight + 10;
                  }
                  if(this._txt02.textHeight == 0)
                  {
                     this._scoreTxt.y = this._txt02.y;
                  }
                  else
                  {
                     this._scoreTxt.y = this._txt02.y + this._txt02.textHeight + 10;
                  }
                  if(this._scoreTxt.textHeight == 0)
                  {
                     this._txt03.y = this._scoreTxt.y;
                  }
                  else
                  {
                     this._txt03.y = this._scoreTxt.y + this._scoreTxt.textHeight + 10;
                  }
                  if(this._txt03.textHeight == 0)
                  {
                     this._txt04.y = this._txt03.y;
                  }
                  else
                  {
                     this._txt04.y = this._txt03.y + this._txt03.textHeight + 10;
                  }
                  if(this._txt04.textHeight == 0)
                  {
                     this._txt05.y = this._txt04.y;
                  }
                  else
                  {
                     this._txt05.y = this._txt04.y + this._txt04.textHeight + 10;
                  }
                  if(this._txt05.textHeight == 0)
                  {
                     this._txt06.y = this._txt05.y;
                  }
                  else
                  {
                     this._txt06.y = this._txt05.y + this._txt05.textHeight + 10;
                  }
                  if(this._txt06.textHeight == 0)
                  {
                     this._bg.height = this._txt06.y + 5;
                  }
                  else
                  {
                     this._bg.height = this._txt06.y + this._txt06.textHeight + 15;
                  }
               }
               this._bg.width = Math.max(205,this._txt01.textWidth + 50);
            }
            this._areaType.x = this._bg.width - 30;
         }
      }
    isFlying(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.mountTemplateDic[param1];
         if(_loc2_ && (_loc2_.IsFly == 1 || Boolean(_loc2_.isBuyFly)))
         {
            return true;
         }
         return false;
      }
    get height() {
         return this._bg.height;
      }
    dispose() {
         this._txt01 = null;
         this._txt02 = null;
         this._txt03 = null;
         this._txt04 = null;
         this._txt05 = null;
         this._txt06 = null;
         this._scoreTxt = null;
         this._areaType = null;
         this._lvlText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
    set height(v) { super.height = v; }
  }
  $.meta(__MountTip, "yishi.view.tips.MountTip", []);
  return __MountTip;
}
deps["yishi.view.tips.MountTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.MountsManager", "yishi.datas.templates.MountTemplate", "yishi.manager.ArmyManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.StringHelper", "yishi.view.base.StarBar", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.MultipleDictionaryTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __MultipleDictionaryTip extends __Base {
    static $fields(self) {
    self._maxLeftTxtWidth = 0;
    self._maxWidth = 200;
    self._dictionX = 8;
    self._dictionY = 5;
    self._enableHtml = false;
    self._leftTxtStyle = null;
    self._rightTxtStyle = null;
    self._leftTxtList = null;
    self._rightTxtList = null;
    self._tempLeftTxtList = null;
    self._tempRightTxtList = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._leftTxtList = [];
         this._rightTxtList = [];
         this._tempLeftTxtList = [];
         this._tempRightTxtList = [];
      }
    $$updateTransform() {
         var _loc2_ = undefined;
         var _loc4_ = NaN;
         var _loc5_ = 0;
         var _loc1_ = null;
         var _loc3_ = null;
         if($.is(this._data, $.C("yishi.view.tips.MultipleDictionaryInfo")))
         {
            this.removeAllItem();
            _loc2_ = ($.as(this._data, $.C("yishi.view.tips.MultipleDictionaryInfo"))).data;
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               for(var _loc6_ in _loc2_[_loc5_])
               {
                  _loc1_ = this.getTextItem(_loc6_,this._leftTxtStyle);
                  this._maxLeftTxtWidth = _loc1_.textWidth > this._maxLeftTxtWidth ? _loc1_.textWidth : this._maxLeftTxtWidth;
                  this._leftTxtList.push(_loc1_);
                  _loc3_ = this.getTextItem(_loc2_[_loc5_][_loc6_],this._rightTxtStyle,false);
                  if(_loc3_)
                  {
                     _loc4_ = Number(_loc3_.textWidth > _loc4_ ? _loc3_.textWidth : _loc4_);
                  }
                  this._rightTxtList.push(_loc3_);
               }
               _loc5_++;
            }
            this._maxWidth = this._maxWidth > this._maxLeftTxtWidth + _loc4_ ? this._maxWidth : this._maxLeftTxtWidth + _loc4_;
            this.sortList();
         }
      }
    removeAllItem() {
         this.removeListByArray(this._leftTxtList,this._tempLeftTxtList);
         this.removeListByArray(this._rightTxtList,this._tempRightTxtList);
      }
    removeListByArray(param1, param2) {
         var _loc3_ = null;
         while(param1.length > 0)
         {
            _loc3_ = param1.pop();
            if($.is(_loc3_, $.C("com.pickgliss.ui.text.FilterFrameText")))
            {
               param2.push(_loc3_);
               if(_loc3_.parent)
               {
                  _loc3_.parent.removeChild(_loc3_);
               }
            }
            else
            {
               $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc3_);
               _loc3_ = null;
            }
         }
      }
    getTextItem(param1, param2, param3 = true) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc4_ = null;
         if(param1 == null)
         {
            return null;
         }
         if(param3)
         {
            _loc4_ = this._tempLeftTxtList.pop();
         }
         else
         {
            _loc4_ = this._tempRightTxtList.pop();
         }
         if(!_loc4_)
         {
            _loc4_ = this.createTxt(param2);
         }
         this._enableHtml ? (_loc4_.htmlText = param1) : (_loc4_.text = param1);
         this.addChild(_loc4_);
         return _loc4_;
      }
    sortList() {
         var _loc3_ = 0;
         var _loc1_ = this.dictionY;
         var _loc2_ = this.dictionX;
         _loc3_ = 0;
         while(_loc3_ < this._leftTxtList.length)
         {
            this._leftTxtList[_loc3_].x = _loc1_;
            this._leftTxtList[_loc3_].y = _loc2_;
            if(this._rightTxtList[_loc3_])
            {
               this._rightTxtList[_loc3_].x = this._maxLeftTxtWidth + this._leftTxtList[_loc3_].x;
               this._rightTxtList[_loc3_].y = _loc2_;
            }
            _loc2_ += this._leftTxtList[_loc3_].textHeight + 5;
            _loc3_++;
         }
         this._bg.width = this._maxWidth + 16;
         this._bg.height = _loc2_ + 8;
      }
    clear() {
         this.clearTxtList(this._leftTxtList);
         this.clearTxtList(this._rightTxtList);
         this.clearTxtList(this._tempLeftTxtList);
         this.clearTxtList(this._tempRightTxtList);
      }
    clearTxtList(param1) {
         for (var _loc2_ of $.values(param1))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc2_);
         }
         param1.splice(0,param1.length);
      }
    createTxt(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(param1);
      }
    get enableHtml() {
         return this._enableHtml;
      }
    set enableHtml(param1) {
         if(this._enableHtml == param1)
         {
            return;
         }
         this._enableHtml = param1;
      }
    get leftTxtStyle() {
         return this._leftTxtStyle;
      }
    set leftTxtStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._leftTxtStyle == param1)
         {
            return;
         }
         this._leftTxtStyle = param1;
      }
    get rightTxtStyle() {
         return this._rightTxtStyle;
      }
    set rightTxtStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._rightTxtStyle == param1)
         {
            return;
         }
         this._rightTxtStyle = param1;
      }
    get dictionX() {
         return this._dictionX;
      }
    set dictionX(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if(this._dictionX == param1)
         {
            return;
         }
         this._dictionX = param1;
      }
    get dictionY() {
         return this._dictionY;
      }
    set dictionY(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         if(this._dictionY == param1)
         {
            return;
         }
         this._dictionY = param1;
      }
    dispose() {
         this.clear();
         this._leftTxtList = this._leftTxtList = this._tempLeftTxtList = this._tempRightTxtList = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__MultipleDictionaryTip, "yishi.view.tips.MultipleDictionaryTip", []);
  return __MultipleDictionaryTip;
}
deps["yishi.view.tips.MultipleDictionaryTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.text.FilterFrameText", "com.pickgliss.utils.ObjectUtils", "yishi.view.tips.BaseTip", "yishi.view.tips.MultipleDictionaryInfo"];

defs["yishi.view.tips.MultipleGoodsTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __MultipleGoodsTip extends __Base {
    static $fields(self) {
    self._vbox = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._vbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.MultipleGoodsTips.vbox");
         this.addChild(this._vbox);
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc4_ = 0;
         var _loc7_ = 0;
         var _loc3_ = null;
         var _loc6_ = 0;
         var _loc5_ = 0;
         var _loc8_ = null;
         var _loc2_ = null;
         if($.is(this.tipData, "Array"))
         {
            this._vbox.disposeAllChildren();
            _loc1_ = $.as(this.tipData, "Array");
            _loc4_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc1_.length)
            {
               _loc3_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(($.as(_loc1_[_loc7_], $.C("yishi.datas.templates.BoxItemTemplate"))).TemplateId);
               _loc6_ = $.int(($.as(_loc1_[_loc7_], $.C("yishi.datas.templates.BoxItemTemplate"))).Count);
               _loc5_ = $.int(_loc3_.Profile);
               _loc8_ = _loc3_.TemplateName;
               _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.MultipleGoodsTips.txt");
               this._vbox.addChild(_loc2_);
               _loc2_.text = _loc8_ + "×" + _loc6_;
               _loc2_.setFrame(_loc5_);
               if(_loc2_.textWidth > _loc4_)
               {
                  _loc4_ = $.int(_loc2_.textWidth);
               }
               _loc7_++;
            }
            this._bg.width = this._vbox.x + _loc4_ + 20;
            this._bg.height = this._vbox.y + this._vbox.height + 20;
         }
      }
    dispose() {
         while(this._vbox.numChildren)
         {
            this._vbox.removeChildAt(this._vbox.numChildren - 1);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vbox.getChildAt(this._vbox.numChildren - 1));
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vbox);
         this._vbox = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__MultipleGoodsTip, "yishi.view.tips.MultipleGoodsTip", []);
  return __MultipleGoodsTip;
}
deps["yishi.view.tips.MultipleGoodsTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "yishi.datas.templates.BoxItemTemplate", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.MultipleLineTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.OneLineTip");
  class __MultipleLineTip extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
         this._contentTxt.wordWrap = true;
         this._contentTxt.multiline = true;
      }
    set contentWidth(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         this._contentTxt.width = param1;
      }
    $$updateTransform() {
         if(this._enableHtml)
         {
            this._contentTxt.htmlText = $.C("yishi.utils.StringHelper").trim(String(this._data));
         }
         else
         {
            this._contentTxt.text = $.C("yishi.utils.StringHelper").trim(String(this._data));
         }
         if(this._tipWidth > 0 && this._contentTxt.textWidth > this._tipWidth - 20)
         {
            this._contentTxt.width = this._tipWidth - 16;
         }
         this._bg.width = this._contentTxt.textWidth + 20;
         this._bg.height = this._contentTxt.height + 8;
         this._contentTxt.x = this._bg.x + 8;
         this._contentTxt.y = this._bg.y + 4;
      }
    get contentWidth() { return super.contentWidth; }
  }
  $.meta(__MultipleLineTip, "yishi.view.tips.MultipleLineTip", []);
  return __MultipleLineTip;
}
deps["yishi.view.tips.MultipleLineTip"] = ["yishi.utils.StringHelper", "yishi.view.tips.OneLineTip"];

defs["yishi.view.tips.OutyardAreaEventTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __OutyardAreaEventTips extends __Base {
    static $fields(self) {
    self.titleText = null;
    self.descText = null;
    self.eventTempInfo = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.titleText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PlanesEventTips.titleText");
         this.descText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PlanesEventTips.descText");
         this.addChild(this.titleText);
         this.addChild(this.descText);
      }
    $$updateTransform() {
         this.cleanData();
         if(this._data)
         {
            this.eventTempInfo = $.as(this._data.template, $.C("yishi.datas.templates.OutyardAreaTemplateInfo"));
            this.titleText.text = this.eventTempInfo.Name;
            this.descText.text = this.eventTempInfo.Description;
            this.descText.y = this.titleText.y + this.titleText.textHeight + 5;
         }
         this.descText.height = this.descText.textHeight + 3;
         this._bg.width = 200;
         this._bg.height = this.titleText.y + this.titleText.textHeight + this.descText.textHeight + 20;
      }
    cleanData() {
         this.titleText.text = "";
         this.descText.text = "";
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.titleText);
         this.titleText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.descText);
         this.descText = null;
         this.eventTempInfo = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__OutyardAreaEventTips, "yishi.view.tips.OutyardAreaEventTips", []);
  return __OutyardAreaEventTips;
}
deps["yishi.view.tips.OutyardAreaEventTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "yishi.datas.templates.OutyardAreaTemplateInfo", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.PVPLeagueRewardTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PVPLeagueRewardTips extends __Base {
    static $fields(self) {
    self._titleImg = null;
    self._groupImg1 = null;
    self._groupImg2 = null;
    self._groupImg3 = null;
    self._groupImg4 = null;
    self._txt01 = null;
    self._txt02 = null;
    self._txt03 = null;
    self._txt04 = null;
    self._txt05 = null;
    self._txt06 = null;
    self._txt07 = null;
    self._txt08 = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._titleImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.LeagueTitle");
         this._groupImg1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.LeagueGroup1");
         this._groupImg2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.LeagueGroup2");
         this._groupImg3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.LeagueGroup3");
         this._groupImg4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.LeagueGroup4");
         this._txt01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.LeagueRewardTxt01");
         this._txt02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.LeagueRewardTxt02");
         this._txt03 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.LeagueRewardTxt03");
         this._txt04 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.LeagueRewardTxt04");
         this._txt05 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.LeagueRewardTxt05");
         this._txt06 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.LeagueRewardTxt06");
         this._txt07 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.LeagueRewardTxt07");
         this._txt08 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.LeagueRewardTxt08");
         this.addChild(this._titleImg);
         this.addChild(this._groupImg1);
         this.addChild(this._groupImg2);
         this.addChild(this._groupImg3);
         this.addChild(this._groupImg4);
         this.addChild(this._txt01);
         this.addChild(this._txt02);
         this.addChild(this._txt03);
         this.addChild(this._txt04);
         this.addChild(this._txt05);
         this.addChild(this._txt06);
         this.addChild(this._txt07);
         this.addChild(this._txt08);
         this._txt01.text = "2000";
         this._txt02.text = "1500";
         this._txt03.text = "1200";
         this._txt04.text = "900";
         this._txt05.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.PVPLeagueRewardTips.Txt01");
         this._txt06.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.PVPLeagueRewardTips.Txt01");
         this._txt07.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.PVPLeagueRewardTips.Txt01");
         this._txt08.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.PVPLeagueRewardTips.Txt01");
         this._bg.width = 310;
         this._bg.height = 110;
      }
    $$updateTransform() {
         if(!this.tipData)
         {
         }
      }
    dispose() {
         this._txt01 = null;
         this._txt02 = null;
         this._txt03 = null;
         this._txt04 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
  }
  $.meta(__PVPLeagueRewardTips, "yishi.view.tips.PVPLeagueRewardTips", []);
  return __PVPLeagueRewardTips;
}
deps["yishi.view.tips.PVPLeagueRewardTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.PawnSpecialTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PawnSpecialTips extends __Base {
    static $fields(self) {
    self._name = null;
    self._describe = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 250;
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.PawnSpecialName");
         this._describe = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.PawnSpecialDesc");
         this.addChild(this._name);
         this.addChild(this._describe);
      }
    $$updateTransform() {
         if(this.tipData)
         {
            this._name.htmlText = ($.as(this.tipData, $.C("yishi.datas.templates.PawnSpecialTempInfo"))).TemplateName + " <font color=\'#ffffff\'>" + $.C("manager.LanguageMgr").GetTranslation("public.level2",($.as(this.tipData, $.C("yishi.datas.templates.PawnSpecialTempInfo"))).Grades) + "</font>";
            this._describe.text = ($.as(this.tipData, $.C("yishi.datas.templates.PawnSpecialTempInfo"))).Description;
            this._describe.height = this._describe.textHeight + 5;
            this._bg.height = this._describe.y + this._describe.height + 10;
         }
      }
    dispose() {
         if(this._name)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         }
         this._name = null;
         if(this._describe)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._describe);
         }
         this._describe = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__PawnSpecialTips, "yishi.view.tips.PawnSpecialTips", []);
  return __PawnSpecialTips;
}
deps["yishi.view.tips.PawnSpecialTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.templates.PawnSpecialTempInfo", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.PawnTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PawnTip extends __Base {
    static $fields(self) {
    self._contain = null;
    self._name = null;
    self._lifeContain = null;
    self._life = null;
    self._lifeValue = null;
    self._physicalAttackContain = null;
    self._physicalAttack = null;
    self._physicalAttackValue = null;
    self._physicalDefenseContain = null;
    self._physicalDefense = null;
    self._physicalDefenseValue = null;
    self._magicAttackContain = null;
    self._magicAttack = null;
    self._magicAttackValue = null;
    self._magicDefenceContain = null;
    self._magicDefence = null;
    self._magicDefenceValue = null;
    self._skill = null;
    self._skillValue = null;
    self._line1 = null;
    self._line2 = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 215;
         this._bg.height = 240;
         this._contain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.TipContain");
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnNameText");
         this._contain.addChild(this._name);
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnTipLine1");
         this._contain.addChild(this._line1);
         this._lifeContain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._life = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnLifeText");
         this._life.text = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip11");
         this._lifeValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnLifeValueText");
         this._lifeContain.addChild(this._life);
         this._lifeContain.addChild(this._lifeValue);
         this._contain.addChild(this._lifeContain);
         this._physicalAttackContain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._physicalAttack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnAttackText");
         this._physicalAttack.text = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip13");
         this._physicalAttackValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnAttackValueText");
         this._physicalAttackContain.addChild(this._physicalAttack);
         this._physicalAttackContain.addChild(this._physicalAttackValue);
         this._contain.addChild(this._physicalAttackContain);
         this._magicAttackContain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._magicAttack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnAgilityText");
         this._magicAttack.text = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip15");
         this._magicAttackValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnAgilityValueText");
         this._magicAttackContain.addChild(this._magicAttack);
         this._magicAttackContain.addChild(this._magicAttackValue);
         this._contain.addChild(this._magicAttackContain);
         this._physicalDefenseContain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._physicalDefense = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnDefenseText");
         this._physicalDefense.text = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip14");
         this._physicalDefenseValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnDefenseValueText");
         this._physicalDefenseContain.addChild(this._physicalDefense);
         this._physicalDefenseContain.addChild(this._physicalDefenseValue);
         this._contain.addChild(this._physicalDefenseContain);
         this._magicDefenceContain = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._magicDefence = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnAbilityText");
         this._magicDefence.text = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip16");
         this._magicDefenceValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnAbilityValueText");
         this._magicDefenceContain.addChild(this._magicDefence);
         this._magicDefenceContain.addChild(this._magicDefenceValue);
         this._contain.addChild(this._magicDefenceContain);
         this._line2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnTipLine2");
         this._contain.addChild(this._line2);
         this._skill = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnSkillText");
         this._skill.text = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip18");
         this._skillValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnSkillValueText");
         this._contain.addChild(this._skill);
         this._contain.addChild(this._skillValue);
         this.addChild(this._contain);
      }
    clean() {
         this._contain.removeAllChild();
         this._contain.refreshChildPos();
      }
    refreshAttribute(param1, param2, param3, param4) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         if(param1 > 0)
         {
            if(param2 > 0)
            {
               param3.htmlText = param1 + "<font color=\'#48d72a\'>+" + param2 + "</font>";
            }
            else
            {
               param3.htmlText = param1.toString();
            }
            this._contain.addChild(param4);
         }
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc1_ = null;
         if($.is(this.tipData, $.C("mvc.module.armyII.ArmyPawn")))
         {
            this.clean();
            _loc2_ = $.as(this.tipData, $.C("mvc.module.armyII.ArmyPawn"));
            this._name.text = $.C("manager.LanguageMgr").GetTranslation("public.level.name",_loc2_.templateInfo.PawnName,_loc2_.templateInfo.Level);
            this._contain.addChild(this._name);
            this._contain.addChild(this._line1);
            this.refreshAttribute(_loc2_.templateInfo.Live,_loc2_.live - _loc2_.templateInfo.Live,this._lifeValue,this._lifeContain);
            this.refreshAttribute(_loc2_.templateInfo.Attack,_loc2_.attack - _loc2_.templateInfo.Attack,this._physicalAttackValue,this._physicalAttackContain);
            this.refreshAttribute(_loc2_.templateInfo.MagicAttack,_loc2_.magicAttack - _loc2_.templateInfo.MagicAttack,this._magicAttackValue,this._magicAttackContain);
            this.refreshAttribute(_loc2_.templateInfo.Defence,_loc2_.defence - _loc2_.templateInfo.Defence,this._physicalDefenseValue,this._physicalDefenseContain);
            this.refreshAttribute(_loc2_.templateInfo.MagicDefence,_loc2_.magicDefence - _loc2_.templateInfo.MagicDefence,this._magicDefenceValue,this._magicDefenceContain);
            _loc1_ = this.getSkill(_loc2_.templateInfo.HighSkill);
            if(_loc1_ != "")
            {
               this._skillValue.text = _loc1_;
               this._skillValue.height = this._skillValue.textHeight + this._skillValue.numLines * 2;
               this._contain.addChild(this._line2);
               this._contain.addChild(this._skill);
               this._contain.addChild(this._skillValue);
            }
            this._bg.height = this._contain.y + this._contain.height + 15;
            if(this._bg.width < this._name.x + this._name.width + 30)
            {
               this._bg.width = this._name.x + this._name.width + 30;
            }
         }
      }
    getSkill(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         var _loc4_ = null;
         var _loc2_ = "";
         var _loc3_ = param1.split(",");
         for (var _loc5_ of $.values(_loc3_))
         {
            _loc4_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById($.int(_loc5_));
            if(_loc4_)
            {
               _loc2_ += _loc4_.TemplateName + "\n";
            }
         }
         return _loc2_;
      }
    dispose() {
         if(this._contain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contain);
         }
         this._contain = null;
         if(this._name)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         }
         this._name = null;
         if(this._lifeContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lifeContain);
         }
         this._lifeContain = null;
         if(this._life)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._life);
         }
         this._life = null;
         if(this._lifeValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lifeValue);
         }
         this._lifeValue = null;
         if(this._physicalAttackContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._physicalAttackContain);
         }
         this._physicalAttackContain = null;
         if(this._physicalAttack)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._physicalAttack);
         }
         this._physicalAttack = null;
         if(this._physicalAttackValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._physicalAttackValue);
         }
         this._physicalAttackValue = null;
         if(this._physicalDefenseContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._physicalDefenseContain);
         }
         this._physicalDefenseContain = null;
         if(this._physicalDefense)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._physicalDefense);
         }
         this._physicalDefense = null;
         if(this._physicalDefenseValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._physicalDefenseValue);
         }
         this._physicalDefenseValue = null;
         if(this._magicAttackContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._magicAttackContain);
         }
         this._magicAttackContain = null;
         if(this._magicAttack)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._magicAttack);
         }
         this._magicAttack = null;
         if(this._magicAttackValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._magicAttackValue);
         }
         this._magicAttackValue = null;
         if(this._magicDefenceContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._magicDefenceContain);
         }
         this._magicDefenceContain = null;
         if(this._magicDefence)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._magicDefence);
         }
         this._magicDefence = null;
         if(this._magicDefenceValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._magicDefenceValue);
         }
         this._magicDefenceValue = null;
         if(this._skill)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skill);
         }
         this._skill = null;
         if(this._skillValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skillValue);
         }
         this._skillValue = null;
         if(this._line1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         }
         this._line1 = null;
         if(this._line2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line2);
         }
         this._line2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__PawnTip, "yishi.view.tips.PawnTip", []);
  return __PawnTip;
}
deps["yishi.view.tips.PawnTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "mvc.module.armyII.ArmyPawn", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.PerkinLabExpTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PerkinLabExpTips extends __Base {
    static $fields(self) {
    self.curImage = null;
    self.curRewardText = null;
    self.nextVbox = null;
    self.nextImage = null;
    self.nextRewardText = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 450;
         this.curImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.PerkinLabExpTips.curImage");
         this.curRewardText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PerkinLabExpTips.curRewardText");
         this.nextVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PerkinLabExpTips.nextVbox");
         this.nextImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.PerkinLabExpTips.nextImage");
         this.nextRewardText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PerkinLabExpTips.nextRewardText");
         this.addChild(this.curImage);
         this.addChild(this.curRewardText);
         this.addChild(this.nextVbox);
      }
    $$updateTransform() {
         var _loc3_ = 0;
         var _loc2_ = null;
         var _loc10_ = null;
         var _loc17_ = null;
         var _loc9_ = null;
         var _loc1_ = null;
         var _loc5_ = null;
         var _loc4_ = null;
         var _loc12_ = null;
         var _loc16_ = null;
         var _loc19_ = null;
         var _loc13_ = null;
         var _loc7_ = null;
         var _loc11_ = null;
         var _loc15_ = null;
         var _loc8_ = null;
         var _loc18_ = null;
         var _loc6_ = null;
         var _loc14_ = null;
         if(this.tipData)
         {
            this.nextVbox.removeAllChild();
            _loc3_ = $.int(this.model.curGrade);
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc3_,134);
            _loc10_ = $.C("yishi.manager.TempleteManager").instance.getTemplateByLevelAndType(_loc3_ + 1,134);
            _loc17_ = _loc2_.TemplateName;
            _loc9_ = _loc17_.split(";")[0].split("|");
            _loc1_ = _loc17_.split(";")[1].split(",");
            _loc5_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc9_[0].split(",")[0]).TemplateName;
            _loc4_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc9_[1].split(",")[0]).TemplateName;
            _loc12_ = $.C("manager.LanguageMgr").GetTranslation("PerkinLabExpTips.curRewardText.text",_loc5_,_loc9_[0].split(",")[1]);
            _loc16_ = $.C("manager.LanguageMgr").GetTranslation("PerkinLabExpTips.curRewardText.text",_loc4_,_loc9_[1].split(",")[1]);
            _loc19_ = $.C("manager.LanguageMgr").GetTranslation("PerkinLabExpTips.curRewardText.text2",_loc1_[0],_loc1_[1],_loc4_);
            this.curRewardText.htmlText = _loc12_ + "\n" + _loc16_ + "\n" + _loc19_;
            if(_loc10_)
            {
               _loc13_ = _loc10_.TemplateName;
               _loc7_ = _loc13_.split(";")[0].split("|");
               _loc11_ = _loc13_.split(";")[1].split(",");
               _loc15_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc7_[0].split(",")[0]).TemplateName;
               _loc8_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc7_[1].split(",")[0]).TemplateName;
               _loc18_ = $.C("manager.LanguageMgr").GetTranslation("PerkinLabExpTips.curRewardText.text",_loc15_,_loc7_[0].split(",")[1]);
               _loc6_ = $.C("manager.LanguageMgr").GetTranslation("PerkinLabExpTips.curRewardText.text",_loc8_,_loc7_[1].split(",")[1]);
               _loc14_ = $.C("manager.LanguageMgr").GetTranslation("PerkinLabExpTips.curRewardText.text2",_loc11_[0],_loc11_[1],_loc8_);
               this.nextRewardText.htmlText = _loc18_ + "\n" + _loc6_ + "\n" + _loc14_;
               this.nextVbox.addChild(this.nextImage);
               this.nextVbox.addChild(this.nextRewardText);
            }
            this._bg.height = this.nextVbox.y + this.nextVbox.height + 20;
         }
      }
    get model() {
         return $.C("managers.PerkinLabManager").instance.model;
      }
    dispose() {
         if(this.curImage)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.curImage);
         }
         this.curImage = null;
         if(this.curRewardText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.curRewardText);
         }
         this.curRewardText = null;
         if(this.nextImage)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nextImage);
         }
         this.nextImage = null;
         if(this.nextRewardText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nextRewardText);
         }
         this.nextRewardText = null;
         if(this.nextVbox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nextVbox);
         }
         this.nextVbox = null;
         super.dispose();
      }
    set model(v) { super.model = v; }
  }
  $.meta(__PerkinLabExpTips, "yishi.view.tips.PerkinLabExpTips", []);
  return __PerkinLabExpTips;
}
deps["yishi.view.tips.PerkinLabExpTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.PerkinLabManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.PerkinLabKengTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PerkinLabKengTip extends __Base {
    static $fields(self) {
    self.titleText = null;
    self.line = null;
    self.timeText = null;
    self.rewardText = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.titleText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PerkinLabKengTip.titleText");
         this.line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this.timeText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PerkinLabKengTip.timeText");
         this.rewardText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PerkinLabKengTip.rewardText");
         this.addChild(this.titleText);
         this.addChild(this.line);
         this.line.width = 200;
         this.addChild(this.rewardText);
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc5_ = 0;
         var _loc2_ = null;
         var _loc7_ = 0;
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc6_ = null;
         this.cleanData();
         if(this._data)
         {
            this.titleText.text = $.C("manager.LanguageMgr").GetTranslation("PerkinLabEventItem.event.sizeText");
            _loc1_ = this._data.reward.split("|");
            _loc5_ = $.int(_loc1_.length);
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("PerkinLabKengTip.rewardText.text");
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc3_ = _loc1_[_loc7_];
               _loc4_ = _loc3_.split(",");
               _loc6_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc4_[0]);
               if(_loc6_)
               {
                  _loc2_ += _loc6_.TemplateName + " x" + _loc4_[1] + ",";
               }
               _loc7_++;
            }
            _loc2_ = _loc2_.substring(0,_loc2_.lastIndexOf(","));
            this.rewardText.text = _loc2_;
            this.line.y = this.titleText.y + this.titleText.textHeight + 10;
            this.rewardText.height = this.rewardText.textHeight + 5;
            if(this._data.type == 1)
            {
               this.rewardText.y = this.titleText.y + this.titleText.textHeight + 15;
            }
            else
            {
               this.addChild(this.timeText);
               this.timeText.text = this._data.time;
               this.timeText.y = this.titleText.y + this.titleText.textHeight + 15;
               this.rewardText.y = this.timeText.y + this.timeText.textHeight + 5;
            }
         }
         this._bg.height = this.titleText.textHeight + this.timeText.textHeight + this.rewardText.textHeight + 40;
         this._bg.width = 220;
      }
    cleanData() {
         if(this.timeText && this.timeText.parent)
         {
            this.timeText.parent.removeChild(this.timeText);
         }
         this.titleText.text = "";
         this.rewardText.text = "";
      }
    get model() {
         return $.C("managers.PerkinLabManager").instance.model;
      }
    dispose() {
         if(this.titleText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.titleText);
         }
         this.titleText = null;
         if(this.line)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.line);
         }
         this.line = null;
         if(this.timeText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.timeText);
         }
         this.timeText = null;
         if(this.rewardText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.rewardText);
         }
         this.rewardText = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set model(v) { super.model = v; }
  }
  $.meta(__PerkinLabKengTip, "yishi.view.tips.PerkinLabKengTip", []);
  return __PerkinLabKengTip;
}
deps["yishi.view.tips.PerkinLabKengTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.PerkinLabManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.PerkinLabVictoryTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PerkinLabVictoryTip extends __Base {
    static $fields(self) {
    self.descText = null;
    self.line1 = null;
    self.victoryCountText = null;
    self.rewardAlertText = null;
    self.rewardText = null;
    self.rewardItem = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.descText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PerkinLabVictoryTip.descText");
         this.line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this.victoryCountText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PerkinLabVictoryTip.victoryCountText");
         this.rewardAlertText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PerkinLabVictoryTip.rewardAlertText");
         this.rewardText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PerkinLabVictoryTip.rewardText");
         this.rewardItem = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.BaseItemView");
         this.addChild(this.descText);
         this.addChild(this.line1);
         this.addChild(this.victoryCountText);
         this.addChild(this.rewardAlertText);
         this.addChild(this.rewardItem);
         this.addChild(this.rewardText);
         this.line1.width = 180;
         this.rewardItem.x = 75;
         this.rewardItem.y = 100;
         this.descText.text = $.C("manager.LanguageMgr").GetTranslation("PerkinLabVictoryTip.descText.text");
         this.line1.y = this.descText.y + this.descText.textHeight + 5;
         this.victoryCountText.y = this.line1.y + 5;
         this._bg.width = 200;
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc2_ = null;
         this.rewardItem.visible = false;
         this.rewardText.visible = false;
         if(this._data)
         {
            this.victoryCountText.text = $.C("manager.LanguageMgr").GetTranslation("PerkinLabVictoryTip.victoryCountText.text",this._data.victoryCount);
            this.rewardAlertText.y = this.victoryCountText.y + this.victoryCountText.textHeight + 5;
            if(this._data.victoryCount <= 0)
            {
               this.rewardAlertText.text = $.C("manager.LanguageMgr").GetTranslation("PerkinLabVictoryTip.rewardAlertText.text1");
               this._bg.height = this.rewardAlertText.y + this.rewardAlertText.textHeight + 5;
            }
            else
            {
               this.rewardItem.visible = true;
               this.rewardText.visible = true;
               this.rewardAlertText.text = $.C("manager.LanguageMgr").GetTranslation("PerkinLabVictoryTip.rewardAlertText.text2");
               _loc1_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(this._data.tempId);
               if(_loc1_)
               {
                  this.rewardText.text = _loc1_.TemplateName + "×" + this._data.count;
               }
               _loc2_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
               _loc2_.templateId = this._data.tempId;
               this.rewardItem.data = _loc2_;
               this.rewardItem.y = this.rewardAlertText.y + this.rewardAlertText.textHeight + 5;
               this.rewardText.y = this.rewardItem.y + 50;
               this._bg.height = this.rewardText.y + this.rewardText.textHeight + 5;
            }
         }
      }
    dispose() {
         if(this.line1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.line1);
         }
         this.line1 = null;
         if(this.descText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.descText);
         }
         this.descText = null;
         if(this.rewardAlertText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.rewardAlertText);
         }
         this.rewardAlertText = null;
         if(this.rewardText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.rewardText);
         }
         this.rewardText = null;
         if(this.rewardItem)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.rewardItem);
         }
         this.rewardItem = null;
         if(this.victoryCountText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.victoryCountText);
         }
         this.victoryCountText = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__PerkinLabVictoryTip, "yishi.view.tips.PerkinLabVictoryTip", []);
  return __PerkinLabVictoryTip;
}
deps["yishi.view.tips.PerkinLabVictoryTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.goods.GoodsInfo", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.PetAttributeItemView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PetAttributeItemView extends __Base {
    static $fields(self) {
    self._flagImg = null;
    self._descTxt = null;
    }
    constructor() {
         super();
         this._flagImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.attributeFlag");
         this._descTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PetAttributeView.desctxt");
         this.addChild(this._flagImg);
         this.addChild(this._descTxt);
      }
    setData(param1, param2 = 1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         this._descTxt.text = param1;
         this._descTxt.setFrame(param2);
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._flagImg);
         this._flagImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._descTxt);
         this._descTxt = null;
      }
  }
  $.meta(__PetAttributeItemView, "yishi.view.tips.PetAttributeItemView", ["Disposeable"]);
  return __PetAttributeItemView;
}
deps["yishi.view.tips.PetAttributeItemView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["yishi.view.tips.PetBossTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PetBossTips extends __Base {
    static $fields(self) {
    self._vBox = null;
    self._hBox = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PetBossVBox");
         this.addChild(this._vBox);
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc3_ = 0;
         var _loc4_ = null;
         var _loc2_ = null;
         if(this.tipData)
         {
            this._vBox.disposeAllChildren();
            this._hBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PetBossHBox");
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PetBoss.firstTxt");
            _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.PetBossTips.firstTxt");
            this._vBox.addChild(_loc1_);
            _loc3_ = 0;
            while(_loc3_ < this.tipData.length)
            {
               _loc4_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
               _loc4_.templateId = this.tipData[_loc3_].ItemId;
               _loc4_.count = this.tipData[_loc3_].Count;
               _loc2_ = new ($.C("yishi.view.tips.PetBossTipsItem"))();
               _loc2_.data = _loc4_;
               this._hBox.addChild(_loc2_);
               _loc3_++;
            }
            this._vBox.addChild(this._hBox);
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PetBoss.firstTxt");
            _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.PetBossTips.otherTxt");
            this._vBox.addChild(_loc1_);
            this._hBox.refreshChildPos();
            this._vBox.refreshChildPos();
            this._bg.width = this._hBox.numChildren * 80 + 30;
            if(this._bg.width < 320)
            {
               this._bg.width = 320;
            }
            this._bg.height = this._vBox.height + 20;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hBox);
         this._hBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         this._vBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
  }
  $.meta(__PetBossTips, "yishi.view.tips.PetBossTips", []);
  return __PetBossTips;
}
deps["yishi.view.tips.PetBossTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.goods.GoodsInfo", "yishi.view.tips.BaseTip", "yishi.view.tips.PetBossTipsItem"];

defs["yishi.view.tips.PetBossTipsItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PetBossTipsItem extends __Base {
    static $fields(self) {
    self._itemIcon = null;
    self._itemName = null;
    self._data = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._itemIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("PetBossTipsItem.BaseItemView");
         this._itemName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetBossTipsItem.rewardItemName");
         this.addChild(this._itemIcon);
         this.addChild(this._itemName);
      }
    set data(param1) {
         if(!param1)
         {
            return;
         }
         this._data = param1;
         this._itemIcon.data = this._data;
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(this._data.templateId).TemplateName;
         this._itemName.text = _loc2_ + "x" + this._data.count;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemIcon);
         this._itemIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemName);
         this._itemName = null;
         this._data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__PetBossTipsItem, "yishi.view.tips.PetBossTipsItem", ["Disposeable"]);
  return __PetBossTipsItem;
}
deps["yishi.view.tips.PetBossTipsItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.manager.TempleteManager"];

defs["yishi.view.tips.PetCompareTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PetCompareTip extends __Base {
    static $fields(self) {
    self._selfPetTip = null;
    self._currentTip = null;
    }
    constructor() {
         super();
      }
    init() {
         this._selfPetTip = new ($.C("yishi.view.tips.PetTip"))();
         this._selfPetTip.type = 1;
         this._currentTip = new ($.C("yishi.view.tips.PetTip"))();
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc1_ = null;
         if(this._selfPetTip.parent)
         {
            this._selfPetTip.parent.removeChild(this._selfPetTip);
         }
         if(this._currentTip.parent)
         {
            this._currentTip.parent.removeChild(this._currentTip);
         }
         this._currentTip.state = false;
         if($.is(this.tipData, "Array") || $.is(this.tipData, $.Vector))
         {
            _loc1_ = $.as(this.tipData[0], $.C("mvc.module.pet.PetData"));
            _loc2_ = $.as(this.tipData[1], $.C("mvc.module.pet.PetData"));
            this._selfPetTip.type = 2;
            this._currentTip.type = 3;
         }
         else
         {
            _loc2_ = $.as(this.tipData, $.C("mvc.module.pet.PetData"));
            _loc1_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo.enterWarPet;
            this._selfPetTip.type = 1;
            this._currentTip.type = 0;
         }
         if(!_loc1_ || _loc1_ == _loc2_ || _loc1_.petId == _loc2_.petId && _loc1_.userId == _loc2_.userId)
         {
            this.addChild(this._currentTip);
            this._currentTip.x = 0;
         }
         else
         {
            this._currentTip.state = true;
            this.addChild(this._selfPetTip);
            this.addChild(this._currentTip);
            this._selfPetTip.x = 290;
            this._currentTip.x = 0;
         }
         this._currentTip.tipData = _loc2_;
         this._selfPetTip.tipData = _loc1_;
      }
    set direction(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(!this._currentTip)
         {
            return;
         }
         if(!this._selfPetTip)
         {
            return;
         }
         switch(param1)
         {
            case 0:
            case 2:
            case 5:
            case 7:
               this._currentTip.x = 0;
               this._selfPetTip.x = 290;
               break;
            case 1:
            case 3:
            case 4:
            case 6:
               this._selfPetTip.x = 0;
               this._currentTip.x = 290;
         }
         if(!this._selfPetTip.parent)
         {
            this._currentTip.x = 0;
         }
      }
    dispose() {
         if(this._currentTip)
         {
            this._currentTip.dispose();
         }
         this._currentTip = null;
         if(this._selfPetTip)
         {
            this._selfPetTip.dispose();
         }
         this._selfPetTip = null;
         super.dispose();
      }
    get direction() { return super.direction; }
  }
  $.meta(__PetCompareTip, "yishi.view.tips.PetCompareTip", []);
  return __PetCompareTip;
}
deps["yishi.view.tips.PetCompareTip"] = ["mvc.module.pet.PetData", "yishi.manager.PlayerManager", "yishi.view.tips.BaseTip", "yishi.view.tips.PetTip"];

defs["yishi.view.tips.PetComposeCompareTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PetComposeCompareTip extends __Base {
    static $fields(self) {
    self._intensifyIcon = null;
    self._selfPetTip = null;
    self._currentTip = null;
    }
    constructor() {
         super();
      }
    init() {
         this._selfPetTip = new ($.C("yishi.view.tips.PetTip"))();
         this._currentTip = new ($.C("yishi.view.tips.PetTip"))();
         this._intensifyIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc1_ = null;
         if(this._selfPetTip.parent)
         {
            this._selfPetTip.parent.removeChild(this._selfPetTip);
         }
         if(this._currentTip.parent)
         {
            this._currentTip.parent.removeChild(this._currentTip);
         }
         if(this._intensifyIcon.parent)
         {
            this._intensifyIcon.parent.removeChild(this._intensifyIcon);
         }
         if($.is(this.tipData, "Array") || $.is(this.tipData, $.Vector))
         {
            _loc1_ = $.as(this.tipData[0], $.C("mvc.module.pet.PetData"));
            _loc2_ = $.as(this.tipData[1], $.C("mvc.module.pet.PetData"));
         }
         this._selfPetTip.tipData = _loc1_;
         this._currentTip.tipData = _loc2_;
         this.addChild(this._selfPetTip);
         this.addChild(this._currentTip);
         this.addChild(this._intensifyIcon);
         this._selfPetTip.x = 0;
         this._currentTip.x = 313;
         this._intensifyIcon.x = 270;
         this._intensifyIcon.y = (this._selfPetTip.height - this._intensifyIcon.height) * 0.5;
      }
    dispose() {
         if(this._currentTip)
         {
            this._currentTip.dispose();
         }
         this._currentTip = null;
         if(this._selfPetTip)
         {
            this._selfPetTip.dispose();
         }
         this._selfPetTip = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._intensifyIcon);
         this._intensifyIcon = null;
         super.dispose();
      }
  }
  $.meta(__PetComposeCompareTip, "yishi.view.tips.PetComposeCompareTip", []);
  return __PetComposeCompareTip;
}
deps["yishi.view.tips.PetComposeCompareTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "mvc.module.pet.PetData", "yishi.view.tips.BaseTip", "yishi.view.tips.PetTip"];

defs["yishi.view.tips.PetContracAddTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PetContracAddTips extends __Base {
    static $fields(self) {
    self.titleText = null;
    self.addTextVbox = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.titleText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetContracAddTips.titleText");
         this.addTextVbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetContracAddTips.addTextVbox");
         this.addChild(this.titleText);
         this.addChild(this.addTextVbox);
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc6_ = 0;
         var _loc3_ = null;
         var _loc7_ = null;
         var _loc9_ = null;
         var _loc4_ = 0;
         var _loc5_ = 0;
         var _loc11_ = null;
         var _loc12_ = null;
         var _loc13_ = null;
         var _loc2_ = null;
         var _loc10_ = null;
         var _loc8_ = null;
         this.addTextVbox.removeAllChild();
         if(this.tipData)
         {
            _loc6_ = $.int(this.tipData.type);
            _loc3_ = $.as(this.tipData.dic, $.C("flash.utils.Dictionary"));
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("PetContracAddTips.titleText.text" + _loc6_);
            _loc9_ = this.getDicKeys(_loc3_);
            _loc4_ = 0;
            if(_loc6_ == 1 || _loc6_ == 2)
            {
               while(_loc4_ < _loc9_.length)
               {
                  _loc5_ = $.int(_loc9_[_loc4_]);
                  if(_loc5_ == 0 && (this.thane.job == 3 || this.thane.job == 6))
                  {
                     _loc5_ = 1;
                  }
                  _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetContracAddTips.addPropText");
                  this.addTextVbox.addChild(_loc1_);
                  _loc1_.htmlText = $.C("manager.LanguageMgr").GetTranslation("PetContracAddTips.addPropText" + _loc5_) + "+" + _loc3_[_loc9_[_loc4_]];
                  _loc4_++;
               }
               if(this.addTextVbox.numChildren <= 0)
               {
                  _loc7_ += $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
               }
            }
            else if(_loc6_ == 3)
            {
               while(_loc4_ < _loc9_.length)
               {
                  _loc11_ = _loc3_[_loc9_[_loc4_]];
                  _loc12_ = $.C("yishi.manager.TempleteManager").instance.getSkillById(_loc11_.SkillTempId);
                  _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetContracAddTips.addPropText");
                  this.addTextVbox.addChild(_loc1_);
                  _loc13_ = _loc11_.TemplateName + " " + $.C("manager.LanguageMgr").GetTranslation("public.level4_space2",_loc11_.Grades);
                  _loc2_ = _loc12_.Grades >= 10 ? "&nbsp;&nbsp; " : "&nbsp;&nbsp;&nbsp;";
                  _loc1_.htmlText = $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc12_.Grades) + _loc2_ + $.C("manager.LanguageMgr").GetTranslation("PetContracAddTips.addvalueText.text2",_loc13_);
                  _loc4_++;
               }
            }
            else if(_loc6_ == 4)
            {
               while(_loc4_ < _loc9_.length)
               {
                  _loc5_ = $.int(_loc9_[_loc4_]);
                  _loc8_ = _loc3_[_loc5_].split("_");
                  if($.int(_loc8_[0]) > 0)
                  {
                     _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetContracAddTips.addPropText");
                     this.addTextVbox.addChild(_loc1_);
                     _loc10_ = $.C("manager.LanguageMgr").GetTranslation("PetContracAddTips.addPropText" + _loc5_) + "+" + _loc8_[0];
                     if($.int(_loc8_[1]) > 0)
                     {
                        _loc10_ += "&nbsp;&nbsp;" + $.C("manager.LanguageMgr").GetTranslation("PetContracAddTips.addvalueText.text",_loc8_[1]);
                     }
                     _loc1_.htmlText = _loc10_;
                  }
                  _loc4_++;
               }
               if(this.addTextVbox.numChildren <= 0)
               {
                  _loc7_ += $.C("manager.LanguageMgr").GetTranslation("armyII.viewII.attribute.PlayerAttributeView.Not");
               }
            }
            this.titleText.text = _loc7_;
            this._bg.height = this.addTextVbox.height + 55;
            this._bg.width = 300;
         }
      }
    getDicKeys(param1) {
         var _loc3_ = [];
         for(var _loc2_ in param1)
         {
            _loc3_.push($.int(_loc2_));
         }
         _loc3_.sort(16);
         return _loc3_;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    dispose() {
         if(this.titleText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.titleText);
         }
         this.titleText = null;
         if(this.addTextVbox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.addTextVbox);
         }
         this.addTextVbox = null;
         super.dispose();
      }
    set thane(v) { super.thane = v; }
  }
  $.meta(__PetContracAddTips, "yishi.view.tips.PetContracAddTips", []);
  return __PetContracAddTips;
}
deps["yishi.view.tips.PetContracAddTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.utils.Dictionary", "manager.LanguageMgr", "yishi.manager.ArmyManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.PetEquipIcon"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PetEquipIcon extends __Base {
    static $fields(self) {
    self._bg = null;
    self._item = null;
    self._equipName = null;
    self._openCondition = null;
    self._lockImg = null;
    self._data = null;
    self._openState = true;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._bg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.equipGemBg");
         this._item = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.PetEquipItemView");
         this._equipName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.petEquipIcon.equipNameTxt");
         this._openCondition = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.petEquipIcon.openConditionTxt");
         this._lockImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.equipHoldClosed02");
         this.addChild(this._bg);
         this._bg.width = 41;
         this._bg.height = 41;
         this._bg.x = 23;
         this.addChild(this._item);
         this.addChild(this._equipName);
         this.addChild(this._openCondition);
         this._openCondition.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.PetEquipIcon.openCondition");
         this.addChild(this._lockImg);
         this._lockImg.x = 34;
         this._lockImg.y = 7;
      }
    set data(param1) {
         if(!param1)
         {
            this._item.data = null;
            this._equipName.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.PetEquipIcon.notEquip");
            this._equipName.setFrame(6);
            return;
         }
         this._openCondition.visible = false;
         this._lockImg.visible = false;
         this._data = param1;
         this._item.data = this._data;
         var _loc2_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(this._data.templateId);
         this._equipName.text = _loc2_.TemplateName;
         this._equipName.setFrame(_loc2_.Profile);
      }
    set openState(param1) {
         this._openState = param1;
         if(!this._openState)
         {
            this._lockImg.visible = false;
            if(this._openCondition && !this._openCondition.parent)
            {
               this.addChild(this._openCondition);
            }
            this._openCondition.visible = true;
            this._equipName.visible = false;
            this._item.visible = false;
         }
         else
         {
            if(this._openCondition && this._openCondition.parent)
            {
               this._openCondition.parent.removeChild(this._openCondition);
            }
            this._lockImg.visible = false;
            this._equipName.visible = true;
            this._item.visible = true;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._item);
         this._item = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._equipName);
         this._equipName = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._openCondition);
         this._openCondition = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bg);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lockImg);
      }
    get data() { return super.data; }
    get openState() { return super.openState; }
  }
  $.meta(__PetEquipIcon, "yishi.view.tips.PetEquipIcon", ["Disposeable"]);
  return __PetEquipIcon;
}
deps["yishi.view.tips.PetEquipIcon"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.manager.TempleteManager"];

defs["yishi.view.tips.PetFigureTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PetFigureTip extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._subBox1 = null;
    self._subBox2 = null;
    self._blackKingBg = null;
    self._redBg = null;
    self._yellowBg = null;
    self._purpleBg = null;
    self._blueBg = null;
    self._greenBg = null;
    self._whiteBg = null;
    self._splitLine = null;
    self._splitLine2 = null;
    self._splitLine3 = null;
    self._hbox = null;
    self._growthTxt = null;
    self._strengthCoeTxt = null;
    self._armorCoeTxt = null;
    self._intellectCoeTxt = null;
    self._staminaCoeTxt = null;
    self._propertyPointTxt = null;
    self._hpTxt = null;
    self._physicsAttackTxt = null;
    self._physicsDefenseTxt = null;
    self._magicAttackTxt = null;
    self._magicDefenseTxt = null;
    self._con = null;
    self._equipIcon = null;
    self._profileImg = null;
    self._title = null;
    self._petSkillIcon = null;
    self._type = null;
    self._vocation = null;
    self._powerTxt = null;
    self._strengthMc = null;
    self._hBox = null;
    self._expTxt = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 247;
         this._blackKingBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blackItemTipsBg");
         this._redBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.redItemTipsBg");
         this._yellowBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.yellowItemTipsBg");
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._blueBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blueItemTipsBg");
         this._greenBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.greenItemTipsBg");
         this._whiteBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.whiteItemTipsBg");
         this._con = new ($.C("flash.display.Sprite"))();
         this._equipIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this._petSkillIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.PetTypeImage");
         this._type = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodTypeText_2");
         this._vocation = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodVocationText");
         this._powerTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.pet.PowerTxt");
         this._strengthMc = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tip.pet.PropertyCoeBar");
         this._expTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("pet.ExpTxt");
         this._hBox = new ($.C("com.pickgliss.ui.controls.container.HBox"))();
         this._splitLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._splitLine.x = -7;
         this._splitLine.scaleX = 0.95;
         this._splitLine2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._splitLine2.x = -7;
         this._splitLine2.scaleX = 0.95;
         this._splitLine3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._splitLine3.x = -7;
         this._splitLine3.scaleX = 0.95;
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsTotalBox");
         this._subBox1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsSubBox");
         this._subBox2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsSubBox");
         this._growthTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._strengthCoeTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._armorCoeTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._intellectCoeTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._staminaCoeTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._propertyPointTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._hpTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._physicsAttackTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._physicsDefenseTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._magicAttackTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this._magicDefenseTxt = new ($.C("yishi.view.tips.goods.FashionAttItem"))();
         this.addChild(this._blackKingBg);
         this.addChild(this._redBg);
         this.addChild(this._yellowBg);
         this.addChild(this._purpleBg);
         this.addChild(this._blueBg);
         this.addChild(this._greenBg);
         this.addChild(this._whiteBg);
         this._profileImg.setFrame(1);
         this._con.addChild(this._equipIcon);
         this._equipIcon.x = 15;
         this._equipIcon.y = 1;
         this._con.addChild(this._title);
         this._title.width = 114;
         this._title.x = 80;
         this._title.y = 20;
         this._con.addChild(this._petSkillIcon);
         this._petSkillIcon.x = 195;
         this._petSkillIcon.y = 15;
         this._con.addChild(this._profileImg);
         this._profileImg.x = 15;
         this._profileImg.y = 10;
         this._con.addChild(this._type);
         this._type.x = 2;
         this._type.y = 65;
         this._con.addChild(this._vocation);
         this._vocation.width = 180;
         this._vocation.x = 43;
         this._vocation.y = 65;
         this._con.addChild(this._hBox);
         this._hBox.x = 140;
         this._hBox.y = 45;
         this._con.addChild(this._strengthMc);
         this._strengthMc.x = 18;
         this._strengthMc.y = 87;
         this._con.addChild(this._expTxt);
         this._expTxt.x = 52;
         this._expTxt.y = 87;
         this._expTxt.width = 140;
         this._totalBox.x = 10;
         this._totalBox.y = 110;
      }
    $$updateTransform() {
         var _loc2_ = 0;
         var _loc1_ = 0;
         this.clean();
         if($.is(this.tipData, $.C("mvc.module.pet.PetData")))
         {
            this._equipIcon.icon = $.C("yishi.utils.IconFactory").getPetHeadItemIcon(this._data.templateId);
            this._profileImg.setFrame(this._data.quality);
            this._bg.visible = false;
            this.hidenBg(this._data.quality);
            this.showStar($.as(this.tipData, $.C("mvc.module.pet.PetData")));
            this._title.setFrame(this._data.quality);
            this._title.text = this._data.name;
            this._type.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",this._data.grade);
            this._vocation.text = ($.as(this.tipData, $.C("mvc.module.pet.PetData"))).getLevelString();
            this._powerTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.PlayerMenu.ap") + String(this._data.fightPower);
            if(this._data.upgradeTemplte)
            {
               this._expTxt.text = this._data.curExp + " / " + this._data.upgradeTemplte.Data;
               _loc2_ = Math.floor(this._data.curExp * 100 / this._data.upgradeTemplte.Data);
               this._strengthMc.gotoAndStop(_loc2_);
            }
            else
            {
               this._expTxt.text = "MAX";
               this._strengthMc.gotoAndStop(100);
            }
            _loc1_ = this._data.template.PetType - 100;
            if(_loc1_ < 7)
            {
               this._petSkillIcon.setFrame(_loc1_);
            }
            else if(_loc1_ == 17)
            {
               this._petSkillIcon.setFrame(7);
            }
            else if(_loc1_ == 18)
            {
               this._petSkillIcon.setFrame(8);
            }
            else if(_loc1_ == 19)
            {
               this._petSkillIcon.setFrame(9);
            }
            this.initAttribute($.as(this.tipData, $.C("mvc.module.pet.PetData")));
            this.addChild(this._con);
            this.addChild(this._totalBox);
            this._totalBox.addChild(this._splitLine);
            this._totalBox.addChild(this._subBox1);
            this._totalBox.addChild(this._splitLine2);
            this._totalBox.addChild(this._subBox2);
            this._totalBox.addChild(this._splitLine3);
            this._totalBox.addChild(this._powerTxt);
            this._bg.height = $.int(this._totalBox.y + this._totalBox.height);
            this._blackKingBg.width = this._redBg.width = this._yellowBg.width = this._purpleBg.width = this._blueBg.width = this._greenBg.width = this._whiteBg.width = this._bg.width;
            this._blackKingBg.height = this._redBg.height = this._yellowBg.height = this._purpleBg.height = this._blueBg.height = this._greenBg.height = this._whiteBg.height = this._bg.height;
         }
         else if($.is(this.tipData, "String"))
         {
         }
      }
    showStar(param1) {
         var _loc4_ = null;
         var _loc3_ = 0;
         var _loc6_ = 0;
         var _loc5_ = null;
         var _loc2_ = param1.qualityUpgradeTemplateInfo;
         if(_loc2_ == null)
         {
            return;
         }
         _loc3_ = param1.temQuality % 5 == 0 ? 5 : param1.temQuality % 5;
         if(param1.temQuality > 25)
         {
            _loc4_ = "asset.pet.bigMoonLightLevelImg";
         }
         else
         {
            _loc4_ = "asset.pet.StarLevelLightImg";
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap(_loc4_);
            this._hBox.addChild(_loc5_);
            _loc6_++;
         }
      }
    initAttribute(param1) {
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("pet.growthRate");
         this.updateAttributeTxt(this._growthTxt,_loc2_,this._subBox1,param1.growthRate.toString());
         _loc2_ = $.C("manager.LanguageMgr").GetTranslation("pet.strengthCoe");
         this.updateAttributeTxt(this._strengthCoeTxt,_loc2_,this._subBox1,param1.coeStrength + " / " + param1.coeStrengthLimit);
         _loc2_ = $.C("manager.LanguageMgr").GetTranslation("pet.armorCoe");
         this.updateAttributeTxt(this._armorCoeTxt,_loc2_,this._subBox1,param1.coeArmor + " / " + param1.coeArmorLimit);
         _loc2_ = $.C("manager.LanguageMgr").GetTranslation("pet.intellectCoe");
         this.updateAttributeTxt(this._intellectCoeTxt,_loc2_,this._subBox1,param1.coeIntellect + " / " + param1.coeIntellectLimit);
         _loc2_ = $.C("manager.LanguageMgr").GetTranslation("pet.staminaCoe");
         this.updateAttributeTxt(this._staminaCoeTxt,_loc2_,this._subBox1,param1.coeStamina + " / " + param1.coeStaminaLimit);
         _loc2_ = $.C("manager.LanguageMgr").GetTranslation("PetTip.remainPoint");
         this.updateAttributeTxt(this._propertyPointTxt,_loc2_,this._subBox1,param1.remainPoint.toString());
         _loc2_ = $.C("manager.LanguageMgr").GetTranslation("pet.hp");
         this.updateAttributeTxt(this._hpTxt,_loc2_,this._subBox2,param1.Live.toString());
         _loc2_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip06");
         this.updateAttributeTxt(this._physicsAttackTxt,_loc2_,this._subBox2,param1.Attack.toString());
         _loc2_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip07");
         this.updateAttributeTxt(this._physicsDefenseTxt,_loc2_,this._subBox2,param1.Defence.toString());
         _loc2_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip08");
         this.updateAttributeTxt(this._magicAttackTxt,_loc2_,this._subBox2,param1.MagicAttack.toString());
         _loc2_ = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip09");
         this.updateAttributeTxt(this._magicDefenseTxt,_loc2_,this._subBox2,param1.MagicDefence.toString());
      }
    updateAttributeTxt(param1, param2, param3, param4) {
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         if (param4 != null && typeof param4 !== "string") param4 = String(param4);
         if(param4 != "0")
         {
            param1.setData(param2 + " " + param4);
            param3.addChild(param1);
         }
      }
    clean() {
         this._hBox.removeAllChild();
         this._subBox1.removeAllChild();
         this._subBox2.removeAllChild();
         this._totalBox.removeAllChild();
         if(this._con.parent)
         {
            this._con.parent.removeChild(this._con);
         }
         if(this._totalBox.parent)
         {
            this._totalBox.parent.removeChild(this._totalBox);
         }
      }
    hidenBg(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._blackKingBg.visible = false;
         this._redBg.visible = false;
         this._yellowBg.visible = false;
         this._purpleBg.visible = false;
         this._blueBg.visible = false;
         this._greenBg.visible = false;
         this._whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               this._whiteBg.visible = true;
               break;
            case 1:
               this._greenBg.visible = true;
               break;
            case 2:
               this._blueBg.visible = true;
               break;
            case 3:
               this._purpleBg.visible = true;
               break;
            case 4:
               this._yellowBg.visible = true;
               break;
            case 5:
               this._redBg.visible = true;
               break;
            case 6:
               this._blackKingBg.visible = true;
         }
      }
  }
  $.meta(__PetFigureTip, "yishi.view.tips.PetFigureTip", []);
  return __PetFigureTip;
}
deps["yishi.view.tips.PetFigureTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.HBox", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.pet.PetData", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.FashionAttItem"];

defs["yishi.view.tips.PetHallowsLookItem"] = function define($) {
  const __Base = $.C("com.pickgliss.ui.core.Component");
  class __PetHallowsLookItem extends __Base {
    static $fields(self) {
    self.nameText = null;
    self.gradeText = null;
    self.fightText = null;
    self._type = 0;
    self._data = null;
    }
    constructor(param1) {
         super();
         this._type = param1;
         this.initView();
      }
    initView() {
         this.nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetHallowsLookItem.nameText");
         this.gradeText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetHallowsLookItem.gradeText");
         this.fightText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetHallowsLookItem.fightText");
         this.addChild(this.nameText);
         this.addChild(this.gradeText);
         this.addChild(this.fightText);
         this.nameText.text = this.petHallowsTempInfoGrade.TemplateName;
         this.nameText.y = 5 - (this.nameText.numLines - 1) * 7;
      }
    get viewRectangle() {
         return new ($.C("flash.geom.Rectangle"))(0,0,220,30);
      }
    set data(param1) {
         var _loc2_ = null;
         this._data = param1;
         if(this._data)
         {
            _loc2_ = $.C("yishi.manager.TempleteManager").instance.petHallowsTemplateCate.getTemplateById(this._data.hallowTempId);
            if(!_loc2_)
            {
               return;
            }
            this.gradeText.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc2_.Grades);
            this.fightText.text = this._data.lookFightPower + "";
            this.gradeText.setFrame(1);
            this.fightText.setFrame(1);
         }
         else
         {
            this.gradeText.text = $.C("manager.LanguageMgr").GetTranslation("faterotary.LevelMin");
            this.fightText.text = $.C("manager.LanguageMgr").GetTranslation("groupfb.GroupfbTeamItem.wait");
            this.gradeText.setFrame(2);
            this.fightText.setFrame(2);
         }
      }
    get petHallowsModel() {
         return $.C("yishi.manager.PetHallowsManager").instance.model;
      }
    get petHallowsTempInfoGrade() {
         return this.petHallowsModel.getHallowsTempInfoByTypeAndGrade(this._type,1);
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nameText);
         this.nameText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.fightText);
         this.fightText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nameText);
         this.nameText = null;
         super.dispose();
      }
    set viewRectangle(v) { super.viewRectangle = v; }
    get data() { return super.data; }
    set petHallowsModel(v) { super.petHallowsModel = v; }
    set petHallowsTempInfoGrade(v) { super.petHallowsTempInfoGrade = v; }
  }
  $.meta(__PetHallowsLookItem, "yishi.view.tips.PetHallowsLookItem", ["IManualSize"]);
  return __PetHallowsLookItem;
}
deps["yishi.view.tips.PetHallowsLookItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.geom.Rectangle", "manager.LanguageMgr", "yishi.manager.PetHallowsManager", "yishi.manager.TempleteManager"];

defs["yishi.view.tips.PetHallowsLookTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PetHallowsLookTips extends __Base {
    static $fields(self) {
    self.titleImage = null;
    self.nameText = null;
    self.stateText = null;
    self.fightText = null;
    self.vBox = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.titleImage = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.PetHallowsLookTips.titleBg");
         this.nameText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetHallowsLookTips.nameText");
         this.stateText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetHallowsLookTips.stateText");
         this.fightText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetHallowsLookTips.fightText");
         this.vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PetHallowsLookTips.vBox");
         this.addChild(this.titleImage);
         this.addChild(this.nameText);
         this.addChild(this.stateText);
         this.addChild(this.fightText);
         this.addChild(this.vBox);
         this.nameText.text = $.C("manager.LanguageMgr").GetTranslation("PetHallowsLookTips.nameText.text");
         this.stateText.text = $.C("manager.LanguageMgr").GetTranslation("PetHallowsLookTips.stateText.text");
         this.fightText.text = $.C("manager.LanguageMgr").GetTranslation("public.playerInfo.ap");
         this._bg.width = 225;
         this._bg.height = 120;
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc3_ = 0;
         var _loc4_ = 0;
         var _loc2_ = null;
         this.vBox.removeAllChild();
         if(this.tipData)
         {
            _loc1_ = $.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"));
            _loc3_ = this.petHallowsTempLengs;
            _loc4_ = 1;
            while(_loc4_ <= _loc3_)
            {
               _loc2_ = new ($.C("yishi.view.tips.PetHallowsLookItem"))(_loc4_);
               _loc2_.data = _loc1_.getLookPetHallowByType(_loc4_);
               this.vBox.addChild(_loc2_);
               _loc4_++;
            }
            this._bg.height = this.vBox.height + 40;
         }
      }
    get petHallowsTempLengs() {
         return $.C("yishi.manager.PetHallowsManager").instance.model.hallowsTempList.length;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.titleImage);
         this.titleImage = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.nameText);
         this.nameText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.stateText);
         this.stateText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.fightText);
         this.fightText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.vBox);
         this.vBox = null;
         super.dispose();
      }
    set petHallowsTempLengs(v) { super.petHallowsTempLengs = v; }
  }
  $.meta(__PetHallowsLookTips, "yishi.view.tips.PetHallowsLookTips", []);
  return __PetHallowsLookTips;
}
deps["yishi.view.tips.PetHallowsLookTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.playerinfo.ThaneInfo", "yishi.manager.PetHallowsManager", "yishi.view.tips.BaseTip", "yishi.view.tips.PetHallowsLookItem"];

defs["yishi.view.tips.PetTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PetTip extends __Base {
    static $fields(self) {
    self._blackKingBg = null;
    self._redBg = null;
    self._yellowBg = null;
    self._purpleBg = null;
    self._blueBg = null;
    self._greenBg = null;
    self._whiteBg = null;
    self.equipedTxt = null;
    self.content = null;
    self._state = false;
    self._type = 0;
    }
    constructor() {
         super();
      }
    set state(param1) {
         this._state = param1;
      }
    init() {
         super.init();
         this._blackKingBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blackItemTipsBg");
         this._redBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.redItemTipsBg");
         this._yellowBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.yellowItemTipsBg");
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._blueBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blueItemTipsBg");
         this._greenBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.greenItemTipsBg");
         this._whiteBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.whiteItemTipsBg");
         this.addChild(this._blackKingBg);
         this.addChild(this._redBg);
         this.addChild(this._yellowBg);
         this.addChild(this._purpleBg);
         this.addChild(this._blueBg);
         this.addChild(this._greenBg);
         this.addChild(this._whiteBg);
         this.equipedTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsEquiped_2");
         this.equipedTxt.y = 23;
         this.equipedTxt.width = 170;
         this.equipedTxt.x = 74;
         this.equipedTxt.text = $.C("manager.LanguageMgr").GetTranslation("PetTip.currentPet");
         this.content = new ($.C("yishi.view.tips.PetTipContent"))();
         this._bg.width = 287;
         this._bg.height = 310;
      }
    $$updateTransform() {
         var _loc1_ = 0;
         if(this.type == 1)
         {
            this.equipedTxt.text = $.C("manager.LanguageMgr").GetTranslation("PetTip.currentPet");
            this.addChild(this.equipedTxt);
            _loc1_ += this.equipedTxt.textHeight + 13;
            this.content.y = this.equipedTxt.y + this.equipedTxt.textHeight - 17;
         }
         else if(this.type == 2)
         {
            this.equipedTxt.text = $.C("manager.LanguageMgr").GetTranslation("PetTip.beforeCompose");
            this.addChild(this.equipedTxt);
            _loc1_ += this.equipedTxt.textHeight + 5;
            this.content.y = this.equipedTxt.y + this.equipedTxt.textHeight;
         }
         else if(this.type == 3)
         {
            this.equipedTxt.text = $.C("manager.LanguageMgr").GetTranslation("PetTip.afterCompose");
            this.addChild(this.equipedTxt);
            _loc1_ += this.equipedTxt.textHeight + 5;
            this.content.y = this.equipedTxt.y + this.equipedTxt.textHeight;
         }
         else
         {
            if(this.contains(this.equipedTxt))
            {
               this.removeChild(this.equipedTxt);
            }
            if(this._state)
            {
               this.equipedTxt.text = "";
               this.addChild(this.equipedTxt);
               _loc1_ += 27;
               this.content.y = this.equipedTxt.y + -3;
            }
            else
            {
               this.content.y = 0;
            }
         }
         this.addChild(this.content);
         if($.is(this.tipData, $.C("mvc.module.pet.PetData")))
         {
            this.content.data = $.as(this.tipData, $.C("mvc.module.pet.PetData"));
         }
         this._bg.height = _loc1_ + this.content.height + 17;
         this._blackKingBg.width = this._redBg.width = this._yellowBg.width = this._purpleBg.width = this._blueBg.width = this._greenBg.width = this._whiteBg.width = this._bg.width;
         this._blackKingBg.height = this._redBg.height = this._yellowBg.height = this._purpleBg.height = this._blueBg.height = this._greenBg.height = this._whiteBg.height = this._bg.height - 10;
         if(this.tipData)
         {
            this.showProfileBg(($.as(this.tipData, $.C("mvc.module.pet.PetData"))).quality);
         }
      }
    showProfileBg(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._blackKingBg.visible = this._redBg.visible = this._yellowBg.visible = this._purpleBg.visible = this._blueBg.visible = this._greenBg.visible = this._whiteBg.visible = this._bg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               this._whiteBg.visible = true;
               break;
            case 1:
               this._greenBg.visible = true;
               break;
            case 2:
               this._blueBg.visible = true;
               break;
            case 3:
               this._purpleBg.visible = true;
               break;
            case 4:
               this._yellowBg.visible = true;
               break;
            case 5:
               this._redBg.visible = true;
               break;
            case 6:
               this._blackKingBg.visible = true;
         }
      }
    get type() {
         return this._type;
      }
    set type(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._type = param1;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.equipedTxt);
         this.equipedTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.content);
         this.content = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._redBg);
         this._redBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._yellowBg);
         this._yellowBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._purpleBg);
         this._purpleBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blueBg);
         this._blueBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._greenBg);
         this._greenBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._whiteBg);
         this._whiteBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blackKingBg);
         this._blackKingBg = null;
         super.dispose();
      }
    get state() { return super.state; }
  }
  $.meta(__PetTip, "yishi.view.tips.PetTip", []);
  $.statics(__PetTip, () => {
    __PetTip.NONE = 0;
    __PetTip.EQUIPED = 1;
    __PetTip.COMPOSE1 = 2;
    __PetTip.COMPOSE2 = 3;
  });
  return __PetTip;
}
deps["yishi.view.tips.PetTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "mvc.module.pet.PetData", "yishi.view.tips.BaseTip", "yishi.view.tips.PetTipContent"];

defs["yishi.view.tips.PetTipContent"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PetTipContent extends __Base {
    static $fields(self) {
    self._nameTxt = null;
    self._bandTxt = null;
    self._gradeLabel = null;
    self._carrryGradeLabel = null;
    self._typeIcon = null;
    self._headIcon = null;
    self._line01 = null;
    self._line02 = null;
    self._line03 = null;
    self._vBox01 = null;
    self._growTxt = null;
    self._strengthTxt = null;
    self._armorTxt = null;
    self._intellectTxt = null;
    self._staminaTxt = null;
    self._awakenTxt = null;
    self._vBox03 = null;
    self._equipSprite = null;
    self._equip0 = null;
    self._equip1 = null;
    self._equip2 = null;
    self._equip3 = null;
    self._equip4 = null;
    self._equip5 = null;
    self._fightingCapacityLabel = null;
    self._fightingCapacityTxt = null;
    self._profileImg = null;
    self._hBox = null;
    self._petTypeList = null;
    self._data = null;
    }
    constructor() {
         super();
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("pet.petTypeList");
         this._petTypeList = _loc1_.split("|");
         this.init();
      }
    init() {
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.nameTxt");
         this._bandTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.bandTxt");
         this._bandTxt.x = 170;
         this._gradeLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.gradeLabel");
         this._carrryGradeLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.carryGradeLabel");
         this._typeIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.PetTypeImage");
         this._typeIcon.x = 240;
         this._headIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("petTip.headIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._profileImg.x = 10;
         this._profileImg.y = 10;
         this._line01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line03 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line01.width = 280;
         this._line02.width = 280;
         this._line03.width = 280;
         this.addChild(this._nameTxt);
         this.addChild(this._bandTxt);
         this.addChild(this._gradeLabel);
         this.addChild(this._carrryGradeLabel);
         this.addChild(this._typeIcon);
         this.addChild(this._headIcon);
         this.addChild(this._profileImg);
         this.addChild(this._line01);
         this._line01.y = 108;
         this.addChild(this._line02);
         this._line02.y = 230;
         this.addChild(this._line03);
         this._vBox01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.vbox01");
         this._growTxt = new ($.C("yishi.view.tips.PetAttributeItemView"))();
         this._strengthTxt = new ($.C("yishi.view.tips.PetAttributeItemView"))();
         this._armorTxt = new ($.C("yishi.view.tips.PetAttributeItemView"))();
         this._intellectTxt = new ($.C("yishi.view.tips.PetAttributeItemView"))();
         this._staminaTxt = new ($.C("yishi.view.tips.PetAttributeItemView"))();
         this._vBox01.addChild(this._growTxt);
         this._vBox01.addChild(this._strengthTxt);
         this._vBox01.addChild(this._armorTxt);
         this._vBox01.addChild(this._intellectTxt);
         this._vBox01.addChild(this._staminaTxt);
         this.addChild(this._vBox01);
         this._awakenTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.awakenSkillTxt");
         this._awakenTxt.y = 239;
         this._vBox03 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.vbox03");
         this._equipSprite = new ($.C("flash.display.Sprite"))();
         this._equipSprite.x = 10;
         this._equipSprite.y = 260;
         this.addChild(this._awakenTxt);
         this.addChild(this._equipSprite);
         this._equip0 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.petEquip0");
         this._equip1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.petEquip1");
         this._equip2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.petEquip2");
         this._equip3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.petEquip3");
         this._equip4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.petEquip4");
         this._equip5 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.petEquip5");
         this._equipSprite.addChild(this._equip0);
         this._equipSprite.addChild(this._equip1);
         this._equipSprite.addChild(this._equip2);
         this._equipSprite.addChild(this._equip3);
         this._equipSprite.addChild(this._equip4);
         this._equipSprite.addChild(this._equip5);
         this._fightingCapacityLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.fightingLabel");
         this._fightingCapacityTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.fightingTxt");
         this.addChild(this._fightingCapacityLabel);
         this.addChild(this._fightingCapacityTxt);
         this._hBox = new ($.C("com.pickgliss.ui.controls.container.HBox"))();
         this._hBox.spacing = 1;
         this.addChild(this._hBox);
         this._hBox.x = 185;
         this._hBox.y = 60;
         this._nameTxt.text = "";
         this._bandTxt.text = "";
         this._fightingCapacityLabel.text = $.C("manager.LanguageMgr").GetTranslation("public.playerInfo.ap");
         this._awakenTxt.text = $.C("manager.LanguageMgr").GetTranslation("PetTip.awakenSkill");
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         var _loc11_ = null;
         var _loc2_ = null;
         var _loc6_ = 0;
         var _loc7_ = 0;
         var _loc4_ = false;
         var _loc5_ = null;
         var _loc8_ = null;
         var _loc9_ = 0;
         var _loc3_ = null;
         var _loc10_ = 0;
         this._data = param1;
         if(!this._vBox03)
         {
            return;
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._vBox03);
         if($.is(param1, $.C("mvc.module.pet.PetData")))
         {
            _loc11_ = $.as(param1, $.C("mvc.module.pet.PetData"));
            this._nameTxt.text = _loc11_.name;
            this._nameTxt.setFrame(_loc11_.quality);
            if(this._hBox)
            {
               this._hBox.removeAllChild();
            }
            this.showStar();
            if(_loc11_.isBind)
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
               this._bandTxt.setFrame(1);
            }
            else
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
               this._bandTxt.setFrame(2);
            }
            this._bandTxt.text = _loc2_;
            this._gradeLabel.text = $.C("manager.LanguageMgr").GetTranslation("PetTip.grade",_loc11_.grade.toString());
            this._carrryGradeLabel.text = $.C("manager.LanguageMgr").GetTranslation("pet.PetFrame.carryGrade02",55);
            if(_loc11_.template)
            {
               _loc6_ = $.int(this._data.template.PetType.toString().charAt(2));
               this._carrryGradeLabel.text = $.C("manager.LanguageMgr").GetTranslation("pet.needGradeTxt" + this._data.template.NeedGrade,this._petTypeList[_loc6_ - 1]);
            }
            _loc7_ = this._data.template.PetType - 100;
            if(_loc7_ < 7)
            {
               this._typeIcon.setFrame(_loc7_);
            }
            else if(_loc7_ == 17)
            {
               this._typeIcon.setFrame(7);
            }
            else if(_loc7_ == 18)
            {
               this._typeIcon.setFrame(8);
            }
            else if(_loc7_ == 19)
            {
               this._typeIcon.setFrame(9);
            }
            this._headIcon.icon = $.C("yishi.utils.IconFactory").getPetHeadItemIcon(_loc11_.templateId);
            this._profileImg.setFrame(_loc11_.quality);
            if(_loc11_.initQuality < _loc11_.quality)
            {
               this._growTxt.setData($.C("manager.LanguageMgr").GetTranslation("PetTip.grow") + " " + _loc11_.growthRate.toString(),2);
            }
            else
            {
               this._growTxt.setData($.C("manager.LanguageMgr").GetTranslation("PetTip.grow") + " " + _loc11_.growthRate.toString(),6);
            }
            if(_loc11_.coeStrengthAdd > 0)
            {
               this._strengthTxt.setData($.C("manager.LanguageMgr").GetTranslation("pet.strengthCoe") + " " + _loc11_.coeStrength + " / " + _loc11_.coeStrengthLimit,2);
            }
            else
            {
               this._strengthTxt.setData($.C("manager.LanguageMgr").GetTranslation("pet.strengthCoe") + " " + _loc11_.coeStrength + " / " + _loc11_.coeStrengthLimit,6);
            }
            if(_loc11_.coeArmorAdd > 0)
            {
               this._armorTxt.setData($.C("manager.LanguageMgr").GetTranslation("pet.armorCoe") + " " + _loc11_.coeArmor + " / " + _loc11_.coeArmorLimit,2);
            }
            else
            {
               this._armorTxt.setData($.C("manager.LanguageMgr").GetTranslation("pet.armorCoe") + " " + _loc11_.coeArmor + " / " + _loc11_.coeArmorLimit,6);
            }
            if(_loc11_.coeIntellectAdd)
            {
               this._intellectTxt.setData($.C("manager.LanguageMgr").GetTranslation("pet.intellectCoe") + " " + _loc11_.coeIntellect + " / " + _loc11_.coeIntellectLimit,2);
            }
            else
            {
               this._intellectTxt.setData($.C("manager.LanguageMgr").GetTranslation("pet.intellectCoe") + " " + _loc11_.coeIntellect + " / " + _loc11_.coeIntellectLimit,6);
            }
            if(_loc11_.coeStaminaAdd)
            {
               this._staminaTxt.setData($.C("manager.LanguageMgr").GetTranslation("pet.staminaCoe") + " " + _loc11_.coeStamina + " / " + _loc11_.coeStaminaLimit,2);
            }
            else
            {
               this._staminaTxt.setData($.C("manager.LanguageMgr").GetTranslation("pet.staminaCoe") + " " + _loc11_.coeStamina + " / " + _loc11_.coeStaminaLimit,6);
            }
            _loc4_ = false;
            _loc5_ = this.playerInfo.petList;
            _loc9_ = 0;
            while(_loc9_ < _loc5_.length)
            {
               if(($.as(_loc5_[_loc9_], $.C("mvc.module.pet.PetData"))).petId == _loc11_.petId)
               {
                  _loc4_ = true;
                  break;
               }
               _loc9_++;
            }
            if(_loc4_)
            {
               _loc3_ = $.C("yishi.manager.GoodsManager").instance.getPetEquipListById(_loc11_.petId);
               for (_loc8_ of $.values(_loc3_))
               {
                  _loc11_.equipList.push(_loc8_);
               }
            }
            this._equip3.y = 80;
            this._equip4.y = 80;
            this._equip5.y = 80;
            _loc9_ = 0;
            while(_loc9_ < 6)
            {
               this["_equip" + _loc9_].data = null;
               this["_equip" + _loc9_].openState = true;
               _loc9_++;
            }
            for (_loc8_ of $.values(_loc11_.equipList))
            {
               this["_equip" + _loc8_.pos].data = _loc8_;
            }
            _loc10_ = this._equipSprite.y + this._equipSprite.height;
            this._line03.y = _loc10_ + 5;
            this._fightingCapacityLabel.y = _loc10_ + 15;
            this._fightingCapacityTxt.y = _loc10_ + 14;
            this._fightingCapacityTxt.text = _loc11_.fightPower.toString();
            this._fightingCapacityTxt.x = 270 - this._fightingCapacityTxt.textWidth + 10;
            this._fightingCapacityLabel.x = this._fightingCapacityTxt.x - this._fightingCapacityLabel.textWidth - 6;
         }
      }
    toArialBold(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
    showStar() {
         var _loc3_ = null;
         var _loc2_ = 0;
         var _loc5_ = 0;
         var _loc4_ = null;
         var _loc1_ = this.data.qualityUpgradeTemplateInfo;
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = this.data.temQuality % 5 == 0 ? 5 : this.data.temQuality % 5;
         if(this.data.temQuality > 25)
         {
            _loc3_ = "asset.pet.bigMoonLightLevelImg";
         }
         else
         {
            _loc3_ = "asset.pet.StarLevelLightImg";
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap(_loc3_);
            this._hBox.addChild(_loc4_);
            _loc5_++;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameTxt);
         this._nameTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bandTxt);
         this._bandTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeLabel);
         this._gradeLabel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._carrryGradeLabel);
         this._carrryGradeLabel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._typeIcon);
         this._typeIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headIcon);
         this._headIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line01);
         this._line01 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line02);
         this._line02 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox01);
         this._vBox01 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line03);
         this._line03 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._growTxt);
         this._growTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._strengthTxt);
         this._strengthTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._armorTxt);
         this._armorTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._intellectTxt);
         this._intellectTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._staminaTxt);
         this._staminaTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._vBox03);
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox03);
         this._vBox03 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._awakenTxt);
         this._awakenTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._profileImg);
         this._profileImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fightingCapacityLabel);
         this._fightingCapacityLabel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fightingCapacityTxt);
         this._fightingCapacityTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hBox);
         this._hBox = null;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__PetTipContent, "yishi.view.tips.PetTipContent", []);
  return __PetTipContent;
}
deps["yishi.view.tips.PetTipContent"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.HBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.pet.PetData", "yishi.manager.GoodsManager", "yishi.manager.PlayerManager", "yishi.utils.IconFactory", "yishi.view.tips.PetAttributeItemView"];

defs["yishi.view.tips.PlanesEventTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PlanesEventTips extends __Base {
    static $fields(self) {
    self.titleText = null;
    self.descText = null;
    self.needGradeText = null;
    self.needEnergyText = null;
    self.eventTempInfo = null;
    self.layerTempInfo = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.titleText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PlanesEventTips.titleText");
         this.descText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PlanesEventTips.descText");
         this.needGradeText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PlanesEventTips.needGradeText");
         this.needEnergyText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("PlanesEventTips.needEnergyText");
         this.addChild(this.titleText);
         this.addChild(this.descText);
         this.addChild(this.needGradeText);
         this.addChild(this.needEnergyText);
      }
    $$updateTransform() {
         var _loc1_ = 0;
         this.cleanData();
         if(this._data)
         {
            this.eventTempInfo = this._data.eventTemp;
            this.layerTempInfo = this._data.layerTemp;
            _loc1_ = $.int($.C("yishi.manager.PlanesWarManager").instance.model.getEventCostEnergyByResistance(this.layerTempInfo,this.eventTempInfo));
            this.titleText.text = this.eventTempInfo.Name;
            this.titleText.width = 180;
            this.titleText.y = 10 - (this.titleText.numLines - 1) * 10;
            if(this.eventTempInfo.Description != "")
            {
               this.descText.htmlText = this.eventTempInfo.Description;
            }
            if(this.eventTempInfo.NeedLevel != 0)
            {
               this.needGradeText.text = $.C("manager.LanguageMgr").GetTranslation("PlanesEventTips.needGradeText.tipData",this.eventTempInfo.NeedLevel);
            }
            if(this.eventTempInfo.EnergyCost != 0 && this.eventTempInfo && this.layerTempInfo)
            {
               this.needEnergyText.text = $.C("manager.LanguageMgr").GetTranslation("PlanesEventTips.needEnergyText.tipData",_loc1_);
            }
         }
         this.descText.height = this.descText.textHeight + 3;
         this.needGradeText.y = this.descText.y + this.descText.height + 5;
         this.needEnergyText.y = this.needGradeText.y + this.needGradeText.height + 5;
         this._bg.width = 200;
         this._bg.height = this.titleText.textHeight + this.descText.textHeight + this.needGradeText.textHeight + this.needEnergyText.textHeight + 50;
      }
    cleanData() {
         this.titleText.text = "";
         this.descText.text = "";
         this.needGradeText.text = "";
         this.needEnergyText.text = "";
      }
    dispose() {
         if(this.titleText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.titleText);
         }
         this.titleText = null;
         if(this.descText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.descText);
         }
         this.descText = null;
         if(this.needGradeText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.needGradeText);
         }
         this.needGradeText = null;
         if(this.needEnergyText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.needEnergyText);
         }
         this.needEnergyText = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__PlanesEventTips, "yishi.view.tips.PlanesEventTips", []);
  return __PlanesEventTips;
}
deps["yishi.view.tips.PlanesEventTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.manager.PlanesWarManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.PlanesRewardItemTip"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __PlanesRewardItemTip extends __Base {
    static $fields(self) {
    self.planesName = null;
    self._resiText = null;
    self.rewardsGoodsHbox = null;
    self._line = null;
    self.rewardsDic = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.planesName = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesRewardTip.planesNameText");
         this._resiText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesRewardTip.resiText");
         this.rewardsGoodsHbox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesRewardTip.rewardsGoodsHbox");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this.addChild(this.planesName);
         this.addChild(this._resiText);
         this.addChild(this.rewardsGoodsHbox);
         this.addChild(this._line);
         this._line.width = 200;
      }
    set data(param1) {
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc6_ = 0;
         if(!param1)
         {
            return;
         }
         this.rewardsGoodsHbox.removeAllChild();
         var _loc7_ = $.C("manager.LanguageMgr").GetTranslation("PlanesLeftView.layerInfoText.resiText");
         if(param1.hasOwnProperty("dic") && param1.dic)
         {
            _loc4_ = $.C("yishi.manager.TempleteManager").instance.planesTemplateCate.getTemplateByID(param1.planesTempId);
            this.planesName.text = _loc4_.PlanesName;
            this.rewardsDic = param1.dic;
         }
         for(var _loc8_ in this.rewardsDic)
         {
            if(_loc8_)
            {
               if(parseInt(_loc8_) >= 1 && parseInt(_loc8_) <= 7)
               {
                  if(this.rewardsDic[_loc8_] != 0)
                  {
                     _loc7_ += $.C("manager.LanguageMgr").GetTranslation("PlanesLeftView.layerInfoText.resiText" + _loc8_,this.rewardsDic[_loc8_]) + "  ";
                  }
               }
               else
               {
                  _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("planesRewardTip.BaseItemView");
                  _loc5_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
                  _loc5_.templateId = parseInt(_loc8_);
                  _loc5_.count = this.rewardsDic[_loc8_];
                  _loc2_.data = _loc5_;
                  this.rewardsGoodsHbox.addChild(_loc2_);
               }
            }
         }
         var _loc3_ = false;
         _loc6_ = 1;
         while(_loc6_ < 8)
         {
            if(this.rewardsDic[_loc6_] && this.rewardsDic[_loc6_] != 0)
            {
               _loc3_ = true;
               break;
            }
            _loc6_++;
         }
         if(!_loc3_)
         {
            this._resiText.htmlText = "";
         }
         else
         {
            this._resiText.htmlText = _loc7_;
         }
         this._resiText.height = this._resiText.textHeight + 5;
         this._resiText.y = this.planesName.y + this.planesName.textHeight + 5;
         this.rewardsGoodsHbox.y = this._resiText.y + this._resiText.height + 5;
         this._line.y = this.rewardsGoodsHbox.y + this.rewardsGoodsHbox.height + 5;
      }
    dispose() {
         if(this.rewardsGoodsHbox)
         {
            this.rewardsGoodsHbox.removeAllChild();
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.rewardsGoodsHbox);
            this.rewardsGoodsHbox = null;
         }
         if(this.planesName)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.planesName);
         }
         this.planesName = null;
         if(this._resiText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resiText);
         }
         this._resiText = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get data() { return super.data; }
  }
  $.meta(__PlanesRewardItemTip, "yishi.view.tips.PlanesRewardItemTip", ["Disposeable"]);
  return __PlanesRewardItemTip;
}
deps["yishi.view.tips.PlanesRewardItemTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.datas.goods.GoodsInfo", "yishi.manager.TempleteManager"];

defs["yishi.view.tips.PlanesRewardTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PlanesRewardTip extends __Base {
    static $fields(self) {
    self.titleText = null;
    self._line1 = null;
    self.vBox = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this.titleText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("planesRewardTip.titleText");
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this.vBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this.vBox.spacing = 2;
         this.addChild(this.titleText);
         this.addChild(this._line1);
         this.addChild(this.vBox);
         this._line1.width = 200;
         this._line1.y = 35;
         this.vBox.x = 5;
         this.vBox.y = 40;
         this.titleText.text = $.C("manager.LanguageMgr").GetTranslation("PlanesRewardTip.titleText");
      }
    $$updateTransform() {
         var _loc3_ = null;
         var _loc2_ = null;
         var _loc1_ = null;
         this.vBox.removeAllChild();
         if(this._data)
         {
            if(this._data.hasOwnProperty("dic") && this._data.dic)
            {
               for(var _loc4_ in this._data.dic)
               {
                  _loc3_ = {};
                  _loc2_ = $.C("yishi.manager.PlanesWarManager").instance.model.getPlanesInfoById($.int(_loc4_));
                  _loc3_.planesTempId = _loc2_.planesTemId;
                  _loc3_.dic = this._data.dic[_loc4_];
                  _loc1_ = new ($.C("yishi.view.tips.PlanesRewardItemTip"))();
                  _loc1_.data = _loc3_;
                  this.vBox.addChild(_loc1_);
               }
            }
         }
         this._bg.height = this.vBox.height + 60;
      }
    dispose() {
         if(this.titleText)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.titleText);
         }
         this.titleText = null;
         if(this._line1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         }
         this._line1 = null;
         if(this.vBox)
         {
            this.vBox.removeAllChild();
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__PlanesRewardTip, "yishi.view.tips.PlanesRewardTip", []);
  return __PlanesRewardTip;
}
deps["yishi.view.tips.PlanesRewardTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.manager.PlanesWarManager", "yishi.view.tips.BaseTip", "yishi.view.tips.PlanesRewardItemTip"];

defs["yishi.view.tips.PropertyTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __PropertyTip extends __Base {
    static $fields(self) {
    self._txt01 = null;
    self._txt02 = null;
    self._txt03 = null;
    self._txt04 = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._txt01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.propertyTipTxt01");
         this._txt02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.propertyTipTxt02");
         this._txt03 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.propertyTipTxt03");
         this.addChild(this._txt01);
         this.addChild(this._txt02);
         this.addChild(this._txt03);
      }
    $$updateTransform() {
         var _loc6_ = 0;
         var _loc7_ = null;
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc1_ = 0;
         var _loc8_ = 0;
         var _loc5_ = 0;
         var _loc9_ = 0;
         var _loc2_ = 0;
         if(this.tipData)
         {
            if(this.tipData.hasOwnProperty("tipType") && this.tipData.tipType == "titan_reduce_tip_type")
            {
               this._txt01.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.PropertyItem.tips02",this.tipData.nameValue,this.tipData.attValue);
               this._txt02.htmlText = this.tipData.grade;
               this._txt03.htmlText = this.tipData.upperLimit;
            }
            else
            {
               _loc6_ = $.int($.C("yishi.datas.ConfigInfoManager").instance.getMountRefiningSoulMaxValue());
               _loc7_ = $.as(this.tipData, $.C("mvc.module.mounts.PropertyInfo"));
               _loc3_ = $.C("manager.LanguageMgr").GetTranslation("mounts.command02").split(",");
               _loc4_ = $.int($.C("mvc.module.mounts.PropertyInfo").getPropertyValue(_loc7_.name));
               _loc1_ = _loc7_.grade * 5;
               _loc8_ = Math.ceil(_loc7_.addition * this.refiningSoulInfo.getSkillAddPercent() / 100);
               _loc5_ = Math.min(_loc8_,_loc6_);
               _loc9_ = $.int(this.refiningSoulInfo.getPropAddPercentByPropName(_loc7_.name));
               _loc2_ = Math.ceil(_loc5_ * _loc9_ / 100);
               if(_loc7_.addition - _loc1_ > 0)
               {
                  if(_loc2_ > 0)
                  {
                     this._txt01.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.PropertyItem.tips02",_loc3_[_loc4_],_loc1_ + " + " + (_loc7_.addition - _loc1_) + " + " + _loc2_);
                  }
                  else
                  {
                     this._txt01.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.PropertyItem.tips02",_loc3_[_loc4_],_loc1_ + " + " + (_loc7_.addition - _loc1_));
                  }
               }
               else if(_loc2_ > 0)
               {
                  this._txt01.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.PropertyItem.tips02",_loc3_[_loc4_],_loc1_ + " + " + _loc2_);
               }
               else
               {
                  this._txt01.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.PropertyItem.tips02",_loc3_[_loc4_],_loc1_);
               }
               this._txt02.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.PropertyItem.tips03",_loc3_[_loc4_],_loc7_.grade);
               this._txt03.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.PropertyItem.tips04",_loc7_.gradeMax);
            }
            this._bg.width = 260;
            this._bg.height = 87;
         }
      }
    get refiningSoulInfo() {
         return $.C("managers.MountsManager").instance.selfRefiningSoulInfo;
      }
    dispose() {
         this._txt01 = null;
         this._txt02 = null;
         this._txt03 = null;
         this._txt04 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
    set refiningSoulInfo(v) { super.refiningSoulInfo = v; }
  }
  $.meta(__PropertyTip, "yishi.view.tips.PropertyTip", []);
  return __PropertyTip;
}
deps["yishi.view.tips.PropertyTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.MountsManager", "mvc.module.mounts.PropertyInfo", "yishi.datas.ConfigInfoManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.RemainsExploreTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __RemainsExploreTip extends __Base {
    static $fields(self) {
    self._titleTxt = null;
    self._contentTxt = null;
    self._line = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._titleTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.commonTipText");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.commonTipText");
         this._titleTxt.x = 10;
         this._titleTxt.y = 8;
         this._line.x = 5;
         this._line.y = 49;
         this._contentTxt.x = 10;
         this._contentTxt.y = 57;
         this.addChild(this._titleTxt);
         this.addChild(this._line);
         this.addChild(this._contentTxt);
      }
    $$updateTransform() {
         if(this.tipData)
         {
            this._titleTxt.text = this.tipData.title;
            this._contentTxt.htmlText = this.tipData.content;
            this._contentTxt.height = this._contentTxt.textHeight + 10;
            this._contentTxt.width = this._contentTxt.textWidth + 10;
            this._bg.height = this._contentTxt.y + this._contentTxt.textHeight + 10;
            this._bg.width = this._contentTxt.x + this._contentTxt.textWidth + 25;
            this._line.width = this._bg.width - 15;
         }
      }
    dispose() {
         if(this._titleTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._titleTxt);
         }
         this._titleTxt = null;
         if(this._contentTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contentTxt);
         }
         this._contentTxt = null;
         if(this._line)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         }
         this._line = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__RemainsExploreTip, "yishi.view.tips.RemainsExploreTip", []);
  return __RemainsExploreTip;
}
deps["yishi.view.tips.RemainsExploreTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.RemotePetTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __RemotePetTip extends __Base {
    static $fields(self) {
    self._blackKingBg = null;
    self._redBg = null;
    self._yellowBg = null;
    self._purpleBg = null;
    self._blueBg = null;
    self._greenBg = null;
    self._whiteBg = null;
    self.content = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._blackKingBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blackItemTipsBg");
         this._redBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.redItemTipsBg");
         this._yellowBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.yellowItemTipsBg");
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._blueBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blueItemTipsBg");
         this._greenBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.greenItemTipsBg");
         this._whiteBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.whiteItemTipsBg");
         this.addChild(this._blackKingBg);
         this.addChild(this._redBg);
         this.addChild(this._yellowBg);
         this.addChild(this._purpleBg);
         this.addChild(this._blueBg);
         this.addChild(this._greenBg);
         this.addChild(this._whiteBg);
         this.content = new ($.C("yishi.view.tips.RemotePetTipContent"))();
         this._bg.width = 300;
         this._bg.height = 320;
      }
    $$updateTransform() {
         this.addChild(this.content);
         if($.is(this.tipData, $.C("mvc.module.pet.PetData")))
         {
            this.content.data = $.as(this.tipData, $.C("mvc.module.pet.PetData"));
         }
         this._bg.height = this.content.height + 20;
         this._blackKingBg.width = this._redBg.width = this._yellowBg.width = this._purpleBg.width = this._blueBg.width = this._greenBg.width = this._whiteBg.width = this._bg.width;
         this._blackKingBg.height = this._redBg.height = this._yellowBg.height = this._purpleBg.height = this._blueBg.height = this._greenBg.height = this._whiteBg.height = this._bg.height - 10;
         if(this.tipData)
         {
            this.showProfileBg(($.as(this.tipData, $.C("mvc.module.pet.PetData"))).quality);
         }
      }
    showProfileBg(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._blackKingBg.visible = this._redBg.visible = this._yellowBg.visible = this._purpleBg.visible = this._blueBg.visible = this._greenBg.visible = this._whiteBg.visible = this._bg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               this._whiteBg.visible = true;
               break;
            case 1:
               this._greenBg.visible = true;
               break;
            case 2:
               this._blueBg.visible = true;
               break;
            case 3:
               this._purpleBg.visible = true;
               break;
            case 4:
               this._yellowBg.visible = true;
               break;
            case 5:
               this._redBg.visible = true;
               break;
            case 6:
               this._blackKingBg.visible = true;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.content);
         this.content = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blackKingBg);
         this._blackKingBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._redBg);
         this._redBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._yellowBg);
         this._yellowBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._purpleBg);
         this._purpleBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blueBg);
         this._blueBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._greenBg);
         this._greenBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._whiteBg);
         this._whiteBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this);
         super.dispose();
      }
  }
  $.meta(__RemotePetTip, "yishi.view.tips.RemotePetTip", []);
  return __RemotePetTip;
}
deps["yishi.view.tips.RemotePetTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "mvc.module.pet.PetData", "yishi.view.tips.BaseTip", "yishi.view.tips.RemotePetTipContent"];

defs["yishi.view.tips.RemotePetTipContent"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __RemotePetTipContent extends __Base {
    static $fields(self) {
    self._nameTxt = null;
    self._bandTxt = null;
    self._gradeLabel = null;
    self._carrryGradeLabel = null;
    self._typeIcon = null;
    self._headIcon = null;
    self._profileImg = null;
    self._hBox = null;
    self._line01 = null;
    self._line02 = null;
    self._physicsAttackTxt = null;
    self._physicsDefenseTxt = null;
    self._magicAttackTxt = null;
    self._magicDefenseTxt = null;
    self._hpTxt = null;
    self._fireResTxt = null;
    self._windResTxt = null;
    self._waterResTxt = null;
    self._electResTxt = null;
    self._darkResTxt = null;
    self._lightResTxt = null;
    self._fightingCapacityLabel = null;
    self._fightingCapacityTxt = null;
    self._data = null;
    }
    constructor() {
         super();
         this.init();
      }
    init() {
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.nameTxt");
         this._bandTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.bandTxt");
         this._gradeLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.gradeLabel");
         this._carrryGradeLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.carryGradeLabel");
         this._typeIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.PetTypeImage");
         this._headIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("petTip.headIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._profileImg.x = 10;
         this._profileImg.y = 10;
         this._line01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line01.width = 280;
         this._line02.width = 280;
         this._physicsAttackTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTip.physicsAttackTxt");
         this._physicsDefenseTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTip.physicsDefenseTxt");
         this._magicAttackTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTip.magicAttackTxt");
         this._magicDefenseTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTip.magicDefenseTxt");
         this._hpTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTip.hpTxt");
         this._fireResTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTip.fireResTxt");
         this._windResTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTip.windResTxt");
         this._waterResTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTip.waterResTxt");
         this._electResTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTip.electResTxt");
         this._darkResTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTip.darkResTxt");
         this._lightResTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTip.lightResTxt");
         this.addChild(this._nameTxt);
         this.addChild(this._bandTxt);
         this.addChild(this._gradeLabel);
         this.addChild(this._carrryGradeLabel);
         this.addChild(this._typeIcon);
         this._typeIcon.x = 265;
         this._typeIcon.y = 13;
         this.addChild(this._headIcon);
         this.addChild(this._profileImg);
         this.addChild(this._line01);
         this._line01.y = 108;
         this.addChild(this._line02);
         this._line02.y = 285;
         this.addChild(this._physicsAttackTxt);
         this.addChild(this._physicsDefenseTxt);
         this.addChild(this._magicAttackTxt);
         this.addChild(this._magicDefenseTxt);
         this.addChild(this._hpTxt);
         this.addChild(this._fireResTxt);
         this.addChild(this._windResTxt);
         this.addChild(this._waterResTxt);
         this.addChild(this._electResTxt);
         this.addChild(this._darkResTxt);
         this.addChild(this._lightResTxt);
         this._fightingCapacityLabel = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.fightingLabel");
         this._fightingCapacityTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.fightingTxt");
         this.addChild(this._fightingCapacityLabel);
         this.addChild(this._fightingCapacityTxt);
         this._hBox = new ($.C("com.pickgliss.ui.controls.container.HBox"))();
         this._hBox.spacing = 1;
         this.addChild(this._hBox);
         this._hBox.x = 195;
         this._hBox.y = 60;
         this._nameTxt.text = "";
         this._bandTxt.text = "";
         this._fightingCapacityLabel.text = $.C("manager.LanguageMgr").GetTranslation("public.playerInfo.ap");
      }
    get data() {
         return this._data;
      }
    set data(param1) {
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc3_ = 0;
         this._data = param1;
         if($.is(param1, $.C("mvc.module.pet.PetData")))
         {
            _loc4_ = $.as(param1, $.C("mvc.module.pet.PetData"));
            this._nameTxt.text = _loc4_.name;
            this._nameTxt.setFrame(_loc4_.quality);
            if(this._hBox)
            {
               this._hBox.removeAllChild();
            }
            this.showStar();
            if(_loc4_.isBind)
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
               this._bandTxt.setFrame(1);
            }
            else
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
               this._bandTxt.setFrame(2);
            }
            this._bandTxt.text = _loc2_;
            this._gradeLabel.text = $.C("manager.LanguageMgr").GetTranslation("PetTip.grade",_loc4_.grade.toString());
            this._carrryGradeLabel.text = $.C("manager.LanguageMgr").GetTranslation("pet.PetFrame.carryGrade02",55);
            if(_loc4_.template)
            {
               this._carrryGradeLabel.text = _loc4_.getLevelString();
            }
            _loc3_ = this._data.template.PetType - 100;
            if(_loc3_ < 7)
            {
               this._typeIcon.setFrame(_loc3_);
            }
            else if(_loc3_ == 17)
            {
               this._typeIcon.setFrame(7);
            }
            else if(_loc3_ == 18)
            {
               this._typeIcon.setFrame(8);
            }
            else if(_loc3_ == 19)
            {
               this._typeIcon.setFrame(9);
            }
            this._headIcon.icon = $.C("yishi.utils.IconFactory").getPetHeadItemIcon(_loc4_.templateId);
            this._profileImg.setFrame(_loc4_.quality);
            this._physicsAttackTxt.text = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip06") + ": " + _loc4_.Attack;
            this._physicsDefenseTxt.text = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip07") + ": " + _loc4_.Defence;
            this._magicAttackTxt.text = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip08") + ": " + _loc4_.MagicAttack;
            this._magicDefenseTxt.text = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip09") + ": " + _loc4_.MagicDefence;
            this._hpTxt.text = $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip11") + ": " + _loc4_.Live;
            this._fireResTxt.text = $.C("manager.LanguageMgr").GetTranslation("pet.fireRes") + ": " + _loc4_.resFire;
            this._windResTxt.text = $.C("manager.LanguageMgr").GetTranslation("pet.windRes") + ": " + _loc4_.resWind;
            this._waterResTxt.text = $.C("manager.LanguageMgr").GetTranslation("pet.waterRes") + ": " + _loc4_.resWater;
            this._electResTxt.text = $.C("manager.LanguageMgr").GetTranslation("pet.electRes") + ": " + _loc4_.resElect;
            this._darkResTxt.text = $.C("manager.LanguageMgr").GetTranslation("pet.darkRes") + ": " + _loc4_.resDark;
            this._lightResTxt.text = $.C("manager.LanguageMgr").GetTranslation("pet.lightRes") + ": " + _loc4_.resLight;
            this._physicsAttackTxt.setFrame(1);
            this._physicsDefenseTxt.setFrame(1);
            this._magicAttackTxt.setFrame(1);
            this._magicDefenseTxt.setFrame(1);
            this._hpTxt.setFrame(1);
            this._fireResTxt.setFrame(1);
            this._windResTxt.setFrame(1);
            this._waterResTxt.setFrame(1);
            this._electResTxt.setFrame(1);
            this._darkResTxt.setFrame(1);
            this._lightResTxt.setFrame(1);
            this._fightingCapacityLabel.y = this._line02.y + 5;
            this._fightingCapacityTxt.y = this._line02.y + 5;
            this._fightingCapacityTxt.text = _loc4_.fightPower.toString();
            this._fightingCapacityTxt.x = 210;
            this._fightingCapacityLabel.x = 150;
         }
      }
    showStar() {
         var _loc3_ = null;
         var _loc2_ = 0;
         var _loc5_ = 0;
         var _loc4_ = null;
         var _loc1_ = this.data.qualityUpgradeTemplateInfo;
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = this.data.temQuality % 5 == 0 ? 5 : this.data.temQuality % 5;
         if(this.data.temQuality > 25)
         {
            _loc3_ = "asset.pet.bigMoonLightLevelImg";
         }
         else
         {
            _loc3_ = "asset.pet.StarLevelLightImg";
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap(_loc3_);
            this._hBox.addChild(_loc4_);
            _loc5_++;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameTxt);
         this._nameTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bandTxt);
         this._bandTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeLabel);
         this._gradeLabel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._carrryGradeLabel);
         this._carrryGradeLabel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._typeIcon);
         this._typeIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headIcon);
         this._headIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line01);
         this._line01 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line02);
         this._line02 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hBox);
         this._hBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._physicsAttackTxt);
         this._physicsAttackTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._physicsDefenseTxt);
         this._physicsDefenseTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._magicAttackTxt);
         this._magicAttackTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._magicDefenseTxt);
         this._magicDefenseTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hpTxt);
         this._hpTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fireResTxt);
         this._fireResTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._windResTxt);
         this._windResTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._waterResTxt);
         this._waterResTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._electResTxt);
         this._electResTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._darkResTxt);
         this._darkResTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._lightResTxt);
         this._lightResTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fightingCapacityLabel);
         this._fightingCapacityLabel = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fightingCapacityTxt);
         this._fightingCapacityTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this);
      }
  }
  $.meta(__RemotePetTipContent, "yishi.view.tips.RemotePetTipContent", []);
  return __RemotePetTipContent;
}
deps["yishi.view.tips.RemotePetTipContent"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.HBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.pet.PetData", "yishi.utils.IconFactory"];

defs["yishi.view.tips.RemotePetTurnTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __RemotePetTurnTip extends __Base {
    static $fields(self) {
    self._purpleBg = null;
    self._nameTxt = null;
    self._index = null;
    self._typeIcon = null;
    self._headIcon = null;
    self._profileImg = null;
    self._vBox = null;
    self._line01 = null;
    self._line02 = null;
    self._dropTxt = null;
    self._dropHox = null;
    self._fristTxt = null;
    self._fristHox = null;
    self._skillTxt = null;
    self._mopupValue = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.nameTxt");
         this._index = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.indexTxt");
         this._typeIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.PetTypeImage");
         this._headIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("petTip.headIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._profileImg.x = 10;
         this._profileImg.y = 10;
         this._line01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.vBox");
         this._line02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._dropTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.dropTxt");
         this._dropHox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.dropHox");
         this._fristTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.fristTxt");
         this._fristHox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.fristHox");
         this._skillTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.skillTxt");
         this._mopupValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.mopupValue");
         this._line01.width = 280;
         this._line02.width = 280;
         this.addChild(this._purpleBg);
         this.addChild(this._nameTxt);
         this._nameTxt.multiline = true;
         this._nameTxt.wordWrap = true;
         this._nameTxt.height = 40;
         this.addChild(this._index);
         this.addChild(this._typeIcon);
         this.addChild(this._headIcon);
         this.addChild(this._profileImg);
         this._profileImg.setFrame(4);
         this.addChild(this._line01);
         this._line01.y = 85;
         this.addChild(this._vBox);
         this._dropTxt.text = $.C("manager.LanguageMgr").GetTranslation("RemotePetTurnTip.dropTxt");
         this._fristTxt.text = $.C("manager.LanguageMgr").GetTranslation("RemotePetTurnTip.fristTxt");
         this._bg.width = 320;
         this._purpleBg.width = this._bg.width;
         this._bg.visible = false;
      }
    $$updateTransform() {
         var _loc7_ = null;
         var _loc5_ = 0;
         var _loc1_ = null;
         var _loc2_ = null;
         var _loc6_ = null;
         var _loc4_ = null;
         this.clean();
         if($.is(this._data, $.C("mvc.module.remotepet.RemotePetTurnItemInfo")))
         {
            if(this._dropHox)
            {
               this._dropHox.removeAllChild();
            }
            if(this._fristHox)
            {
               this._fristHox.removeAllChild();
            }
            _loc7_ = $.as(this._data, $.C("mvc.module.remotepet.RemotePetTurnItemInfo"));
            this._nameTxt.text = _loc7_.tempInfo.Name;
            this._nameTxt.setFrame(4);
            _loc5_ = $.int(_loc7_.tempInfo.Property);
            this._typeIcon.setFrame(_loc5_);
            this._headIcon.icon = $.C("yishi.utils.IconFactory").getCommonIconPath(_loc7_.tempInfo.Icon2);
            if(_loc7_.tempInfo.Type == 1)
            {
               this._index.text = $.C("manager.LanguageMgr").GetTranslation("RemotePetTurnTip.index",_loc7_.tempInfo.Index);
               this._vBox.addChild(this._dropTxt);
               if(_loc7_.tempInfo.DropItems)
               {
                  for (var _loc3_ of $.values(_loc7_.tempInfo.DropItems.split(",")))
                  {
                     if(_loc3_)
                     {
                        _loc1_ = _loc3_.split("|");
                        _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("RemotePetTurnTip.dropItem");
                        _loc6_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
                        _loc6_.templateId = _loc1_[0];
                        _loc6_.count = _loc1_[1];
                        _loc2_.data = _loc6_;
                        this._dropHox.addChild(_loc2_);
                     }
                  }
               }
               this._vBox.addChild(this._dropHox);
               this._vBox.addChild(this._fristTxt);
               this.creatFrist(_loc7_);
               this._vBox.addChild(this._fristHox);
               _loc4_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(_loc7_.tempInfo.Skill);
               if(_loc4_)
               {
                  this._skillTxt.text = $.C("manager.LanguageMgr").GetTranslation("RemotePetTurnTip.skillTxt",_loc4_.TemplateName);
                  this._skillTxt.height = this._skillTxt.numLines >= 2 ? 44 : 22;
                  this._vBox.addChild(this._skillTxt);
               }
               this._vBox.addChild(this._line02);
               if(_loc7_.tempInfo.SweepIndex > 1)
               {
                  this._mopupValue.text = $.C("manager.LanguageMgr").GetTranslation("RemotePetTurnTip.mopupValue",_loc7_.tempInfo.SweepIndex);
                  this._mopupValue.height = this._mopupValue.numLines >= 2 ? 44 : 22;
                  this._vBox.addChild(this._mopupValue);
               }
            }
            else
            {
               this._vBox.addChild(this._fristTxt);
               this.creatFrist(_loc7_);
               this._vBox.addChild(this._fristHox);
            }
         }
         this._bg.height = this._vBox.y + this._vBox.height + 10;
         this._purpleBg.height = this._bg.height - 10;
      }
    creatFrist(param1) {
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc4_ = null;
         if(param1.tempInfo.FirstDropItems)
         {
            for (var _loc3_ of $.values(param1.tempInfo.FirstDropItems.split(",")))
            {
               if(_loc3_)
               {
                  _loc2_ = _loc3_.split("|");
                  _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("RemotePetTurnTip.dropItem");
                  _loc4_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
                  _loc4_.templateId = _loc2_[0];
                  _loc4_.count = _loc2_[1];
                  _loc5_.data = _loc4_;
                  this._fristHox.addChild(_loc5_);
               }
            }
         }
      }
    clean() {
         this._index.text = "";
         this._vBox.removeAllChild();
      }
    dispose() {
         for (var _loc1_ of $.values(this._dropHox))
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         if(this._dropHox)
         {
            this._dropHox.removeAllChild();
         }
         for (var _loc2_ of $.values(this._fristHox))
         {
            _loc2_.dispose();
            _loc2_ = null;
         }
         if(this._fristHox)
         {
            this._fristHox.removeAllChild();
         }
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._purpleBg);
         this._purpleBg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nameTxt);
         this._nameTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._index);
         this._index = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._typeIcon);
         this._typeIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headIcon);
         this._headIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._profileImg);
         this._profileImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dropTxt);
         this._dropTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fristTxt);
         this._fristTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._headIcon);
         this._headIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._mopupValue);
         this._mopupValue = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dropHox);
         this._dropHox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._fristHox);
         this._fristHox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line01);
         this._line01 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line02);
         this._line02 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         this._vBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").removeChildAllChildren(this);
         super.dispose();
      }
  }
  $.meta(__RemotePetTurnTip, "yishi.view.tips.RemotePetTurnTip", []);
  return __RemotePetTurnTip;
}
deps["yishi.view.tips.RemotePetTurnTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "mvc.module.remotepet.RemotePetTurnItemInfo", "yishi.datas.goods.GoodsInfo", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.RuneStoneTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __RuneStoneTip extends __Base {
    static $fields(self) {
    self._title = null;
    self._blackKingBg = null;
    self._redBg = null;
    self._yellowBg = null;
    self._purpleBg = null;
    self._blueBg = null;
    self._greenBg = null;
    self._whiteBg = null;
    self._iconBack = null;
    self._itemIcon = null;
    self._profileImg = null;
    self._splitLine01 = null;
    self._totalBox = null;
    self._proItem = null;
    self._maxTxt = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 262;
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this._blackKingBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blackItemTipsBg");
         this._redBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.redItemTipsBg");
         this._yellowBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.yellowItemTipsBg");
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._blueBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blueItemTipsBg");
         this._greenBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.greenItemTipsBg");
         this._whiteBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.whiteItemTipsBg");
         this._iconBack = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core2.boxBg");
         this._itemIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._splitLine01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._maxTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodPriceText");
         this._splitLine01.width = 215;
         this._proItem = new ($.C("yishi.view.tips.goods.SkillTipItem"))();
         this._totalBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this.addChild(this._blackKingBg);
         this.addChild(this._redBg);
         this.addChild(this._yellowBg);
         this.addChild(this._purpleBg);
         this.addChild(this._blueBg);
         this.addChild(this._greenBg);
         this.addChild(this._whiteBg);
         this.addChild(this._iconBack);
         this._iconBack.x = 8;
         this._iconBack.y = -9;
         this.addChild(this._itemIcon);
         this._itemIcon.x = 9;
         this.addChild(this._profileImg);
         this._profileImg.x = 8;
         this.addChild(this._title);
         this._title.width = 195;
         this._title.x = 68;
         this.addChild(this._totalBox);
         this._totalBox.x = 10;
         this._totalBox.y = 58;
         this._totalBox.spacing = 20;
         this._maxTxt.x = 85;
      }
    getListByType(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc6_ = null;
         var _loc4_ = 0;
         var _loc5_ = $.C("yishi.manager.TempleteManager").instance.getTemplatesByType(160);
         var _loc3_ = $.int(_loc5_.length);
         var _loc2_ = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = _loc5_[_loc4_];
            if(_loc6_.TemplateId == param1)
            {
               _loc2_.push(_loc6_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
    $$updateTransform() {
         var _loc6_ = null;
         var _loc3_ = null;
         var _loc1_ = null;
         var _loc5_ = null;
         var _loc2_ = null;
         var _loc4_ = 0;
         if(this.tipData)
         {
            _loc6_ = $.as(this.tipData, $.C("yishi.datas.goods.GoodsInfo"));
            this._itemIcon.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(_loc6_.templateInfo.TemplateId);
            this._profileImg.setFrame(_loc6_.templateInfo.Profile);
            this._title.setFrame(_loc6_.templateInfo.Profile);
            this._title.text = _loc6_.templateInfo.TemplateName + "  " + $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc6_.strengthenGrade);
            this._title.height = 42;
            this._title.wordWrap = true;
            _loc3_ = this._data.templateInfo;
            _loc1_ = "";
            if(_loc6_.strengthenGrade > 0)
            {
               _loc5_ = $.C("yishi.manager.TempleteManager").instance.runeGemInfoCate.getInfo(_loc3_.SonType,_loc3_.Property1,_loc6_.strengthenGrade);
               _loc1_ = this.getPropertys(_loc5_);
            }
            else
            {
               _loc1_ = this.getPropertys(_loc3_);
            }
            _loc2_ = this.getListByType(_loc3_.SonType);
            _loc4_ = $.int(_loc2_[_loc2_.length - 1] ? _loc2_[_loc2_.length - 1].Grades : 0);
            this._maxTxt.text = $.C("manager.LanguageMgr").GetTranslation("runetip.max.tip",_loc4_);
            this._proItem.setSkillTxt(_loc1_);
            this._totalBox.removeAllChild();
            this._totalBox.beginChanges();
            this._totalBox.addChild(this._splitLine01);
            this._totalBox.addChild(this._proItem);
            this._totalBox.addChild(this._maxTxt);
            this._totalBox.commitChanges();
            this._bg.height = this._totalBox.y + this._totalBox.height + 20;
            this._blackKingBg.height = this._bg.height;
            this._redBg.height = this._bg.height;
            this._yellowBg.height = this._bg.height;
            this._purpleBg.height = this._bg.height;
            this._blueBg.height = this._bg.height;
            this._greenBg.height = this._bg.height;
            this._whiteBg.height = this._bg.height;
            this._blackKingBg.width = this._bg.width;
            this._redBg.width = this._bg.width;
            this._yellowBg.width = this._bg.width;
            this._purpleBg.width = this._bg.width;
            this._blueBg.width = this._bg.width;
            this._greenBg.width = this._bg.width;
            this._whiteBg.width = this._bg.width;
            this._blackKingBg.y = this._bg.y - 3;
            this._redBg.y = this._bg.y - 3;
            this._yellowBg.y = this._bg.y - 3;
            this._purpleBg.y = this._bg.y - 3;
            this._blueBg.y = this._bg.y - 3;
            this._greenBg.y = this._bg.y - 3;
            this._whiteBg.y = this._bg.y - 3;
            this.showProfileBg(_loc6_.templateInfo.Profile);
         }
      }
    getPropertys(param1) {
         var _loc2_ = null;
         var _loc7_ = 0;
         if(param1 == null)
         {
            return "";
         }
         var _loc6_ = ["Power","Agility","Intellect","Physique","Captain"];
         var _loc5_ = $.int(_loc6_.length);
         var _loc3_ = "";
         var _loc4_ = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc2_ = _loc6_[_loc7_];
            if(param1[_loc2_] > 0)
            {
               _loc4_ = $.int(param1[_loc2_]);
               _loc3_ = $.C("manager.LanguageMgr").GetTranslation("army.stone." + _loc2_,_loc4_);
               break;
            }
            _loc7_++;
         }
         return _loc3_;
      }
    showProfileBg(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._bg.visible = false;
         this._redBg.visible = false;
         this._yellowBg.visible = false;
         this._purpleBg.visible = false;
         this._blueBg.visible = false;
         this._greenBg.visible = false;
         this._whiteBg.visible = false;
         this._blackKingBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               this._whiteBg.visible = true;
               break;
            case 1:
               this._greenBg.visible = true;
               break;
            case 2:
               this._blueBg.visible = true;
               break;
            case 3:
               this._purpleBg.visible = true;
               break;
            case 4:
               this._yellowBg.visible = true;
               break;
            case 5:
               this._redBg.visible = true;
               break;
            case 6:
               this._blackKingBg.visible = true;
         }
      }
    dispose() {
         if(this._redBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._redBg);
         }
         this._redBg = null;
         if(this._yellowBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._yellowBg);
         }
         this._yellowBg = null;
         if(this._purpleBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._purpleBg);
         }
         this._purpleBg = null;
         if(this._blueBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blueBg);
         }
         this._blueBg = null;
         if(this._greenBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._greenBg);
         }
         this._greenBg = null;
         if(this._whiteBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._whiteBg);
         }
         this._whiteBg = null;
         if(this._blackKingBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blackKingBg);
         }
         this._blackKingBg = null;
         if(this._itemIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemIcon);
         }
         this._itemIcon = null;
         if(this._profileImg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._profileImg);
         }
         this._profileImg = null;
         if(this._totalBox)
         {
            this._totalBox.dispose();
         }
         this._totalBox = null;
         if(this._title)
         {
            this._title.dispose();
         }
         this._title = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._maxTxt);
         this._maxTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._proItem);
         this._proItem = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._iconBack);
         this._iconBack = null;
         super.dispose();
      }
  }
  $.meta(__RuneStoneTip, "yishi.view.tips.RuneStoneTip", []);
  return __RuneStoneTip;
}
deps["yishi.view.tips.RuneStoneTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.goods.GoodsInfo", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.SkillTipItem"];

defs["yishi.view.tips.ShopMainTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ShopMainTips extends __Base {
    static $fields(self) {
    self._title = null;
    self._describe = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 240;
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText");
         this._describe = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodDescribeText");
         this.addChild(this._title);
         this.addChild(this._describe);
         this._title.x = 10;
         this._title.y = 10;
         this._describe.x = 10;
         this._describe.y = 34;
      }
    $$updateTransform() {
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.ShopMainTips.InnerContain");
         if(this.tipData)
         {
            this._title.text = this.tipData.name;
            this._describe.htmlText = $.C("manager.LanguageMgr").GetTranslation("public.colon",_loc1_) + this.tipData.content;
            this._describe.height = this._describe.textHeight + 5;
            this._bg.height = this._describe.y + this._describe.textHeight + 12;
         }
      }
    dispose() {
         if(this._title)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         }
         this._title = null;
         if(this._describe)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._describe);
         }
         this._describe = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ShopMainTips, "yishi.view.tips.ShopMainTips", []);
  return __ShopMainTips;
}
deps["yishi.view.tips.ShopMainTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.SinglePassRewardTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __SinglePassRewardTip extends __Base {
    static $fields(self) {
    self._vBox = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassVBox");
         this.addChild(this._vBox);
      }
    $$updateTransform() {
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc6_ = null;
         var _loc1_ = null;
         var _loc3_ = null;
         if(this.tipData)
         {
            this._vBox.removeAllChild();
            _loc4_ = $.as(this.tipData, $.C("mvc.module.singlepass.SinglePassTipData"));
            if(_loc4_.type == 0)
            {
               for (_loc2_ of $.values(_loc4_.drops1))
               {
                  _loc6_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc2_.ItemId);
                  if(_loc6_)
                  {
                     _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                     _loc1_.setFrame(_loc6_.Profile);
                     _loc1_.text = _loc6_.TemplateName + "*" + _loc2_.Count;
                     this._vBox.addChild(_loc1_);
                  }
               }
            }
            else if(_loc4_.type == 1)
            {
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassTitleTxt1");
               _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt01");
               this._vBox.addChild(_loc1_);
               for (_loc5_ of $.values(_loc4_.drops1))
               {
                  if(_loc5_.Type == 0)
                  {
                     _loc6_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc5_.ItemId);
                     if(_loc6_)
                     {
                        _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc6_.Profile);
                        _loc1_.text = _loc6_.TemplateName + "*" + _loc5_.Count;
                        this._vBox.addChild(_loc1_);
                     }
                  }
               }
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassTitleTxt2");
               _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt02");
               this._vBox.addChild(_loc1_);
               for (_loc5_ of $.values(_loc4_.drops1))
               {
                  if(_loc5_.Type == 2)
                  {
                     _loc6_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc5_.ItemId);
                     if(_loc6_)
                     {
                        _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc6_.Profile);
                        _loc1_.text = _loc6_.TemplateName + "*" + _loc5_.Count;
                        this._vBox.addChild(_loc1_);
                     }
                  }
               }
            }
            else if(_loc4_.type == 2)
            {
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassTitleTxt2");
               _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt03");
               this._vBox.addChild(_loc1_);
               for (_loc5_ of $.values(_loc4_.drops1))
               {
                  if(_loc5_.Type == 2)
                  {
                     _loc6_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc5_.ItemId);
                     if(_loc6_)
                     {
                        _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc6_.Profile);
                        _loc1_.text = _loc6_.TemplateName + "*" + _loc5_.Count;
                        this._vBox.addChild(_loc1_);
                     }
                  }
               }
            }
            else if(_loc4_.type == 3)
            {
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassTitleTxt1");
               _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt01");
               this._vBox.addChild(_loc1_);
               for (_loc5_ of $.values(_loc4_.drops1))
               {
                  if(_loc5_.Type == 1)
                  {
                     _loc6_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc5_.ItemId);
                     if(_loc6_)
                     {
                        _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc6_.Profile);
                        _loc1_.text = _loc6_.TemplateName + "*" + _loc5_.Count;
                        this._vBox.addChild(_loc1_);
                     }
                  }
               }
               _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.TaskTraceLine");
               this._vBox.addChild(_loc3_);
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ringtask.rewaredTitle");
               _loc1_.x = 0;
               _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.SinglePassRewardTip.firstKill");
               this._vBox.addChild(_loc1_);
               for (_loc5_ of $.values(_loc4_.drops2))
               {
                  if(_loc5_.Type == 3)
                  {
                     _loc6_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc5_.ItemId);
                     if(_loc6_)
                     {
                        _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc6_.Profile);
                        _loc1_.text = _loc6_.TemplateName + "*" + _loc5_.Count;
                        this._vBox.addChild(_loc1_);
                     }
                  }
               }
               if(!$.C("yishi.utils.StringHelper").isNullOrEmpty(_loc4_.firstName))
               {
                  _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                  _loc1_.setFrame(8);
                  _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.SinglePassRewardTip.hasGetBy",_loc4_.firstName);
                  this._vBox.addChild(_loc1_);
               }
               _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.TaskTraceLine");
               this._vBox.addChild(_loc3_);
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ringtask.rewaredTitle");
               _loc1_.x = 0;
               _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt05");
               this._vBox.addChild(_loc1_);
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               _loc1_.setFrame(8);
               _loc1_.text = _loc4_.maxScore + "";
               this._vBox.addChild(_loc1_);
            }
            this._vBox.refreshChildPos();
            this._bg.width = this._vBox.displayWidth + 20;
            this._bg.height = this._vBox.displayHeight + 20;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         this._vBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
  }
  $.meta(__SinglePassRewardTip, "yishi.view.tips.SinglePassRewardTip", []);
  return __SinglePassRewardTip;
}
deps["yishi.view.tips.SinglePassRewardTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "mvc.module.singlepass.SinglePassTipData", "yishi.manager.TempleteManager", "yishi.utils.StringHelper", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.SkyStepTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __SkyStepTip extends __Base {
    static $fields(self) {
    self._txt = null;
    self._hBox = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 155;
         this._bg.height = 240;
         this._txt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("skyStepTip.txt");
         this._hBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("skyStepTip.hBox");
         this.addChild(this._txt);
         this.addChild(this._hBox);
         this._txt.text = $.C("manager.LanguageMgr").GetTranslation("skyStepTip.txt");
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc1_ = null;
         if(this.tipData != null)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._hBox);
            this._hBox.beginChanges();
            _loc1_ = $.as(this.tipData, "Array");
            for (var _loc3_ of $.values(_loc1_))
            {
               _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("skyStepTip.BaseItemView");
               _loc2_.data = _loc3_;
               this._hBox.addChild(_loc2_);
            }
            this._hBox.commitChanges();
            this._bg.height = this._hBox.y + this._hBox.height + 10;
            this._bg.width = Math.max(this._txt.width,this._hBox.width) + this._hBox.x + 15;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__SkyStepTip, "yishi.view.tips.SkyStepTip", []);
  return __SkyStepTip;
}
deps["yishi.view.tips.SkyStepTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.SkyboxRaodRewardTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __SkyboxRaodRewardTips extends __Base {
    static $fields(self) {
    self._vBox = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassVBox");
         this.addChild(this._vBox);
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc1_ = null;
         var _loc4_ = 0;
         var _loc3_ = null;
         if(this.tipData != "")
         {
            this._vBox.removeAllChild();
            _loc2_ = String(this.tipData).split("|");
            if(_loc2_[0] == "1")
            {
               _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassTitleTxt1");
               _loc1_.text = $.C("manager.LanguageMgr").GetTranslation("singlepass.view.SinglePassCardItemView.TipsTxt01");
               this._vBox.addChild(_loc1_);
            }
            _loc4_ = 1;
            while(_loc4_ < _loc2_.length)
            {
               _loc3_ = String(_loc2_[_loc4_]).split(",");
               switch(_loc3_[1])
               {
                  case -100:
                  case -700:
                  case -1200:
                     break;
                  default:
                     _loc5_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc3_[1]);
                     if(_loc5_)
                     {
                        _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                        _loc1_.setFrame(_loc5_.Profile);
                        _loc1_.text = _loc5_.TemplateName + "*" + _loc3_[2];
                        this._vBox.addChild(_loc1_);
                     }
               }
               _loc4_++;
            }
            this._vBox.refreshChildPos();
            this._bg.width = this._vBox.displayWidth + 20;
            this._bg.height = this._vBox.displayHeight + 20;
         }
      }
  }
  $.meta(__SkyboxRaodRewardTips, "yishi.view.tips.SkyboxRaodRewardTips", []);
  return __SkyboxRaodRewardTips;
}
deps["yishi.view.tips.SkyboxRaodRewardTips"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.SpiritExpeditionNodeTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __SpiritExpeditionNodeTips extends __Base {
    static $fields(self) {
    self._purpleBg = null;
    self._nameTxt = null;
    self._index = null;
    self._headIcon = null;
    self._profileImg = null;
    self._vBox = null;
    self._line01 = null;
    self._dropTxt = null;
    self._dropHox = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.nameTxt");
         this._index = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.indexTxt");
         this._headIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("petTip.headIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._line01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._vBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.vBox");
         this._dropTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.dropTxt");
         this._dropHox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("RemotePetTurnTip.dropHox");
         this._profileImg.x = 10;
         this._profileImg.y = 10;
         this._line01.width = 280;
         this.addChild(this._purpleBg);
         this.addChild(this._nameTxt);
         this._nameTxt.multiline = true;
         this._nameTxt.wordWrap = true;
         this._nameTxt.height = 40;
         this.addChild(this._index);
         this.addChild(this._headIcon);
         this.addChild(this._profileImg);
         this._profileImg.setFrame(4);
         this.addChild(this._line01);
         this._line01.y = 85;
         this.addChild(this._vBox);
         this._dropTxt.text = $.C("manager.LanguageMgr").GetTranslation("SpiritExpeditionNodeTips.dropTxt.text");
         this._bg.width = 284;
         this._purpleBg.width = this._bg.width;
         this._bg.visible = false;
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc4_ = 0;
         var _loc1_ = null;
         var _loc5_ = null;
         this.clean();
         if($.is(this._data, $.C("yishi.datas.templates.SpiritExpeditionTempInfo")))
         {
            if(this._dropHox)
            {
               this._dropHox.removeAllChild();
            }
            _loc2_ = $.as(this._data, $.C("yishi.datas.templates.SpiritExpeditionTempInfo"));
            if(_loc2_.bossTemp)
            {
               this._nameTxt.text = _loc2_.bossTemp.TemplateName;
               this._headIcon.icon = $.C("yishi.utils.IconFactory").getHeroicon(_loc2_.bossTemp.TemplateId);
            }
            else if(_loc2_.npcTemp)
            {
               this._nameTxt.text = _loc2_.npcTemp.Name;
               this._headIcon.icon = $.C("yishi.utils.IconFactory").getSoldierIconByIcon(_loc2_.npcTemp.Icon);
            }
            this._nameTxt.setFrame(4);
            this._index.text = _loc2_.AreaId + "-" + _loc2_.NodeId;
            this._vBox.addChild(this._dropTxt);
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.spiritExpeditionFightDropTempCate.getTemplatesByAreaAndNode(_loc2_.AreaId,_loc2_.NodeId);
            if(_loc3_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("RemotePetTurnTip.dropItem");
                  _loc5_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
                  _loc5_.templateId = _loc3_[_loc4_].itemId;
                  _loc5_.count = _loc3_[_loc4_].count;
                  _loc1_.data = _loc5_;
                  this._dropHox.addChild(_loc1_);
                  _loc4_++;
               }
            }
            this._vBox.addChild(this._dropHox);
         }
         this._bg.height = this._vBox.y + this._vBox.height + 10;
         this._purpleBg.height = this._bg.height - 10;
      }
    clean() {
         this._index.text = "";
         this._nameTxt.text = "";
         this._vBox.removeAllChild();
      }
    dispose() {
         super.dispose();
      }
  }
  $.meta(__SpiritExpeditionNodeTips, "yishi.view.tips.SpiritExpeditionNodeTips", []);
  return __SpiritExpeditionNodeTips;
}
deps["yishi.view.tips.SpiritExpeditionNodeTips"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "yishi.datas.goods.GoodsInfo", "yishi.datas.templates.SpiritExpeditionTempInfo", "yishi.manager.TempleteManager", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.TechnologyTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __TechnologyTip extends __Base {
    static $fields(self) {
    self._vBox = null;
    self._line1 = null;
    self._line2 = null;
    self._name = null;
    self._current = null;
    self._currentEffect = null;
    self._currentEffectValue = null;
    self._next = null;
    self._nextEffect = null;
    self._nextEffectValue = null;
    self._nextGrade = null;
    self._gradeContain = null;
    self._grade = null;
    self._gradeValue = null;
    self._preContain = null;
    self._preBuild = null;
    self._preBuildValue = null;
    self._resource = null;
    self._needResource = null;
    self._needResourceValue = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 280;
         this._vBox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._vBox.y = 10;
         this._vBox.spacing = 5;
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._line2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._line1.width = this._line2.width = this._bg.width - 15;
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildNameText");
         this._currentEffect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectText");
         this._currentEffectValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectValueText");
         this._nextEffect = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectText");
         this._nextEffectValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectValueText");
         this._nextGrade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildNextGradeText");
         this._preBuild = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildText");
         this._preBuildValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildValueText");
         this._preBuildValue.x = 153;
         this._grade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildText");
         this._gradeValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildValueText");
         this._needResource = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildText");
         this._needResource.y = 4;
         this._needResourceValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildPreBuildResourcesValueText");
         this._needResourceValue.y = 4;
         this._current = new ($.C("flash.display.Sprite"))();
         this._current.addChild(this._currentEffect);
         this._current.addChild(this._currentEffectValue);
         this._next = new ($.C("flash.display.Sprite"))();
         this._next.addChild(this._nextEffect);
         this._next.addChild(this._nextEffectValue);
         this._gradeContain = new ($.C("flash.display.Sprite"))();
         this._gradeContain.addChild(this._grade);
         this._gradeContain.addChild(this._gradeValue);
         this._preContain = new ($.C("flash.display.Sprite"))();
         this._preContain.addChild(this._preBuild);
         this._preContain.addChild(this._preBuildValue);
         this._resource = new ($.C("com.pickgliss.ui.core.Component"))();
         this.addChild(this._vBox);
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc2_ = null;
         if(this.tipData)
         {
            this._vBox.removeAllChild();
            _loc1_ = ($.as(this.tipData, $.C("mvc.module.buildings.BuildInfo"))).templeteInfo;
            this._name.text = _loc1_.BuildingName + " " + $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc1_.BuildingGrade);
            this._currentEffect.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.TechnologyTip.currentGrade");
            this._currentEffectValue.text = _loc1_.Activity;
            this._currentEffectValue.height = this._currentEffectValue.textHeight + 4;
            this._vBox.addChild(this._name);
            this._vBox.addChild(this._line1);
            this._vBox.addChild(this._current);
            _loc2_ = this.getNextGrade(_loc1_);
            if(!_loc2_)
            {
               this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.TechnologyTip.topGrade");
               this._vBox.addChild(this._line2);
               this._vBox.addChild(this._nextGrade);
            }
            else
            {
               this.refreshNextTemp(_loc2_);
               this.refreshPlayerGrade(_loc2_);
               this.refreshPreBuild(_loc2_);
               this.refreshResource(_loc2_);
            }
            this._vBox.refreshChildPos();
            this._bg.height = this._vBox.displayHeight + 20;
            this._bg.width = this._vBox.width + 20;
         }
      }
    refreshNextTemp(param1) {
         if(param1)
         {
            this._nextEffect.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.TechnologyTip.nextEffect.text");
            this._nextEffectValue.text = param1.Activity;
            this._nextEffectValue.height = this._nextEffectValue.textHeight + 4;
            this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.TechnologyTip.nextGrade.text");
            this._vBox.addChild(this._next);
            this._vBox.addChild(this._line2);
            this._vBox.addChild(this._nextGrade);
         }
      }
    refreshPlayerGrade(param1) {
         if(param1 && this.thane.grades < param1.PlayerGrades)
         {
            this._grade.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.TechnologyTip.grade.text");
            this._gradeValue.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.TechnologyTip.gradeValue.text") + " " + $.C("manager.LanguageMgr").GetTranslation("public.level2",param1.PlayerGrades);
            this._gradeValue.height = this._gradeValue.textHeight + 4;
            this._gradeValue.setFrame(2);
            this._vBox.addChild(this._gradeContain);
         }
      }
    refreshPreBuild(param1) {
         var _loc4_ = null;
         var _loc2_ = false;
         var _loc3_ = $.C("yishi.manager.BuildingManager").instance.getPreBuildingList(param1);
         if(_loc3_.length == 0)
         {
            return;
         }
         for (var _loc5_ of $.values(_loc3_))
         {
            _loc4_ = $.C("yishi.manager.BuildingManager").instance.getBuildingInfoBySonType(_loc5_.SonType);
            if(!_loc4_ || _loc4_.templeteInfo.BuildingGrade < _loc5_.BuildingGrade)
            {
               this._preBuild.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.TechnologyTip.preBuild.text");
               this._preBuildValue.text = _loc5_.BuildingName + " " + $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc5_.BuildingGrade);
               this._preBuildValue.height = this._preBuildValue.textHeight + 4;
               this._preBuildValue.setFrame(2);
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            this._vBox.addChild(this._preContain);
         }
      }
    refreshResource(param1) {
         var _loc4_ = null;
         var _loc3_ = null;
         while(this._resource.numChildren > 0)
         {
            this._resource.removeChildAt(0);
         }
         if(this._data)
         {
            _loc4_ = ($.as(this.tipData, $.C("mvc.module.buildings.BuildInfo"))).getNextNeedResource(param1);
         }
         else
         {
            _loc4_ = new ($.C("flash.utils.Dictionary"))();
            _loc4_["CrystalsConsume"] = param1.CrystalsConsume;
            _loc4_["GoldConsume"] = param1.GoldConsume;
            _loc4_["PopuliationConsume"] = param1.PopuliationConsume;
         }
         for(var _loc2_ in _loc4_)
         {
            if(_loc4_[_loc2_] != 0)
            {
               this._needResource.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.TechnologyTip.needResource.text");
               this._needResourceValue.text = String(_loc4_[_loc2_]);
               switch(_loc2_)
               {
                  case "CrystalsConsume":
                     _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.CrystalIcon");
                     if(_loc4_[_loc2_] > $.C("yishi.manager.ResourceManager").instance.waterCrystal.count)
                     {
                        this._needResourceValue.setFrame(2);
                     }
                     else
                     {
                        this._needResourceValue.setFrame(1);
                     }
                     break;
                  case "GoldConsume":
                     if(_loc4_[_loc2_] > $.C("yishi.manager.ResourceManager").instance.gold.count)
                     {
                        this._needResourceValue.setFrame(2);
                     }
                     else
                     {
                        this._needResourceValue.setFrame(1);
                     }
                     _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.resourcesBar.GoldIcoImg");
                     break;
                  case "PopuliationConsume":
                     _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.resourcesBar.PopulationIcoImg");
                     break;
                  default:
                     return;
               }
               this._resource.addChild(_loc3_);
               this._resource.addChild(this._needResource);
               this._resource.addChild(this._needResourceValue);
               this._vBox.addChild(this._resource);
            }
         }
         _loc3_.x = 145;
         this._needResourceValue.x = _loc3_.x + _loc3_.width;
      }
    get playerEffect() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerEffect;
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    getNextGrade(param1) {
         if(param1.NextGradeTemplateId != 0)
         {
            return $.C("yishi.manager.TempleteManager").instance.buildTemplateCate.getTemplateByID($.int(param1.NextGradeTemplateId));
         }
         return null;
      }
    dispose() {
         if(this._line1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         }
         this._line1 = null;
         if(this._line2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line2);
         }
         this._line2 = null;
         if(this._name)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         }
         this._name = null;
         if(this._current)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._current);
         }
         this._current = null;
         if(this._currentEffect)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentEffect);
         }
         this._currentEffect = null;
         if(this._currentEffectValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._currentEffectValue);
         }
         this._currentEffectValue = null;
         if(this._next)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._next);
         }
         this._next = null;
         if(this._nextEffect)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextEffect);
         }
         this._nextEffect = null;
         if(this._nextEffectValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextEffectValue);
         }
         this._nextEffectValue = null;
         if(this._nextGrade)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._nextGrade);
         }
         this._nextGrade = null;
         if(this._preContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._preContain);
         }
         this._preContain = null;
         if(this._gradeContain)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeContain);
         }
         this._gradeContain = null;
         if(this._grade)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._grade);
         }
         this._grade = null;
         if(this._gradeValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gradeValue);
         }
         this._gradeValue = null;
         if(this._preBuild)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._preBuild);
         }
         this._preBuild = null;
         if(this._preBuildValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._preBuildValue);
         }
         this._preBuildValue = null;
         if(this._resource)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._resource);
         }
         this._resource = null;
         if(this._needResource)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._needResource);
         }
         this._needResource = null;
         if(this._needResourceValue)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._needResourceValue);
         }
         this._needResourceValue = null;
         if(this._vBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vBox);
         }
         this._vBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set playerEffect(v) { super.playerEffect = v; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__TechnologyTip, "yishi.view.tips.TechnologyTip", []);
  return __TechnologyTip;
}
deps["yishi.view.tips.TechnologyTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.ui.core.Component", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.utils.Dictionary", "manager.LanguageMgr", "mvc.module.buildings.BuildInfo", "yishi.manager.ArmyManager", "yishi.manager.BuildingManager", "yishi.manager.PlayerManager", "yishi.manager.ResourceManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.ThaneTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __ThaneTip extends __Base {
    static $fields(self) {
    self._totalVBox = null;
    self._levelHBox = null;
    self._jobHBox = null;
    self._combatPowerHBox = null;
    self._name = null;
    self._level = null;
    self._job = null;
    self._combatPower = null;
    self._levelVal = null;
    self._jobVal = null;
    self._combatPowerVal = null;
    self._line1 = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 260;
         this._bg.height = 115;
         this._totalVBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.TipContain");
         this._levelHBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._jobHBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._combatPowerHBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tip.TipItemBox");
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ThaneNameText");
         this._level = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ThaneLevelText");
         this._job = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ThaneLevelText");
         this._combatPower = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.CombatPowerText");
         this._level.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.HeroTip.level");
         this._job.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.HeroTip.vocation");
         this._combatPower.text = $.C("manager.LanguageMgr").GetTranslation("public.playerInfo.ap");
         this._levelVal = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ThaneLevelValueText");
         this._jobVal = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ThaneLevelValueText");
         this._combatPowerVal = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.CombatPowerText");
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.PawnTipLine1");
         this._levelHBox.addChild(this._level);
         this._levelHBox.addChild(this._levelVal);
         this._jobHBox.addChild(this._job);
         this._jobHBox.addChild(this._jobVal);
         this._combatPowerHBox.addChild(this._combatPower);
         this._combatPowerHBox.addChild(this._combatPowerVal);
         this._totalVBox.addChild(this._name);
         this._totalVBox.addChild(this._levelHBox);
         this._totalVBox.addChild(this._jobHBox);
         this._totalVBox.addChild(this._line1);
         this._totalVBox.addChild(this._combatPowerHBox);
         this.addChild(this._totalVBox);
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc1_ = null;
         if(this.tipData)
         {
            if($.is(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo")))
            {
               _loc2_ = $.as(this.tipData, $.C("yishi.datas.playerinfo.ThaneInfo"));
               this._name.text = _loc2_.nickName;
               this._levelVal.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc2_.grades);
               this._jobVal.text = $.C("yishi.datas.consant.JobType").getJobName(_loc2_.templateInfo.Job);
               this._combatPowerVal.text = this.getCombatPower(_loc2_.userId,_loc2_.serviceName);
            }
            else if($.is(this.tipData, $.C("mvc.module.children.ChildData")))
            {
               _loc3_ = $.as(this.tipData, $.C("mvc.module.children.ChildData"));
               _loc1_ = $.C("yishi.manager.TempleteManager").instance.childTemplateCate.getTemplateByJobAndGrades(_loc3_.job,_loc3_.growthGrade);
               this._name.text = _loc3_.name;
               this._levelVal.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",_loc3_.growthGrade);
               if(_loc1_)
               {
                  this._jobVal.text = _loc1_.JobName;
               }
               this._combatPowerVal.text = _loc3_.fightValue.toString();
            }
         }
      }
    getCombatPower(param1, param2 = "") {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (param2 != null && typeof param2 !== "string") param2 = String(param2);
         var _loc3_ = "";
         if($.C("managers.FreedomTeamManager").instance.hasTeam)
         {
            _loc3_ = String($.C("managers.FreedomTeamManager").instance.memberFightCapacity(param1));
         }
         else if($.C("managers.RoomManager").instance.roomInfo)
         {
            _loc3_ = String($.C("managers.RoomManager").instance.roomInfo.getPlayerByUserId(param1,param2).combatPower);
         }
         else if($.C("managers.GameHallManager").instance.model.selfTeam)
         {
            _loc3_ = String($.C("managers.GameHallManager").instance.model.getUserArmyByUserId(param1).baseHero.fightingCapacity);
         }
         return _loc3_;
      }
    dispose() {
         if(this._totalVBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._totalVBox);
         }
         this._totalVBox = null;
         if(this._levelHBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levelHBox);
         }
         this._levelHBox = null;
         if(this._jobHBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._jobHBox);
         }
         this._jobHBox = null;
         if(this._combatPowerHBox)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._combatPowerHBox);
         }
         this._combatPowerHBox = null;
         if(this._name)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         }
         this._name = null;
         if(this._level)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._level);
         }
         this._level = null;
         if(this._job)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._job);
         }
         this._job = null;
         if(this._combatPower)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._combatPower);
         }
         this._combatPower = null;
         if(this._levelVal)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._levelVal);
         }
         this._levelVal = null;
         if(this._jobVal)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._jobVal);
         }
         this._jobVal = null;
         if(this._combatPowerVal)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._combatPowerVal);
         }
         this._combatPowerVal = null;
         if(this._line1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         }
         this._line1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ThaneTip, "yishi.view.tips.ThaneTip", []);
  return __ThaneTip;
}
deps["yishi.view.tips.ThaneTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.FreedomTeamManager", "managers.GameHallManager", "managers.RoomManager", "mvc.module.children.ChildData", "yishi.datas.consant.JobType", "yishi.datas.playerinfo.ThaneInfo", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.TheseusAttributeItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __TheseusAttributeItem extends __Base {
    static $fields(self) {
    self._flagImg = null;
    self._attributeValue = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._flagImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.attributeFlag");
         this._attributeValue = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.theseusAttribute.tipItemTxt");
         this.addChild(this._flagImg);
         this.addChild(this._attributeValue);
      }
    setTextValue(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         this._attributeValue.htmlText = param1;
         this._attributeValue.height = 20 * this._attributeValue.numLines;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._flagImg);
         this._flagImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._attributeValue);
         this._attributeValue = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__TheseusAttributeItem, "yishi.view.tips.TheseusAttributeItem", []);
  return __TheseusAttributeItem;
}
deps["yishi.view.tips.TheseusAttributeItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite"];

defs["yishi.view.tips.TheseusGodheadEquipTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __TheseusGodheadEquipTip extends __Base {
    static $fields(self) {
    self._profileImg = null;
    self._equipIcon = null;
    self._title = null;
    self._typeTxt = null;
    self._gzTxt = null;
    self._addImg = null;
    self._strengImg = null;
    self._strengNumSprite = null;
    self._totalBox = null;
    self._starContaint = null;
    self._skill01 = null;
    self._skill02 = null;
    self._skill03 = null;
    self._gemTxt0 = null;
    self._line1 = null;
    self._line2 = null;
    self._line3 = null;
    self._line4 = null;
    self.attBox = null;
    self.attList = [];
    self.refreshBox = null;
    self._stoneIcon = null;
    self._starNum = -1;
    }
    constructor() {
         super();
      }
    updateStoneIcon() {
         var _loc2_ = NaN;
         var _loc1_ = NaN;
         if(this._stoneIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._stoneIcon);
            this._stoneIcon = null;
         }
         if(this._data && this._data.shape > 0)
         {
            this._stoneIcon = $.C("mvc.module.theseus.TheseusSlateAssetHelper").getSlateDisplay(this._data.shape,this._data.rotate);
            if(this._stoneIcon)
            {
               _loc2_ = this._stoneIcon.width;
               _loc1_ = this._stoneIcon.height;
               this._stoneIcon.scaleX = 0.3;
               this._stoneIcon.scaleY = 0.3;
               this._stoneIcon.x = 30 - _loc2_ * 0.3 / 2;
               this._stoneIcon.y = 20 - _loc1_ * 0.3 / 2;
               this.addChildAt(this._stoneIcon,1);
            }
         }
      }
    init() {
         var _loc1_ = null;
         super.init();
         this._bg.x = -15;
         this._bg.y = -25;
         this._bg.width = 372;
         this._equipIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._addImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.addImg");
         this._strengNumSprite = new ($.C("flash.display.Sprite"))();
         this._strengNumSprite.y = 3;
         this._strengImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.tips.numImg");
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsTotalBox");
         this._starContaint = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("xmlui.theseuswarequipTip.hbox");
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._typeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodTypeText_2");
         this._gzTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.castSelectedTxt");
         this._gemTxt0 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodTypeText");
         this._gemTxt0.x = 145;
         this._gemTxt0.y = 75;
         this._gemTxt0.width = 200;
         this._typeTxt.x = 150;
         this._typeTxt.y = 55;
         this._typeTxt.width = 182;
         this._gzTxt.x = 81;
         this.attBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("theseuswarTip.TipsVBox");
         var _loc2_ = 0;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new ($.C("yishi.view.tips.TheseusAttributeItem"))();
            this.attList[_loc2_] = _loc1_;
            _loc2_++;
         }
         this.addChild(this._equipIcon);
         this.addChild(this._profileImg);
         this._profileImg.setFrame(1);
         this.addChild(this._addImg);
         this.addChild(this._strengNumSprite);
         this.addChild(this._title);
         this.addChild(this._typeTxt);
         this.addChild(this._typeTxt);
         this.addChild(this._gzTxt);
         this.addChild(this._starContaint);
         this.addChild(this._gemTxt0);
         this.addChild(this._totalBox);
         this._addImg.x = 270;
         this._addImg.y = 0;
         this._title.y = 5;
         this._totalBox.y = 100;
      }
    setStrengNum(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         $.C("yishi.utils.NumberViewUtils").refreshValue(param1,this._strengNumSprite,this._strengImg,19,22,15,19,"0123456789");
      }
    showStar(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         var _loc3_ = 0;
         var _loc5_ = 0;
         if(this._starNum == param1)
         {
            return;
         }
         this._starNum = param1;
         var _loc6_ = 1;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._starContaint);
         this._starContaint.beginChanges();
         var _loc4_ = _loc6_ * 5;
         var _loc7_ = (_loc6_ - 1) * 5;
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc3_ = _loc7_ + _loc5_;
            if(param1 > _loc3_ && _loc6_ > 0)
            {
               _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.theseus.warStar3");
               this._starContaint.addChild(_loc2_);
            }
            _loc5_++;
         }
         this._starContaint.commitChanges();
      }
    updateAttItem(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         var _loc4_ = 0;
         var _loc5_ = "    ";
         var _loc6_ = "";
         _loc6_ = _loc6_ + ($.C("mvc.module.theseus.AttributeUtils").getAttributeName(param3,2) + param1);
         if(_loc6_ && param2)
         {
            param2.setTextValue(_loc6_);
         }
      }
    $$updateTransform() {
         var _loc16_ = null;
         var _loc2_ = null;
         var _loc3_ = 0;
         var _loc17_ = 0;
         var _loc5_ = 0;
         var _loc18_ = 0;
         var _loc13_ = 0;
         var _loc10_ = 0;
         var _loc14_ = 0;
         var _loc6_ = 0;
         var _loc11_ = 0;
         var _loc9_ = null;
         var _loc1_ = null;
         var _loc12_ = null;
         var _loc4_ = null;
         var _loc15_ = null;
         var _loc7_ = 0;
         var _loc8_ = 0;
         var _loc19_ = $.as(this.tipData, $.C("mvc.module.theseus.TheseusGodheadStoneInfo"));
         if(_loc19_)
         {
            _loc16_ = ["#59cd41","#33a6ff","#1aecff"];
            _loc2_ = $.C("mvc.module.theseus.AttributeUtils").getColorStr(_loc19_.name,_loc16_[_loc19_.quality - 1]);
            this.updateStoneIcon();
            this._profileImg.setFrame(_loc19_.quality);
            this._title.setFrame(_loc19_.quality);
            this._title.text = _loc19_.name;
            if(_loc19_.maxLevel)
            {
               this._gemTxt0.text = $.C("manager.LanguageMgr").GetTranslation("goddess.equip.tipMax",_loc19_.maxLevel);
            }
            _loc3_ = $.int(_loc19_.SlateType);
            this._typeTxt.text = $.C("managers.TheseussoulManager").Instance.modelGodhead.getNamebySlateType(_loc3_);
            this.showStar(_loc19_.star);
            this._strengNumSprite.x = this._addImg.x + 15;
            _loc17_ = $.int(_loc19_.baseAttributes.Attack);
            _loc5_ = $.int(_loc19_.baseAttributes.Defence);
            _loc18_ = $.int(_loc19_.baseAttributes.ForceHit);
            _loc13_ = $.int(_loc19_.baseAttributes.Parry);
            _loc10_ = $.int(_loc19_.baseAttributes.Penetrate);
            _loc14_ = $.int(_loc19_.baseAttributes.MagicAttack);
            _loc6_ = $.int(_loc19_.baseAttributes.MagicDefence);
            _loc11_ = $.int(_loc19_.baseAttributes.Live);
            _loc9_ = _loc19_.getLevelAttributes();
            if(_loc19_.level > 0)
            {
               this._addImg.visible = true;
               this._strengNumSprite.visible = true;
               this.setStrengNum(_loc19_.level);
               _loc17_ += _loc9_.Attack || 0;
               _loc5_ += _loc9_.Defence || 0;
               _loc14_ += _loc9_.MagicAttack || 0;
               _loc6_ += _loc9_.MagicDefence || 0;
               _loc11_ += _loc9_.Live || 0;
               _loc18_ += _loc9_.ForceHit || 0;
               _loc13_ += _loc9_.Parry || 0;
               _loc10_ += _loc9_.Penetrate || 0;
            }
            else
            {
               this._addImg.visible = false;
               this._strengNumSprite.visible = false;
            }
            this._totalBox.beginChanges();
            this._totalBox.removeAllChild();
            this.attBox.beginChanges();
            this.attBox.removeAllChild();
            if(_loc17_ > 0)
            {
               _loc1_ = this.attList[0];
               this.updateAttItem(_loc17_,_loc1_,"Attack");
               this.attBox.addChild(_loc1_);
            }
            if(_loc5_ > 0)
            {
               _loc1_ = this.attList[1];
               this.updateAttItem(_loc5_,_loc1_,"Defence");
               this.attBox.addChild(_loc1_);
            }
            if(_loc14_ > 0)
            {
               _loc1_ = this.attList[2];
               this.updateAttItem(_loc14_,_loc1_,"MagicAttack");
               this.attBox.addChild(_loc1_);
            }
            if(_loc6_ > 0)
            {
               _loc1_ = this.attList[3];
               this.updateAttItem(_loc6_,_loc1_,"MagicDefence");
               this.attBox.addChild(_loc1_);
            }
            if(_loc11_ > 0)
            {
               _loc1_ = this.attList[4];
               this.updateAttItem(_loc11_,_loc1_,"Live");
               this.attBox.addChild(_loc1_);
            }
            if(_loc18_ > 0)
            {
               _loc1_ = this.attList[5];
               this.updateAttItem(_loc18_,_loc1_,"ForceHit");
               this.attBox.addChild(_loc1_);
            }
            if(_loc13_ > 0)
            {
               _loc1_ = this.attList[6];
               this.updateAttItem(_loc13_,_loc1_,"Parry");
               this.attBox.addChild(_loc1_);
            }
            if(_loc10_ > 0)
            {
               _loc1_ = this.attList[7];
               this.updateAttItem(_loc10_,_loc1_,"Penetrate");
               this.attBox.addChild(_loc1_);
            }
            this.attBox.commitChanges();
            this._totalBox.addChild(this._line1);
            this._totalBox.addChild(this.attBox);
            _loc15_ = _loc19_.SkillID;
            _loc7_ = $.int(_loc15_.length);
            this._totalBox.addChild(this._line2);
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc4_ = $.C("yishi.manager.TempleteManager").instance.getSkillById(_loc15_[_loc8_]);
               if(_loc4_ && _loc4_.Description != "")
               {
                  _loc1_ = this.attList[8 + _loc8_];
                  _loc1_.setTextValue(_loc4_.Description);
                  this._totalBox.addChild(_loc1_);
               }
               _loc8_++;
            }
            this._totalBox.commitChanges();
            this._bg.height = this._totalBox.y + this._totalBox.height + 35;
         }
      }
    dispose() {
         var _loc1_ = null;
         for (_loc1_ of $.values(this.attList))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         this.attList = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.attBox);
         this.attBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.refreshBox);
         this.refreshBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._profileImg);
         this._profileImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._addImg);
         this._addImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._strengNumSprite);
         this._strengNumSprite = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._strengImg);
         this._strengImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._equipIcon);
         this._equipIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._totalBox);
         this._totalBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         this._title = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skill01);
         this._skill01 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skill02);
         this._skill02 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skill03);
         this._skill03 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._stoneIcon);
         this._stoneIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         this._line1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line2);
         this._line2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line3);
         this._line3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line4);
         this._line4 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._starContaint);
         this._starContaint = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gzTxt);
         this._gzTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._typeTxt);
         this._typeTxt = null;
         super.dispose();
      }
  }
  $.meta(__TheseusGodheadEquipTip, "yishi.view.tips.TheseusGodheadEquipTip", []);
  return __TheseusGodheadEquipTip;
}
deps["yishi.view.tips.TheseusGodheadEquipTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "managers.TheseussoulManager", "mvc.module.theseus.AttributeUtils", "mvc.module.theseus.TheseusGodheadStoneInfo", "mvc.module.theseus.TheseusSlateAssetHelper", "yishi.manager.TempleteManager", "yishi.utils.NumberViewUtils", "yishi.view.tips.BaseTip", "yishi.view.tips.TheseusAttributeItem"];

defs["yishi.view.tips.TheseusItemTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __TheseusItemTip extends __Base {
    static $fields(self) {
    self._txt = null;
    self._hBox = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 155;
         this._bg.height = 240;
         this._txt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("skyStepTip.txt");
         this._hBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("skyStepTip.hBox");
         this.addChild(this._txt);
         this.addChild(this._hBox);
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc1_ = null;
         if(this.tipData != null)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._hBox);
            this._hBox.beginChanges();
            _loc1_ = $.as(this.tipData.arr, "Array");
            for (var _loc3_ of $.values(_loc1_))
            {
               _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("skyStepTip.BaseItemView");
               _loc2_.data = _loc3_;
               this._hBox.addChild(_loc2_);
            }
            this._hBox.commitChanges();
            this._bg.height = this._hBox.y + this._hBox.height + 10;
            this._bg.width = Math.max(this._txt.width,this._hBox.width) + this._hBox.x + 15;
            this._txt.text = this.tipData.name;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__TheseusItemTip, "yishi.view.tips.TheseusItemTip", []);
  return __TheseusItemTip;
}
deps["yishi.view.tips.TheseusItemTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.TheseusWarsoulEquipTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __TheseusWarsoulEquipTip extends __Base {
    static $fields(self) {
    self._profileImg = null;
    self._equipIcon = null;
    self._title = null;
    self._typeTxt = null;
    self._gzTxt = null;
    self._addImg = null;
    self._strengImg = null;
    self._strengNumSprite = null;
    self._totalBox = null;
    self._starContaint = null;
    self._skill01 = null;
    self._skill02 = null;
    self._skill03 = null;
    self._gemTxt0 = null;
    self._gemTxt1 = null;
    self._gemTxt2 = null;
    self._gemTxt3 = null;
    self._gemTxt4 = null;
    self._gemTxt5 = null;
    self._line1 = null;
    self._line2 = null;
    self._line3 = null;
    self._line4 = null;
    self.attBox = null;
    self.attList = [];
    self.refreshBox = null;
    self.refreshList = [];
    self.bskBox = null;
    self.bSkList = [];
    self.zhYiPanel = null;
    self.zhYiList = [];
    self._starNum = -1;
    }
    constructor() {
         super();
      }
    init() {
         var _loc1_ = null;
         super.init();
         this._bg.x = -15;
         this._bg.y = -25;
         this._bg.width = 372;
         this._equipIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._addImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.addImg");
         this._strengNumSprite = new ($.C("flash.display.Sprite"))();
         this._strengNumSprite.y = 3;
         this._strengImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.tips.numImg");
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsTotalBox");
         this._starContaint = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("xmlui.theseuswarequipTip.hbox");
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._typeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodTypeText_2");
         this._gzTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.castSelectedTxt");
         this._gemTxt0 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodTypeText");
         this._gemTxt1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.theseusAttribute.tipTittt");
         this._gemTxt2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.theseusAttribute.tipTittt");
         this._gemTxt3 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.theseusAttribute.tipTittt");
         this._gemTxt4 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.theseusAttribute.tipTittt");
         this._gemTxt5 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.theseusAttribute.tipTittt");
         this._gemTxt1.text = $.C("manager.LanguageMgr").GetTranslation("theseus.war.tipxl");
         this._gemTxt2.text = $.C("manager.LanguageMgr").GetTranslation("theseus.war.tipzy");
         this._gemTxt3.text = $.C("manager.LanguageMgr").GetTranslation("theseus.war.tipzsk");
         this._gemTxt4.text = $.C("manager.LanguageMgr").GetTranslation("theseus.war.tipbsk");
         this._gemTxt0.x = 145;
         this._gemTxt0.y = 75;
         this._gemTxt0.width = 200;
         this._typeTxt.x = -14;
         this._typeTxt.y = 55;
         this._typeTxt.width = 90;
         this._gzTxt.x = 81;
         this.attBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("theseuswarTip.TipsVBox");
         var _loc2_ = 0;
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = new ($.C("yishi.view.tips.TheseusAttributeItem"))();
            this.attList[_loc2_] = _loc1_;
            _loc2_++;
         }
         this.refreshBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("theseuswarTip.TipsVBox");
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new ($.C("yishi.view.tips.TheseusAttributeItem"))();
            this.refreshList[_loc2_] = _loc1_;
            _loc2_++;
         }
         this.bskBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("theseuswarTip.TipsVBox");
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc1_ = new ($.C("yishi.view.tips.TheseusAttributeItem"))();
            this.bSkList[_loc2_] = _loc1_;
            _loc2_++;
         }
         this.zhYiPanel = new ($.C("com.pickgliss.ui.controls.container.SimpleTileList"))(2);
         this.zhYiPanel.hSpace = -180;
         this.zhYiPanel.vSpace = 0;
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = new ($.C("yishi.view.tips.TheseusAttributeItem"))();
            this.zhYiList[_loc2_] = _loc1_;
            _loc2_++;
         }
         this.addChild(this._equipIcon);
         this.addChild(this._profileImg);
         this._profileImg.setFrame(1);
         this.addChild(this._addImg);
         this.addChild(this._strengNumSprite);
         this.addChild(this._title);
         this.addChild(this._typeTxt);
         this.addChild(this._gzTxt);
         this.addChild(this._starContaint);
         this.addChild(this._gemTxt0);
         this.addChild(this._totalBox);
         this._addImg.x = 270;
         this._addImg.y = 0;
         this._title.y = 5;
         this._totalBox.y = 100;
      }
    setStrengNum(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         $.C("yishi.utils.NumberViewUtils").refreshValue(param1,this._strengNumSprite,this._strengImg,19,22,15,19,"0123456789");
      }
    showStar(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         var _loc2_ = null;
         var _loc3_ = 0;
         var _loc5_ = 0;
         if(this._starNum == param1)
         {
            return;
         }
         this._starNum = param1;
         var _loc6_ = (param1 - 1) / 5 + 1;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._starContaint);
         this._starContaint.beginChanges();
         var _loc4_ = _loc6_ * 5;
         var _loc7_ = (_loc6_ - 1) * 5;
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc3_ = _loc7_ + _loc5_;
            if(param1 > _loc3_ && _loc6_ > 0)
            {
               _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.core.profie.star" + _loc6_);
               this._starContaint.addChild(_loc2_);
            }
            _loc5_++;
         }
         this._starContaint.commitChanges();
      }
    updateAttItem(param1, param2, param3) {
         if (param3 != null && typeof param3 !== "string") param3 = String(param3);
         var _loc5_ = 0;
         var _loc8_ = 0;
         var _loc9_ = null;
         var _loc6_ = 0;
         var _loc4_ = 0;
         var _loc7_ = "    ";
         if(param1.warStartempInfo)
         {
            _loc5_ = $.int(param1.warStartempInfo[param3]);
            _loc8_ = param1.warTempInfo[param3] * _loc5_ / 100;
            _loc9_ = $.C("mvc.module.theseus.AttributeUtils").getAttributeName(param3,2) + _loc7_ + _loc8_;
            _loc9_ = $.C("mvc.module.theseus.AttributeUtils").getColorStr(_loc9_,"#B3B3B3");
         }
         if(param1.warStrengthTempInfo)
         {
            _loc6_ = $.int(param1.warStrengthTempInfo[param3]);
            if(param1.strengthen > 0 && _loc6_ > 0)
            {
               _loc8_ = _loc6_ * _loc5_ / 100;
               _loc9_ += _loc7_ + $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text01") + "+" + _loc8_;
            }
            _loc4_ = $.int(param1.warReformTempInfo[param3]);
            if(param1.reform > 0 && _loc4_ > 0)
            {
               _loc9_ += _loc7_ + $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.GoodAttributeItem.text05") + "+" + _loc4_;
            }
         }
         if(_loc9_)
         {
            param2.setTextValue(_loc9_);
         }
      }
    $$updateTransform() {
         var _loc34_ = null;
         var _loc26_ = null;
         var _loc31_ = null;
         var _loc23_ = null;
         var _loc7_ = null;
         var _loc13_ = null;
         var _loc32_ = null;
         var _loc24_ = null;
         var _loc2_ = null;
         var _loc18_ = null;
         var _loc14_ = 0;
         var _loc3_ = 0;
         var _loc33_ = 0;
         var _loc28_ = 0;
         var _loc8_ = 0;
         var _loc22_ = null;
         var _loc9_ = null;
         var _loc1_ = null;
         var _loc29_ = 0;
         var _loc11_ = 0;
         var _loc37_ = null;
         var _loc36_ = false;
         var _loc27_ = 0;
         var _loc20_ = null;
         var _loc25_ = null;
         var _loc15_ = null;
         var _loc16_ = null;
         var _loc17_ = null;
         var _loc30_ = 0;
         var _loc6_ = null;
         var _loc10_ = 0;
         var _loc19_ = null;
         var _loc35_ = null;
         var _loc12_ = null;
         var _loc4_ = 0;
         var _loc5_ = false;
         var _loc21_ = $.as(this.tipData, $.C("mvc.module.theseus.TheseusWarsoulItemInfo"));
         if(_loc21_)
         {
            _loc34_ = ["ui.theseussoul.posUp","ui.theseussoul.posMid","ui.theseussoul.posDown"];
            _loc26_ = _loc21_.warTempInfo;
            _loc31_ = _loc21_.warStartempInfo;
            _loc23_ = _loc21_.warReformTempInfo;
            _loc7_ = _loc21_.warStrengthTempInfo;
            _loc13_ = ["#59cd41","#33a6ff","#1aecff"];
            _loc32_ = $.C("mvc.module.theseus.AttributeUtils").getColorStr($.C("manager.LanguageMgr").GetTranslation("theseus.war.type" + _loc26_.MainType),_loc13_[_loc26_.MainType - 1]);
            _loc24_ = $.C("manager.LanguageMgr").GetTranslation(_loc34_[_loc26_.Rank - 1 >= 0 ? _loc26_.Rank - 1 : 0]);
            this._typeTxt.htmlText = _loc24_ + " " + _loc32_;
            _loc2_ = $.C("yishi.utils.GoodsHelp").getGoodColorString(_loc21_.reform);
            _loc18_ = $.C("mvc.module.theseus.AttributeUtils").getColorStr($.C("manager.LanguageMgr").GetTranslation("theseus.war.gz" + _loc21_.reform),_loc2_,false);
            this._gzTxt.htmlText = _loc18_;
            this._equipIcon.icon = $.C("yishi.utils.IconFactory").getTheseusWarSoulIcon(_loc26_.Icon);
            this._profileImg.setFrame(_loc26_.Profile);
            this._title.setFrame(_loc26_.Profile);
            this._title.text = _loc26_.Name;
            if(_loc21_.warStartempInfo)
            {
               this._gemTxt0.text = $.C("manager.LanguageMgr").GetTranslation("goddess.equip.tipMax",_loc21_.warStartempInfo.MaxGrade);
            }
            this.showStar(_loc21_.star);
            this._strengNumSprite.x = this._addImg.x + 15;
            _loc14_ = $.int(_loc21_.warTempInfo.Attack);
            _loc3_ = $.int(_loc21_.warTempInfo.Defence);
            _loc33_ = $.int(_loc21_.warTempInfo.MagicAttack);
            _loc28_ = $.int(_loc21_.warTempInfo.MagicDefence);
            _loc8_ = $.int(_loc21_.warTempInfo.Live);
            if(_loc21_.strengthen > 0 && _loc7_)
            {
               this._addImg.visible = true;
               this._strengNumSprite.visible = true;
               this.setStrengNum(_loc21_.strengthen);
               _loc14_ += _loc7_.Attack;
               _loc3_ += _loc7_.Defence;
               _loc33_ += _loc7_.MagicAttack;
               _loc28_ += _loc7_.MagicDefence;
               _loc8_ += _loc7_.Live;
            }
            else
            {
               this._addImg.visible = false;
               this._strengNumSprite.visible = false;
            }
            if(_loc21_.reform > 0 && _loc23_)
            {
               _loc14_ += _loc23_.Attack;
               _loc3_ += _loc23_.Defence;
               _loc33_ += _loc23_.MagicAttack;
               _loc28_ += _loc23_.MagicDefence;
               _loc8_ += _loc23_.Live;
            }
            this._totalBox.beginChanges();
            this._totalBox.removeAllChild();
            this.attBox.beginChanges();
            this.attBox.removeAllChild();
            if(_loc14_ > 0)
            {
               _loc22_ = this.attList[0];
               this.updateAttItem(_loc21_,_loc22_,"Attack");
               this.attBox.addChild(_loc22_);
            }
            if(_loc3_ > 0)
            {
               _loc22_ = this.attList[1];
               this.updateAttItem(_loc21_,_loc22_,"Defence");
               this.attBox.addChild(_loc22_);
            }
            if(_loc33_ > 0)
            {
               _loc22_ = this.attList[2];
               this.updateAttItem(_loc21_,_loc22_,"MagicAttack");
               this.attBox.addChild(_loc22_);
            }
            if(_loc28_ > 0)
            {
               _loc22_ = this.attList[3];
               this.updateAttItem(_loc21_,_loc22_,"MagicDefence");
               this.attBox.addChild(_loc22_);
            }
            if(_loc8_ > 0)
            {
               _loc22_ = this.attList[4];
               this.updateAttItem(_loc21_,_loc22_,"Live");
               this.attBox.addChild(_loc22_);
            }
            this.attBox.commitChanges();
            this._totalBox.addChild(this._line1);
            this._totalBox.addChild(this.attBox);
            if(_loc21_.learnSkill > 0)
            {
               _loc1_ = $.C("yishi.manager.TempleteManager").instance.getSkillById(_loc21_.learnSkill);
               this._gemTxt5.text = _loc1_.TemplateName;
               this._totalBox.addChild(this._gemTxt5);
               _loc22_ = this.attList[5];
               _loc22_.setTextValue(_loc1_.Description);
               this._totalBox.addChild(_loc22_);
            }
            _loc29_ = 0;
            if(_loc21_.ramdomSkills)
            {
               _loc37_ = _loc21_.ramdomSkills.split(",");
               _loc11_ = $.int(_loc37_.length);
               _loc29_ = 0;
               while(_loc29_ < _loc11_)
               {
                  _loc27_ = $.int(_loc37_[_loc29_]);
                  if(_loc27_ > 0)
                  {
                     _loc36_ = true;
                     break;
                  }
                  _loc29_++;
               }
               if(_loc36_)
               {
                  this._totalBox.addChild(this._line2);
                  this._totalBox.addChild(this._gemTxt1);
                  this.refreshBox.beginChanges();
                  this.refreshBox.removeAllChild();
                  _loc29_ = 0;
                  while(_loc29_ < _loc11_)
                  {
                     _loc27_ = $.int(_loc37_[_loc29_]);
                     if(_loc27_ > 0)
                     {
                        _loc1_ = $.C("yishi.manager.TempleteManager").instance.getSkillById(_loc27_);
                        if(_loc1_)
                        {
                           _loc22_ = this.refreshList[_loc29_];
                           if(_loc22_ == null)
                           {
                              _loc22_ = new ($.C("yishi.view.tips.TheseusAttributeItem"))();
                              this.refreshList[_loc29_] = _loc22_;
                           }
                           if(_loc1_.Parameter3 <= 0)
                           {
                              _loc20_ = _loc1_.Description + $.C("manager.LanguageMgr").GetTranslation("store.view.refresh.RefreshAttriItem.Grades1",_loc1_.Grades);
                           }
                           else
                           {
                              _loc20_ = _loc1_.Description + $.C("manager.LanguageMgr").GetTranslation("store.view.refresh.RefreshAttriItem.Grades2",_loc1_.Grades);
                           }
                           _loc22_.setTextValue(_loc20_);
                           this.refreshBox.addChild(_loc22_);
                        }
                     }
                     _loc29_++;
                  }
                  this.refreshBox.commitChanges();
                  this._totalBox.addChild(this.refreshBox);
               }
            }
            if(_loc21_.reformBuffList && _loc21_.reformBuffList.length > 0)
            {
               this._totalBox.addChild(this._gemTxt2);
               this.zhYiPanel.beginChanges();
               this.zhYiPanel.removeAllChild();
               _loc25_ = [1,3,4,5,2,6,9,10,11,12,7,8];
               _loc15_ = [0,2,3,4,1,5,8,8,9,9,6,7];
               _loc29_ = 0;
               while(_loc29_ < _loc21_.reformBuffList.length)
               {
                  _loc16_ = _loc21_.reformBuffList[_loc29_];
                  _loc17_ = _loc16_.split(",");
                  _loc30_ = $.int(_loc17_[0]);
                  _loc10_ = _loc25_.indexOf(_loc30_);
                  _loc6_ = $.C("manager.LanguageMgr").GetTranslation("theseus.equip.part" + _loc15_[_loc10_]) + "+" + _loc17_[1];
                  _loc22_ = this.zhYiList[_loc29_];
                  _loc22_.setTextValue(_loc6_);
                  this.zhYiPanel.addChild(_loc22_);
                  _loc29_++;
               }
               this.zhYiPanel.commitChanges();
               this._totalBox.addChild(this.zhYiPanel);
            }
            if(_loc7_)
            {
               _loc19_ = $.C("yishi.manager.TempleteManager").instance.getSkillById(_loc7_.OpenActiveSkill);
               if(_loc19_)
               {
                  this._totalBox.addChild(this._line4);
                  this._totalBox.addChild(this._gemTxt3);
                  _loc22_ = this.attList[6];
                  _loc22_.setTextValue(_loc19_.Description);
                  this._totalBox.addChild(_loc22_);
               }
               _loc35_ = _loc7_.OpenPassiveSkill.split(",");
               _loc11_ = $.int(_loc35_.length);
               this.bskBox.beginChanges();
               this.bskBox.removeAllChild();
               _loc29_ = 0;
               while(_loc29_ < _loc11_)
               {
                  _loc4_ = $.int(_loc35_[_loc29_]);
                  if(_loc4_ > 0)
                  {
                     if(!_loc5_)
                     {
                        _loc5_ = true;
                        this._totalBox.addChild(this._gemTxt4);
                     }
                     _loc12_ = $.C("yishi.manager.TempleteManager").instance.getSkillById(_loc4_);
                     if(_loc12_)
                     {
                        _loc22_ = this.bSkList[_loc29_];
                        if(_loc22_ == null)
                        {
                           _loc22_ = new ($.C("yishi.view.tips.TheseusAttributeItem"))();
                           this.bSkList[_loc29_] = _loc22_;
                        }
                        _loc22_.setTextValue(_loc12_.Description);
                        this.bskBox.addChild(_loc22_);
                     }
                  }
                  _loc29_++;
               }
               this.bskBox.commitChanges();
               this._totalBox.addChild(this.bskBox);
            }
            this._totalBox.commitChanges();
            this._bg.height = this._totalBox.y + this._totalBox.height + 35;
         }
      }
    dispose() {
         var _loc1_ = null;
         for (_loc1_ of $.values(this.attList))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         this.attList = null;
         for (_loc1_ of $.values(this.refreshList))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         this.refreshList = null;
         for (_loc1_ of $.values(this.bSkList))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         this.bSkList = null;
         for (_loc1_ of $.values(this.zhYiList))
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
         this.zhYiList = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.attBox);
         this.attBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.refreshBox);
         this.refreshBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this.bskBox);
         this.bskBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._profileImg);
         this._profileImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._addImg);
         this._addImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._strengNumSprite);
         this._strengNumSprite = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._strengImg);
         this._strengImg = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._equipIcon);
         this._equipIcon = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._totalBox);
         this._totalBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._title);
         this._title = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skill01);
         this._skill01 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skill02);
         this._skill02 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._skill03);
         this._skill03 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gemTxt0);
         this._gemTxt0 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gemTxt1);
         this._gemTxt1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gemTxt2);
         this._gemTxt2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gemTxt3);
         this._gemTxt3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gemTxt4);
         this._gemTxt4 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         this._line1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line2);
         this._line2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line3);
         this._line3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line4);
         this._line4 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._starContaint);
         this._starContaint = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._gzTxt);
         this._gzTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._typeTxt);
         this._typeTxt = null;
         super.dispose();
      }
  }
  $.meta(__TheseusWarsoulEquipTip, "yishi.view.tips.TheseusWarsoulEquipTip", []);
  return __TheseusWarsoulEquipTip;
}
deps["yishi.view.tips.TheseusWarsoulEquipTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.SimpleTileList", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.theseus.AttributeUtils", "mvc.module.theseus.TheseusWarsoulItemInfo", "yishi.manager.TempleteManager", "yishi.utils.GoodsHelp", "yishi.utils.IconFactory", "yishi.utils.NumberViewUtils", "yishi.view.tips.BaseTip", "yishi.view.tips.TheseusAttributeItem"];

defs["yishi.view.tips.TimePlusView"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __TimePlusView extends __Base {
    static $fields(self) {
    self._timeTxt = null;
    }
    constructor() {
         super();
         this.init();
      }
    static dateToString(param1, param2) {
         param2.text = "";
         param2.text = $.C("yishi.utils.DateFormatter").format(param1,"YYYY-MM-DD hh:mm:ss");
      }
    static formatToStandard(param1) {
         if (typeof param1 !== "number") param1 = Number(param1);
         var _loc2_ = param1.toString();
         if(_loc2_.length < 2)
         {
            return "0" + _loc2_;
         }
         return _loc2_;
      }
    init() {
         $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_MINUTE",$.bind(this, "__timeHandler"),false,0,true);
      }
    __timeHandler(param1) {
         this.setTimeCount(param1.currentTarget.sysCurtime);
      }
    set timeTxtStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._timeTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._timeTxt);
         }
         this._timeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(param1);
         this.addChild(this._timeTxt);
      }
    setTimeCount(param1) {
         if(param1 && this._timeTxt)
         {
            __TimePlusView.dateToString(param1,this._timeTxt);
         }
      }
    dispose() {
         $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",$.bind(this, "__timeHandler"));
         this.removeChild(this._timeTxt);
      }
    get timeTxtStyle() { return super.timeTxtStyle; }
  }
  $.meta(__TimePlusView, "yishi.view.tips.TimePlusView", ["Disposeable"]);
  return __TimePlusView;
}
deps["yishi.view.tips.TimePlusView"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "yishi.manager.PlayerManager", "yishi.utils.DateFormatter"];

defs["yishi.view.tips.TimeTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __TimeTip extends __Base {
    static $fields(self) {
    self._time = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 155;
         this._bg.height = 30;
         this._time = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("Tips.TimePlusView");
         this.addChild(this._time);
      }
    $$updateTransform() {
         var _loc2_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel;
         if(_loc2_.castle_offset == -1)
         {
            this._time.setTimeCount(($.as(this._data, $.C("yishi.datas.playerinfo.PlayerModel"))).sysCurtime);
            return;
         }
         var _loc1_ = $.C("yishi.utils.DateFormatter").getTimezoneOffsetDate(_loc2_.castle_offset);
         this._time.setTimeCount(_loc1_);
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._time);
         this._time = null;
      }
  }
  $.meta(__TimeTip, "yishi.view.tips.TimeTip", []);
  return __TimeTip;
}
deps["yishi.view.tips.TimeTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "yishi.datas.playerinfo.PlayerModel", "yishi.manager.PlayerManager", "yishi.utils.DateFormatter", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.TreasureIntensifyTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __TreasureIntensifyTip extends __Base {
    static $fields(self) {
    self._intensifyIcon = null;
    self._goodstip1 = null;
    self._goodstip2 = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.parent && this._bg.parent.removeChild(this._bg);
         this._goodstip1 = new ($.C("yishi.view.tips.goods.TreasureTip"))();
         this._goodstip2 = new ($.C("yishi.view.tips.goods.TreasureTip"))();
         this._goodstip2.x = this._goodstip1.width + 80;
         this._intensifyIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         this.addChild(this._goodstip1);
         this.addChild(this._goodstip2);
         this.addChild(this._intensifyIcon);
      }
    set tipData(param1) {
         this._data = param1;
         this._goodstip1.tipData = this._data;
         var _loc2_ = $.as(this._data, $.C("yishi.datas.goods.GoodsInfo"));
         if(_loc2_)
         {
            if(_loc2_.strengthenGrade >= _loc2_.templateInfo.StrengthenMax)
            {
               this._intensifyIcon.parent && this._intensifyIcon.parent.removeChild(this._intensifyIcon);
               this._goodstip2.parent && this._goodstip2.parent.removeChild(this._goodstip2);
               return;
            }
            this._goodstip2.parent || this.addChild(this._goodstip2);
            this._intensifyIcon.parent || this.addChild(this._intensifyIcon);
            this._intensifyIcon.x = this._goodstip1.x + this._goodstip1.width - 16;
            this._intensifyIcon.y = this._goodstip1.y + (this._goodstip1.height - this._intensifyIcon.height) / 2;
            _loc2_ = this.getNextGrade(_loc2_);
            this._goodstip2.tipData = _loc2_;
            this._goodstip2.x = this._goodstip1.x + this._goodstip1.width + 29;
         }
      }
    getNextGrade(param1) {
         var _loc3_ = this.getGrowupInfo(param1.templateId,param1.strengthenGrade + 1);
         return this.copyGoods(param1,_loc3_);
      }
    getGrowupInfo(param1, param2) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         return $.C("yishi.manager.TempleteManager").instance.theseusTreasureGrowupCate.getTempInfoByIdLevel(param1,param2);
      }
    copyGoods(param1, param2) {
         var _loc3_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
         _loc3_.id = param1.id;
         _loc3_.templateId = param2.TreasureId;
         _loc3_.strengthenGrade = param2.TreasureLevel;
         _loc3_.templateInfo.Attack = param2.PhyAttack;
         _loc3_.templateInfo.Defence = param2.PhyDefence;
         _loc3_.templateInfo.MagicAttack = param2.MagicAttack;
         _loc3_.templateInfo.MagicDefence = param2.MagicDefence;
         _loc3_.templateInfo.ForceHit = param2.ForceHit;
         _loc3_.templateInfo.Live = param2.Live;
         _loc3_.templateInfo.Parry = param2.Parry;
         _loc3_.templateInfo.Penetrate = param2.Penetrate;
         _loc3_.templateInfo.ReduceResi = param2.ReduceResi;
         _loc3_.templateInfo.FireResi = param2.FireResi;
         _loc3_.templateInfo.WaterResi = param2.WaterResi;
         _loc3_.templateInfo.ElectResi = param2.ElectResi;
         _loc3_.templateInfo.WindResi = param2.WindResi;
         _loc3_.templateInfo.DarkResi = param2.DarkResi;
         _loc3_.templateInfo.LightResi = param2.LightResi;
         _loc3_.templateInfo.ReduceResiAgainst = param2.ReduceResiAgainst;
         _loc3_.templateInfo.ResiPenetrate = param2.ResiPenetrate;
         _loc3_.randomSkill1 = param1.randomSkill1;
         _loc3_.randomSkill2 = param1.randomSkill2;
         _loc3_.randomSkill3 = param1.randomSkill3;
         _loc3_.randomSkill4 = param1.randomSkill4;
         _loc3_.randomSkill5 = param1.randomSkill5;
         return _loc3_;
      }
    dispose() {
         if(this._intensifyIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._intensifyIcon);
         }
         this._intensifyIcon = null;
         if(this._goodstip1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goodstip1);
         }
         this._goodstip1 = null;
         if(this._goodstip2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._goodstip2);
         }
         this._goodstip2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get tipData() { return super.tipData; }
  }
  $.meta(__TreasureIntensifyTip, "yishi.view.tips.TreasureIntensifyTip", []);
  return __TreasureIntensifyTip;
}
deps["yishi.view.tips.TreasureIntensifyTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "yishi.datas.goods.GoodsInfo", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.TreasureTip"];

defs["yishi.view.tips.VocationBranchTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __VocationBranchTips extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._line = null;
    self._branchTitleTxt = null;
    self._branchDescTxt = null;
    self._branchNeedTxt = null;
    self._branchNeedValueTxt1 = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("changejob.branchTotalBox");
         this._branchTitleTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("changejob.branchTitleTxt");
         this._branchDescTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("changejob.branchDescTxt");
         this._branchNeedTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("changejob.branchNeedTxt");
         this._branchNeedValueTxt1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("changejob.branchNeedValueTxt");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._bg.width = 270;
         this.addChild(this._totalBox);
      }
    $$updateTransform() {
         this.clean();
         this._branchTitleTxt.text = $.C("manager.LanguageMgr").GetTranslation("changeJob.branchName" + this.tipData);
         this._branchDescTxt.height = 120;
         this._branchDescTxt.text = $.C("manager.LanguageMgr").GetTranslation("changeJob.branchDesc" + this.tipData);
         this._branchDescTxt.height = this._branchDescTxt.textHeight + 5;
         this._branchNeedTxt.text = $.C("manager.LanguageMgr").GetTranslation("changeJob.needTxt");
         this._branchNeedValueTxt1.height = 120;
         this._branchNeedValueTxt1.htmlText = this.getConditionString();
         this._branchNeedValueTxt1.height = this._branchNeedValueTxt1.textHeight + 5;
         this._bg.width = this._branchDescTxt.width + 20;
         this._totalBox.addChild(this._branchTitleTxt);
         this._totalBox.addChild(this._branchDescTxt);
         this._bg.height = this._totalBox.height + 20;
      }
    getConditionString() {
         var _loc4_ = 0;
         var _loc7_ = 0;
         var _loc8_ = "Job" + ($.as(this.tipData, "String")).charAt(0) + "_Branch" + ($.as(this.tipData, "String")).charAt(1);
         var _loc6_ = $.C("yishi.manager.TempleteManager").instance.getConfigInfoByConfigName(_loc8_);
         if(!_loc6_)
         {
            return "";
         }
         var _loc3_ = _loc6_.ConfigValue;
         var _loc2_ = _loc3_.split(",");
         var _loc5_ = $.C("yishi.manager.FrameControllerManager").instance.tattooController.tattooModel.calculateAddProperty();
         var _loc1_ = "";
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc7_ = $.int(_loc2_[_loc4_]);
            if(_loc7_ > 0)
            {
               if(_loc5_[_loc4_] >= _loc2_[_loc4_])
               {
                  _loc1_ += "<font color=\'#55c03b\'>";
               }
               else
               {
                  _loc1_ += "<font color=\'#7b7b7b\'>";
               }
               _loc1_ += $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip0" + (_loc4_ + 1)) + "+" + _loc2_[_loc4_];
               _loc1_ += "</font>\n";
            }
            _loc4_++;
         }
         return _loc1_.substr(0,_loc1_.length - 1);
      }
    clean() {
         this._totalBox.removeAllChild();
      }
    dispose() {
         if(this._totalBox)
         {
            this._totalBox.dispose();
         }
         this._totalBox = null;
         if(this._line)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line);
         }
         this._line = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    set thane(v) { super.thane = v; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__VocationBranchTips, "yishi.view.tips.VocationBranchTips", []);
  return __VocationBranchTips;
}
deps["yishi.view.tips.VocationBranchTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.manager.ArmyManager", "yishi.manager.FrameControllerManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.WarlordMountTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __WarlordMountTip extends __Base {
    static $fields(self) {
    self._txt01 = null;
    self._txt02 = null;
    self._txt03 = null;
    self._txt04 = null;
    self._txt05 = null;
    self._scoreTxt = null;
    self._txtNoOpen = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._txt01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxt01");
         this._txt02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxt02");
         this._txt03 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxt03");
         this._txt04 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxtNeed");
         this._txt05 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxt04");
         this._scoreTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxtNeed");
         this._txtNoOpen = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("mounts.wildsoulTipTxt05");
         this.addChild(this._txt01);
         this.addChild(this._txt02);
         this.addChild(this._txt03);
         this.addChild(this._txt04);
         this.addChild(this._scoreTxt);
         this.addChild(this._txt05);
         this.addChild(this._txtNoOpen);
      }
    $$updateTransform() {
         var _loc10_ = null;
         var _loc1_ = null;
         var _loc2_ = null;
         var _loc5_ = null;
         var _loc9_ = 0;
         var _loc6_ = null;
         var _loc4_ = 0;
         var _loc3_ = null;
         var _loc8_ = null;
         var _loc7_ = null;
         this._txt01.htmlText = "";
         this._txt02.htmlText = "";
         this._txt03.htmlText = "";
         this._txt04.htmlText = "";
         this._txt05.htmlText = "";
         this._txtNoOpen.htmlText = "";
         this._scoreTxt.htmlText = "";
         if(this.tipData)
         {
            if($.is(this.tipData, "String"))
            {
               this._txtNoOpen.text = $.as(this.tipData, "String");
               this._bg.height = 40;
               this._bg.width = 195;
            }
            if($.is(this.tipData, $.C("yishi.datas.templates.MountTemplate")))
            {
               _loc10_ = $.as(this.tipData, $.C("yishi.datas.templates.MountTemplate"));
               _loc1_ = $.C("managers.MountsManager").instance.avatarList.getWildSoulInfo(_loc10_.TemplateId);
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips01").split("|");
               _loc5_ = "";
               _loc9_ = 0;
               if(_loc10_.MountType == 1)
               {
                  _loc9_ = $.int(_loc10_.Speed);
               }
               _loc6_ = [_loc10_.Power,_loc10_.Intellect,_loc10_.Physique,_loc10_.Agility,_loc10_.ExpandLevel,_loc9_];
               if(_loc2_.length >= _loc6_.length)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_.length)
                  {
                     if(_loc6_[_loc4_] != 0)
                     {
                        _loc5_ += $.C("yishi.utils.StringHelper").format(_loc2_[_loc4_],_loc6_[_loc4_]) + "<br/>";
                     }
                     _loc4_++;
                  }
               }
               this._scoreTxt.htmlText = $.C("manager.LanguageMgr").GetTranslation("mountTip.soulscore",_loc10_.SoulScore);
               if(_loc10_.MountType == 0)
               {
                  if(_loc1_)
                  {
                     this._txt01.htmlText = _loc10_.TemplateName;
                     this._txt03.htmlText = _loc10_.Description;
                     this._scoreTxt.y = this._txt01.y + this._txt01.textHeight + 10;
                     if(this._scoreTxt.textHeight == 0)
                     {
                        this._txt03.y = this._scoreTxt.y;
                     }
                     else
                     {
                        this._txt03.y = this._scoreTxt.y + this._scoreTxt.textHeight + 10;
                     }
                     if(this._scoreTxt.textHeight == 0 && this._txt03.textHeight == 0)
                     {
                        this._bg.height = this._txt03.y + this._txt03.textHeight + 5;
                     }
                     else
                     {
                        this._bg.height = this._txt03.y + this._txt03.textHeight + 15;
                     }
                  }
                  else
                  {
                     this._txtNoOpen.text = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips03",_loc10_.Property2);
                     this._scoreTxt.htmlText = "";
                     this._bg.height = 40;
                  }
               }
               else
               {
                  this._txt01.htmlText = _loc10_.TemplateName;
                  this._txt02.htmlText = _loc5_;
                  this._txt03.htmlText = _loc10_.Description;
                  _loc3_ = [];
                  if(_loc10_.NeedMountGrade > 0)
                  {
                     _loc3_.push($.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips.NeedGrade",_loc10_.NeedMountGrade));
                  }
                  if(_loc10_.NeedItemId != 0)
                  {
                     _loc8_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc10_.NeedItemId);
                     if(_loc8_)
                     {
                        _loc3_.push(_loc8_.TemplateName);
                     }
                  }
                  _loc7_ = _loc3_.join("\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
                  this._txt04.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.MountTip.NeedGood",_loc7_);
                  if(_loc10_.validity != 0)
                  {
                     if(_loc10_.validity < 0)
                     {
                        this._txt05.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.forever");
                     }
                     else
                     {
                        this._txt05.htmlText = $.C("manager.LanguageMgr").GetTranslation("mounts.WildsoulItem.tips02",_loc10_.validity);
                     }
                  }
                  else
                  {
                     this._txt05.htmlText = "";
                  }
                  this._txt02.y = this._txt01.y + this._txt01.textHeight + 10;
                  if(this._txt02.textHeight == 0)
                  {
                     this._scoreTxt.y = this._txt02.y;
                  }
                  else
                  {
                     this._scoreTxt.y = this._txt02.y + this._txt02.textHeight + 10;
                  }
                  this._scoreTxt.y = this._txt02.y + this._txt02.textHeight + 10;
                  if(this._scoreTxt.textHeight == 0)
                  {
                     this._txt03.y = this._scoreTxt.y;
                  }
                  else
                  {
                     this._txt03.y = this._scoreTxt.y + this._scoreTxt.textHeight + 10;
                  }
                  if(this._txt03.textHeight == 0)
                  {
                     this._txt04.y = this._txt03.y;
                  }
                  else
                  {
                     this._txt04.y = this._txt03.y + this._txt03.textHeight + 10;
                  }
                  if(this._txt04.textHeight == 0)
                  {
                     this._txt05.y = this._txt04.y;
                  }
                  else
                  {
                     this._txt05.y = this._txt04.y + this._txt04.textHeight + 10;
                  }
                  if(this._txt05.textHeight == 0)
                  {
                     this._bg.height = this._txt05.y + 5;
                  }
                  else
                  {
                     this._bg.height = this._txt05.y + this._txt05.textHeight + 15;
                  }
               }
               this._bg.width = 195;
            }
         }
      }
    get height() {
         return this._bg.height;
      }
    dispose() {
         this._txt01 = null;
         this._txt02 = null;
         this._txt03 = null;
         this._txt04 = null;
         this._txt05 = null;
         this._scoreTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
    set height(v) { super.height = v; }
  }
  $.meta(__WarlordMountTip, "yishi.view.tips.WarlordMountTip", []);
  return __WarlordMountTip;
}
deps["yishi.view.tips.WarlordMountTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "managers.MountsManager", "yishi.datas.templates.MountTemplate", "yishi.manager.TempleteManager", "yishi.utils.StringHelper", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.WaterTreeTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __WaterTreeTip extends __Base {
    static $fields(self) {
    self._name = null;
    self._contentTxt = null;
    self._line1 = null;
    }
    constructor() {
         super();
         this._name = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildNameText");
         this._line1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.HeroTipLine1");
         this._contentTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.BuildEffectText");
         this._name.y = 8;
         this._line1.y = 34;
         this._contentTxt.y = 42;
         this.addChild(this._name);
         this.addChild(this._line1);
         this.addChild(this._contentTxt);
      }
    $$updateTransform() {
         if(this.tipData)
         {
            this._line1.width = this._bg.displayWidth - 15;
            this._contentTxt.width = this._bg.displayWidth - 16;
            this._name.text = this.tipData.title;
            this._contentTxt.text = this.tipData.content;
            this._contentTxt.height = this._contentTxt.textHeight + 10;
            this._bg.height = this._contentTxt.y + this._contentTxt.textHeight + 20;
         }
      }
    dispose() {
         if(this._name)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._name);
         }
         this._name = null;
         if(this._contentTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._contentTxt);
         }
         this._contentTxt = null;
         if(this._line1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line1);
         }
         this._line1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__WaterTreeTip, "yishi.view.tips.WaterTreeTip", []);
  return __WaterTreeTip;
}
deps["yishi.view.tips.WaterTreeTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.goods.ComposeTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.goods.EquipTip");
  class __ComposeTip extends __Base {
    static $fields(self) {
    self._box1 = null;
    self._title = null;
    self._needGrade = null;
    self._describe = null;
    self._sendTxt = null;
    self._timeText = null;
    self._needTxt = null;
    self._bindText = null;
    self._studyTxt = null;
    self._itemIcon = null;
    self._profileImg = null;
    self._container = null;
    self._splitLine$ComposeTip = null;
    self._bandSprite = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._container = new ($.C("flash.display.Sprite"))();
         this._bandSprite = new ($.C("flash.display.Sprite"))();
         this._itemIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._splitLine$ComposeTip = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._box1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsSubBox");
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText");
         this._sendTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsSendTxt");
         this._title.x = 81;
         this._title.y = 20;
         this._title.height = 40;
         this._needGrade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodGradeText_2");
         this._describe = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ComposeDescribeText");
         this._timeText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsTimeTxt");
         this._needTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.ComposeNeedTxt");
         this._needTxt.width = 330;
         this._bindText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodBindText2");
         this._studyTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodStudyText");
         this.addChild(this._totalBox);
         this._totalBox.x = this._totalBox.y = 10;
         this._totalBox.spacing = 6;
         this._box1.spacing = 0;
         this._container.addChild(this._itemIcon);
         this._container.addChild(this._profileImg);
         var _loc1_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.ComposeTip.vStudy");
         this._needGrade.x = 100;
         this._studyTxt.text = _loc1_;
         this._studyTxt.x = 165;
         this._describe.width = 330;
      }
    $$updateTransform() {
         var _loc8_ = null;
         var _loc9_ = null;
         var _loc1_ = null;
         var _loc7_ = null;
         var _loc2_ = null;
         var _loc6_ = null;
         var _loc4_ = false;
         var _loc3_ = 0;
         var _loc5_ = null;
         if(this.tipData)
         {
            this.clean();
            _loc8_ = $.as(this.tipData, $.C("yishi.datas.goods.GoodsInfo"));
            this._title.text = _loc8_.templateInfo.TemplateName;
            this._title.setFrame(_loc8_.templateInfo.Profile);
            this._itemIcon.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(_loc8_.templateInfo.TemplateId);
            this._profileImg.setFrame(_loc8_.templateInfo.Profile);
            this._needGrade.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTipsContent.grade02",_loc8_.templateInfo.NeedGrades);
            this._describe.text = _loc8_.templateInfo.Description;
            this._describe.height = this._describe.textHeight + this._describe.numLines * 2;
            if(this._describe.height < 18)
            {
               this._describe.height = 18;
            }
            if(_loc8_.isBinds)
            {
               this._bindText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
               this._bindText.setFrame(1);
            }
            else
            {
               this._bindText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
               this._bindText.setFrame(2);
            }
            this._container.addChild(this._title);
            this._bandSprite.addChild(this._bindText);
            this._bindText.x = 0;
            this._bindText.y = 0;
            this._box1.addChild(this._container);
            _loc9_ = $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
            if(_loc9_.composeList.indexOf(_loc8_.templateInfo.Property1) >= 0)
            {
               this._box1.addChild(this._studyTxt);
            }
            if(_loc8_.templateInfo.SonType == 211)
            {
               this._bandSprite.addChild(this._needGrade);
            }
            this._box1.addChild(this._bandSprite);
            this._box1.addChild(this._describe);
            this._totalBox.addChild(this._box1);
            _loc1_ = "";
            _loc7_ = $.C("yishi.manager.TempleteManager").instance.getComposeTempleteById(_loc8_.templateInfo.Property1);
            if(_loc7_)
            {
               _loc2_ = new ($.C("yishi.datas.goods.GoodsInfo"))();
               _loc2_.templateId = _loc7_.NewMaterial;
               if(_loc2_.templateInfo.MasterType == 1)
               {
                  this._equipTipsContent.spacing = 0;
                  this._equipTipsContent.data = _loc2_;
                  this._totalBox.addChild(this._equipTipsContent);
               }
               _loc4_ = false;
               _loc3_ = 1;
               while(_loc3_ < 5)
               {
                  if(_loc7_["Material" + _loc3_] > 0)
                  {
                     if(!_loc4_)
                     {
                        this._totalBox.addChild(this._splitLine$ComposeTip);
                        this._splitLine$ComposeTip.width = 210;
                     }
                     _loc6_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc7_["Material" + _loc3_]);
                     _loc1_ += _loc6_.TemplateName + "*" + _loc7_["Count" + _loc3_];
                     _loc4_ = true;
                  }
                  _loc3_++;
               }
            }
            this._needTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.ComposeTip.need") + _loc1_;
            this._needTxt.height = this._needTxt.textHeight + this._needTxt.numLines * 4;
            if(!$.C("yishi.utils.StringHelper").isNullOrEmpty(_loc1_))
            {
               this._totalBox.addChild(this._needTxt);
            }
            if(_loc8_.validDate > 0)
            {
               this._totalBox.addChild(this._timeText);
            }
            if(_loc8_.leftTime == -1)
            {
               _loc5_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
            }
            else if(_loc8_.leftTime < 0)
            {
               _loc5_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
            }
            else
            {
               _loc5_ = $.C("yishi.utils.DateFormatter").getFullDateString(_loc8_.leftTime);
            }
            this._timeText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTip.time.text") + ":" + _loc5_;
            this._price.text = _loc8_.templateInfo.SellGold == 0 ? "" : $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.PropTips.price",_loc8_.templateInfo.SellGold);
            this._sendTxt.text = "shift+" + $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTip.send.text");
            if(_loc8_.id != 0)
            {
               this._totalBox.addChild(this._sendTxt);
               this._totalBox.addChild(this._price);
               this._bandSprite.addChild(this._bindText);
               this._bindText.visible = true;
            }
            else
            {
               if(this._sendTxt.parent)
               {
                  this._sendTxt.parent.removeChild(this._sendTxt);
               }
               this._bindText.visible = false;
            }
            this._price.x = 68;
            this._bg.height = -this._bg.y + this._totalBox.y + this._totalBox.height + 20;
            this._yellowBg.height = this._bg.height - 9;
            this._yellowBg.width = this._bg.width;
            this._purpleBg.height = this._bg.height - 9;
            this._purpleBg.width = this._bg.width;
            this._blueBg.height = this._bg.height - 9;
            this._blueBg.width = this._bg.width;
            this._greenBg.height = this._bg.height - 9;
            this._greenBg.width = this._bg.width;
            this._whiteBg.height = this._bg.height - 9;
            this._whiteBg.width = this._bg.width;
            this.showProfileBg(_loc8_.templateInfo.Profile);
         }
      }
    clean() {
         this._totalBox.removeAllChild();
         this._box1.removeAllChild();
      }
    showProfileBg(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._bg.visible = false;
         this._yellowBg.visible = false;
         this._purpleBg.visible = false;
         this._blueBg.visible = false;
         this._greenBg.visible = false;
         this._whiteBg.visible = false;
         this._redBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               this._whiteBg.visible = true;
               this._whiteBg.y = this._bg.y + 9;
               break;
            case 1:
               this._greenBg.visible = true;
               this._greenBg.y = this._bg.y - 9;
               break;
            case 2:
               this._blueBg.visible = true;
               this._blueBg.y = this._bg.y + 9;
               break;
            case 3:
               this._purpleBg.visible = true;
               this._purpleBg.y = this._bg.y + 9;
               break;
            case 4:
               this._yellowBg.visible = true;
               this._yellowBg.y = this._bg.y + 9;
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._container);
         if(this._bandSprite)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._bandSprite);
         }
         this._bandSprite = null;
         if(this._itemIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemIcon);
         }
         this._itemIcon = null;
         if(this._splitLine$ComposeTip)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._splitLine$ComposeTip);
         }
         this._splitLine$ComposeTip = null;
         if(this._profileImg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._profileImg);
         }
         this._profileImg = null;
         if(this._timeText)
         {
            this._timeText.dispose();
         }
         this._timeText = null;
         if(this._box1)
         {
            this._box1.dispose();
         }
         this._box1 = null;
         if(this._title)
         {
            this._title.dispose();
         }
         this._title = null;
         if(this._needGrade)
         {
            this._needGrade.dispose();
         }
         this._needGrade = null;
         if(this._describe)
         {
            this._describe.dispose();
         }
         this._describe = null;
         if(this._needTxt)
         {
            this._needTxt.dispose();
         }
         this._needTxt = null;
         if(this._bindText)
         {
            this._bindText.dispose();
         }
         this._bindText = null;
         if(this._studyTxt)
         {
            this._studyTxt.dispose();
         }
         this._studyTxt = null;
         if(this._sendTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._sendTxt);
         }
         this._sendTxt = null;
         if(this._container)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._container);
         }
         this._container = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__ComposeTip, "yishi.view.tips.goods.ComposeTip", []);
  return __ComposeTip;
}
deps["yishi.view.tips.goods.ComposeTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "yishi.datas.goods.GoodsInfo", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.utils.DateFormatter", "yishi.utils.IconFactory", "yishi.utils.StringHelper", "yishi.view.tips.goods.EquipTip"];

defs["yishi.view.tips.goods.EquipContrastTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __EquipContrastTips extends __Base {
    static $fields(self) {
    self._goodstip1 = null;
    self._goodstip2 = null;
    self._goodstip3 = null;
    }
    constructor() {
         super();
      }
    init() {
         this._goodstip1 = new ($.C("yishi.view.tips.goods.EquipTip"))();
         this._goodstip1.y = 25;
         this._goodstip2 = new ($.C("yishi.view.tips.goods.EquipTip"))();
         this._goodstip2.type = 1;
         this._goodstip2.y = 25;
         this._goodstip3 = new ($.C("yishi.view.tips.goods.EquipTip"))();
         this._goodstip3.type = 1;
         this._goodstip3.y = 25;
      }
    set direction(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         switch(param1)
         {
            case 0:
            case 2:
            case 5:
            case 7:
               this._goodstip1.x = 0;
               if(this._goodstip2.tipData)
               {
                  this._goodstip2.x = this._goodstip1.x + this._goodstip1.width + 5;
                  if(this._goodstip3.tipData)
                  {
                     this._goodstip3.x = this._goodstip2.x + this._goodstip2.width + 5;
                  }
                  break;
               }
               if(this._goodstip3.tipData)
               {
                  this._goodstip3.x = 0;
                  this._goodstip1.x = this._goodstip1.x + this._goodstip1.width + 5;
               }
               break;
            case 1:
            case 3:
            case 4:
            case 6:
               if(this._goodstip2.tipData)
               {
                  this._goodstip2.x = 0;
                  if(this._goodstip3.tipData)
                  {
                     this._goodstip3.x = this._goodstip2.x + this._goodstip2.width + 5;
                     this._goodstip1.x = this._goodstip3.x + this._goodstip3.width + 5;
                  }
                  else
                  {
                     this._goodstip1.x = this._goodstip2.x + this._goodstip2.width + 5;
                  }
               }
               else if(this._goodstip3.tipData)
               {
                  this._goodstip3.x = 0;
                  this._goodstip1.x = this._goodstip3.x + this._goodstip3.width + 5;
               }
               else
               {
                  this._goodstip1.x = 0;
               }
         }
         this._goodstip1.x = Math.round(this._goodstip1.x);
         this._goodstip1.y = Math.round(this._goodstip1.y);
         this._goodstip2.x = Math.round(this._goodstip2.x);
         this._goodstip2.y = Math.round(this._goodstip2.y);
         this._goodstip3.x = Math.round(this._goodstip3.x);
         this._goodstip3.y = Math.round(this._goodstip3.y);
      }
    set tipData(param1) {
         var _loc2_ = null;
         this.clean();
         this._data = param1;
         if(!this._data)
         {
            return;
         }
         this._goodstip1.tipData = this._data;
         this.addChild(this._goodstip1);
         var _loc3_ = $.C("yishi.manager.GoodsManager").instance.getHeroGoodsListBySonTypeAndId(($.as(this._data, $.C("yishi.datas.goods.GoodsInfo"))).templateInfo.SonType,this.thane.id).getList();
         var _loc4_ = _loc3_.filter($.C("bag.helper.GoodsCheck").filterGoodsForVice);
         _loc4_.sortOn("pos");
         if(_loc4_.length >= 2)
         {
            if($.C("bag.helper.GoodsCheck").getEquipFighting($.as(_loc4_[0], $.C("yishi.datas.goods.GoodsInfo")),($.as(_loc4_[0], $.C("yishi.datas.goods.GoodsInfo"))).templateInfo) >= $.C("bag.helper.GoodsCheck").getEquipFighting($.as(_loc4_[1], $.C("yishi.datas.goods.GoodsInfo")),($.as(_loc4_[1], $.C("yishi.datas.goods.GoodsInfo"))).templateInfo))
            {
               _loc2_ = $.as(_loc4_[1], $.C("yishi.datas.goods.GoodsInfo"));
            }
            else
            {
               _loc2_ = $.as(_loc4_[0], $.C("yishi.datas.goods.GoodsInfo"));
            }
            this._goodstip1.showEquipBg = true;
            this._goodstip1.setHight(true);
            this._goodstip2.tipData = _loc2_;
            this.addChild(this._goodstip2);
            this._goodstip1.x = 0;
            this._goodstip2.x = this._goodstip1.x + this._goodstip1.width + 5;
         }
         else if(_loc4_.length >= 1)
         {
            this._goodstip1.showEquipBg = true;
            _loc2_ = $.as(_loc4_[0], $.C("yishi.datas.goods.GoodsInfo"));
            this._goodstip2.tipData = _loc2_;
            this.addChild(this._goodstip2);
            this._goodstip1.x = 0;
            this._goodstip2.x = this._goodstip1.x + this._goodstip1.width + 5;
            this._goodstip1.setHight(true);
         }
         else
         {
            this._goodstip1.showEquipBg = false;
            this._goodstip1.setHight(false);
            this._goodstip1.x = 0;
         }
      }
    clean() {
         this._goodstip1.tipData = null;
         this._goodstip2.tipData = null;
         this._goodstip3.tipData = null;
         if(this._goodstip1.parent)
         {
            this.removeChild(this._goodstip1);
         }
         if(this._goodstip2.parent)
         {
            this.removeChild(this._goodstip2);
         }
         if(this._goodstip3.parent)
         {
            this.removeChild(this._goodstip3);
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    dispose() {
         if(this._goodstip1)
         {
            this._goodstip1.dispose();
         }
         this._goodstip1 = null;
         if(this._goodstip2)
         {
            this._goodstip2.dispose();
         }
         this._goodstip2 = null;
         if(this._goodstip3)
         {
            this._goodstip3.dispose();
         }
         this._goodstip3 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get direction() { return super.direction; }
    get tipData() { return super.tipData; }
    set thane(v) { super.thane = v; }
  }
  $.meta(__EquipContrastTips, "yishi.view.tips.goods.EquipContrastTips", []);
  return __EquipContrastTips;
}
deps["yishi.view.tips.goods.EquipContrastTips"] = ["bag.helper.GoodsCheck", "com.pickgliss.utils.ObjectUtils", "yishi.datas.goods.GoodsInfo", "yishi.manager.ArmyManager", "yishi.manager.GoodsManager", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.EquipTip"];

defs["yishi.view.tips.goods.FourEquipContrastTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __FourEquipContrastTips extends __Base {
    static $fields(self) {
    self.tip1 = null;
    self.tip2 = null;
    self.tip3 = null;
    self.tip4 = null;
    }
    constructor() {
         super();
      }
    init() {
         this.tip1 = new ($.C("yishi.view.tips.goods.FashionCardTip"))();
         this.tip2 = new ($.C("yishi.view.tips.goods.FashionCardTip"))();
         this.tip3 = new ($.C("yishi.view.tips.goods.FashionCardTip"))();
         this.tip4 = new ($.C("yishi.view.tips.goods.FashionCardTip"))();
      }
    set tipData(param1) {
         var _loc2_ = 0;
         var _loc3_ = 0;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            if(param1[_loc2_])
            {
               _loc3_ = _loc2_ + 1;
               this["tip" + _loc3_].tipData = param1[_loc2_];
               this.addChild(this["tip" + _loc3_]);
            }
            _loc2_++;
         }
         this.tip2.x = this.tip1.x + this.tip1.width;
         this.tip3.x = this.tip2.x + this.tip2.width;
         this.tip4.x = this.tip3.x + this.tip3.width;
      }
    dispose() {
         if(this.tip1)
         {
            this.tip1.dispose();
         }
         this.tip1 = null;
         if(this.tip2)
         {
            this.tip2.dispose();
         }
         this.tip2 = null;
         if(this.tip3)
         {
            this.tip3.dispose();
         }
         this.tip3 = null;
         if(this.tip4)
         {
            this.tip4.dispose();
         }
         this.tip4 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get tipData() { return super.tipData; }
  }
  $.meta(__FourEquipContrastTips, "yishi.view.tips.goods.FourEquipContrastTips", []);
  return __FourEquipContrastTips;
}
deps["yishi.view.tips.goods.FourEquipContrastTips"] = ["com.pickgliss.utils.ObjectUtils", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.FashionCardTip"];

defs["yishi.view.tips.goods.RuneTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __RuneTips extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._method = null;
    self._vBox1 = null;
    self._title1 = null;
    self._cooldown1 = null;
    self._cost1 = null;
    self._describe1 = null;
    self._spliceLine = null;
    self._nextGrade = null;
    self._vBox2 = null;
    self._title2 = null;
    self._cooldown2 = null;
    self._cost2 = null;
    self._describe2 = null;
    self._need = null;
    self._condition1 = null;
    self._needGoods = null;
    self._stoneContents = null;
    self.LOW_RUNESECRET_TEMPID = 3021001;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 360;
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillTotalBox");
         this._method = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillTypeText");
         this._vBox1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillSubBox");
         this._title1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNameText");
         this._cooldown1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._cost1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._describe1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillDescribe1");
         this._spliceLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillSpliceLine");
         this._nextGrade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNextGradeTxt");
         this._vBox2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillSubBox");
         this._title2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNameText");
         this._cooldown2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._cost2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._describe2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillDescribe2");
         this._need = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNeedTxt");
         this._needGoods = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.RuneTipsNeedTxt");
         this._stoneContents = new ($.C("yishi.view.tips.rune.RuneStoneGroupContent"))();
         this.addChild(this._totalBox);
         this._bg.height = this._totalBox.x + this._totalBox.height + 10;
         this._method.x = 185;
         this._describe1.width = 320;
         this._describe2.width = 320;
         this._bg.width = this._totalBox.width + 30 > this._bg.width ? this._totalBox.width + 30 : Number(this._bg.width);
      }
    $$updateTransform() {
         var _loc8_ = null;
         var _loc6_ = null;
         var _loc7_ = null;
         var _loc13_ = null;
         var _loc11_ = null;
         var _loc1_ = null;
         var _loc10_ = null;
         var _loc12_ = null;
         var _loc9_ = null;
         var _loc5_ = null;
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc3_ = null;
         var _loc14_ = null;
         if($.is(this.tipData, $.C("mvc.module.armyII.RuneInfo")))
         {
            this.clean();
            _loc13_ = $.as(this.tipData, $.C("mvc.module.armyII.RuneInfo"));
            _loc11_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(_loc13_.templateInfo.SkillTemplateId);
            _loc1_ = _loc13_.nextTemplateInfo;
            if(_loc1_)
            {
               _loc10_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(_loc1_.SkillTemplateId);
            }
            this._method.text = this.getSkillType(_loc11_);
            this._method.width = this._method.textWidth + 10;
            if(_loc13_.grade == 0)
            {
               this._title2.htmlText = _loc1_.TemplateName;
               this._vBox2.addChild(this._title2);
               this._vBox2.addChild(this._method);
               if(_loc10_.CoolDown > 0)
               {
                  this._cooldown2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc10_.CoolDown * 0.001);
                  this._vBox2.addChild(this._cooldown2);
               }
               if(_loc1_.UseCount > 0)
               {
                  this._cost2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.RuneTips.userCount",_loc1_.UseCount);
                  this._vBox2.addChild(this._cost2);
               }
               this._describe2.text = _loc1_.Description;
               this._describe2.height = this._describe2.textHeight + 10;
               this._vBox2.addChild(this._describe2);
               _loc8_ = _loc13_.checkUpgradeCondition(_loc1_);
               if(_loc8_.length > 0)
               {
                  this._need.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.need");
                  this._vBox2.addChild(this._need);
               }
               for (_loc6_ of $.values(_loc8_))
               {
                  this._condition1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillConditionTxt");
                  this._condition1.text = _loc6_;
                  this._vBox2.addChild(this._condition1);
               }
               if(_loc13_.nextTemplateInfo.Level < 1)
               {
                  _loc9_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getGoodsTemplatesBySonType(302);
                  for (_loc12_ of $.values(_loc9_))
                  {
                     if(_loc12_.Property1 == _loc13_.templateInfo.RuneType)
                     {
                        _loc5_ = _loc12_.TemplateName;
                        this._needGoods.text = $.C("manager.LanguageMgr").GetTranslation("mounts.MountTip.NeedGood",_loc5_);
                        this._needGoods.height = this._needGoods.textHeight + 10;
                        this._vBox2.addChild(this._needGoods);
                     }
                  }
               }
               else if(_loc13_.nextTemplateInfo.Level >= 1)
               {
                  _loc4_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(3021001);
                  _loc2_ = _loc4_.TemplateName;
                  this._needGoods.text = $.C("manager.LanguageMgr").GetTranslation("mounts.MountTip.NeedGood",_loc2_) + "x10";
                  this._vBox2.addChild(this._needGoods);
               }
               this._totalBox.addChild(this._vBox2);
            }
            else if(_loc1_)
            {
               _loc7_ = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc13_.templateInfo.RuneGrade);
               if(_loc13_.templateInfo.RuneGrade > 0)
               {
                  this._title1.htmlText = _loc13_.templateInfo.TemplateName + " <font color=\'#ffffff\'>" + _loc7_ + "</font>";
               }
               else
               {
                  this._title1.htmlText = _loc13_.templateInfo.TemplateName;
               }
               this._vBox1.addChild(this._title1);
               this._vBox1.addChild(this._method);
               if(_loc11_.CoolDown > 0)
               {
                  this._cooldown1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc11_.CoolDown * 0.001);
                  this._vBox1.addChild(this._cooldown1);
               }
               if(_loc13_.templateInfo.UseCount > 0)
               {
                  this._cost1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.RuneTips.userCount",_loc13_.templateInfo.UseCount);
                  this._vBox1.addChild(this._cost1);
               }
               this._describe1.text = _loc13_.templateInfo.Description;
               this._describe1.height = this._describe1.textHeight + 10;
               this._vBox1.addChild(this._describe1);
               this._totalBox.addChild(this._vBox1);
               this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.nextGrade");
               this._totalBox.addChild(this._spliceLine);
               this._totalBox.addChild(this._nextGrade);
               _loc7_ = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc1_.RuneGrade);
               this._title2.htmlText = _loc1_.TemplateName + " <font color=\'#ffffff\'>" + _loc7_ + "</font>";
               this._vBox2.addChild(this._title2);
               if(_loc10_.CoolDown > 0)
               {
                  this._cooldown2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc10_.CoolDown * 0.001);
                  this._vBox2.addChild(this._cooldown2);
               }
               if(_loc1_.UseCount > 0)
               {
                  this._cost2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.RuneTips.userCount",_loc1_.UseCount);
                  this._vBox2.addChild(this._cost2);
               }
               this._describe2.text = _loc1_.Description;
               this._describe2.height = this._describe2.textHeight + 10;
               this._vBox2.addChild(this._describe2);
               _loc8_ = _loc13_.checkUpgradeCondition(_loc1_);
               if(_loc8_.length > 0)
               {
                  this._need.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.need");
                  this._vBox2.addChild(this._need);
               }
               for (_loc6_ of $.values(_loc8_))
               {
                  this._condition1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillConditionTxt");
                  this._condition1.text = _loc6_;
                  this._vBox2.addChild(this._condition1);
               }
               this._totalBox.addChild(this._vBox2);
            }
            else
            {
               _loc7_ = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc13_.templateInfo.RuneGrade);
               if(_loc13_.templateInfo.RuneGrade > 0)
               {
                  this._title1.htmlText = _loc13_.templateInfo.TemplateName + " <font color=\'#ffffff\'>" + _loc7_ + "</font>";
               }
               else
               {
                  this._title1.htmlText = _loc13_.templateInfo.TemplateName;
               }
               this._vBox1.addChild(this._title1);
               this._vBox1.addChild(this._method);
               if(_loc11_.CoolDown > 0)
               {
                  this._cooldown1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc11_.CoolDown * 0.001);
                  this._vBox1.addChild(this._cooldown1);
               }
               if(_loc13_.templateInfo.UseCount > 0)
               {
                  this._cost1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.RuneTips.userCount",_loc13_.templateInfo.UseCount);
                  this._vBox1.addChild(this._cost1);
               }
               this._describe1.text = _loc13_.templateInfo.Description;
               this._describe1.height = this._describe1.textHeight + 10;
               this._vBox1.addChild(this._describe1);
               this._totalBox.addChild(this._vBox1);
               this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.maxGrade");
               this._totalBox.addChild(this._nextGrade);
            }
            if(_loc13_.runeHole != null)
            {
               this._stoneContents.updateView(_loc13_);
               this._totalBox.addChild(this._stoneContents);
            }
            this._bg.height = this._totalBox.x + this._totalBox.height + 10;
            this._bg.width = this._totalBox.width + 30 > this._bg.width ? this._totalBox.width + 30 : Number(this._bg.width);
         }
         else if($.is(this.tipData, $.C("yishi.datas.templates.RuneTemplateInfo")))
         {
            this.clean();
            _loc3_ = $.as(this.tipData, $.C("yishi.datas.templates.RuneTemplateInfo"));
            _loc14_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(_loc3_.SkillTemplateId);
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc3_.RuneGrade);
            if(_loc3_.RuneGrade > 0)
            {
               this._title1.htmlText = _loc3_.TemplateName + " <font color=\'#ffffff\'>" + _loc7_ + "</font>";
            }
            else
            {
               this._title1.htmlText = _loc3_.TemplateName;
            }
            this._method.text = this.getSkillType(_loc14_);
            this._vBox1.addChild(this._title1);
            this._vBox1.addChild(this._method);
            if(_loc14_.CoolDown > 0)
            {
               this._cooldown1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc14_.CoolDown * 0.001);
               this._vBox1.addChild(this._cooldown1);
            }
            if(_loc3_.UseCount > 0)
            {
               this._cost1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.RuneTips.userCount",_loc3_.UseCount);
               this._vBox1.addChild(this._cost1);
            }
            this._describe1.text = _loc3_.Description;
            this._describe1.height = this._describe1.textHeight + 8;
            this._vBox1.addChild(this._describe1);
            this._totalBox.addChild(this._vBox1);
            this._bg.height = this._totalBox.x + this._totalBox.height + 10;
            this._bg.width = this._totalBox.width + 30 > this._bg.width ? this._totalBox.width + 30 : Number(this._bg.width);
         }
      }
    checkCondition(param1) {
         var _loc3_ = null;
         var _loc4_ = null;
         var _loc6_ = null;
         var _loc2_ = this.thane.runeCate.runeScript.split(",");
         for (var _loc5_ of $.values(_loc2_))
         {
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(param1.SkillTemplateId);
            _loc4_ = $.C("yishi.manager.TempleteManager").instance.getRuneTemplateByTid(_loc5_);
            _loc6_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(_loc4_.SkillTemplateId);
            if(_loc4_ && param1.SonType == _loc4_.SonType && _loc3_.Grades <= _loc6_.Grades)
            {
               this._condition1.setFrame(1);
               return;
            }
         }
         this._condition1.setFrame(2);
      }
    clean() {
         this._vBox1.removeAllChild();
         this._vBox2.removeAllChild();
         this._totalBox.removeAllChild();
      }
    dispose() {
         if(this._method)
         {
            this._method.dispose();
         }
         this._method = null;
         if(this._title1)
         {
            this._title1.dispose();
         }
         this._title1 = null;
         if(this._cooldown1)
         {
            this._cooldown1.dispose();
         }
         this._cooldown1 = null;
         if(this._cost1)
         {
            this._cost1.dispose();
         }
         this._cost1 = null;
         if(this._describe1)
         {
            this._describe1.dispose();
         }
         this._describe1 = null;
         if(this._spliceLine)
         {
            this._spliceLine.dispose();
         }
         this._spliceLine = null;
         if(this._nextGrade)
         {
            this._nextGrade.dispose();
         }
         this._nextGrade = null;
         if(this._title2)
         {
            this._title2.dispose();
         }
         this._title2 = null;
         if(this._cooldown2)
         {
            this._cooldown2.dispose();
         }
         this._cooldown2 = null;
         if(this._cost2)
         {
            this._cost2.dispose();
         }
         this._cost2 = null;
         if(this._describe2)
         {
            this._describe2.dispose();
         }
         this._describe2 = null;
         if(this._need)
         {
            this._need.dispose();
         }
         this._need = null;
         if(this._condition1)
         {
            this._condition1.dispose();
         }
         this._condition1 = null;
         if(this._needGoods)
         {
            this._needGoods.dispose();
         }
         this._needGoods = null;
         if(this._totalBox)
         {
            this._totalBox.dispose();
         }
         this._totalBox = null;
         if(this._vBox1)
         {
            this._vBox1.dispose();
         }
         this._vBox1 = null;
         if(this._vBox2)
         {
            this._vBox2.dispose();
         }
         this._vBox2 = null;
         if(this._stoneContents)
         {
            this._stoneContents.dispose();
         }
         this._stoneContents = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    getSkillType(param1) {
         if(param1.UseWay == 2)
         {
            return "";
         }
         switch(param1.AcceptObject)
         {
            case 1:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type01");
            case 2:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type02");
            case 3:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type03");
            case 4:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type04");
            case 5:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type05");
            case 6:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type06");
            case 7:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type07");
            case 8:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type08");
            case 9:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type09");
            case 10:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type10");
            case 11:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type11");
            case 12:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type12");
            case 13:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type13");
            case 14:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type14");
            case 15:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type15");
            case 16:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type16");
            case 17:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type17");
            case 18:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type18");
            case 19:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type19");
            case 20:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type20");
            case 21:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type21");
            default:
               return "";
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    set thane(v) { super.thane = v; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__RuneTips, "yishi.view.tips.goods.RuneTips", []);
  return __RuneTips;
}
deps["yishi.view.tips.goods.RuneTips"] = ["com.pickgliss.ui.ComponentFactory", "manager.LanguageMgr", "mvc.module.armyII.RuneInfo", "yishi.datas.templates.RuneTemplateInfo", "yishi.manager.ArmyManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip", "yishi.view.tips.rune.RuneStoneGroupContent"];

defs["yishi.view.tips.goods.SeedTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __SeedTip extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._sendTxt = null;
    self._nameTxt = null;
    self._matureTimeTxt = null;
    self._outputTxt = null;
    self._raisedCeilingTxt = null;
    self._dscTxt = null;
    self._specialTxt = null;
    self._describe = null;
    self._timeText = null;
    self._priceTxt = null;
    self._bindTxt = null;
    self._splitLine01 = null;
    self._splitLine02 = null;
    self._yellowBg = null;
    self._purpleBg = null;
    self._blueBg = null;
    self._greenBg = null;
    self._whiteBg = null;
    self._itemIcon = null;
    self._profileImg = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 300;
         this._yellowBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.yellowItemTipsBg");
         this._purpleBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.purpleItemTipsBg");
         this._blueBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.blueItemTipsBg");
         this._greenBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.greenItemTipsBg");
         this._whiteBg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("core.whiteItemTipsBg");
         this._itemIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._profileImg = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.profileImg");
         this._nameTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodNameText_3");
         this._bindTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodBindText2");
         this._specialTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsTypeTxt");
         this._timeText = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsTimeTxt");
         this._priceTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodPriceText");
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsTotalBox");
         this._matureTimeTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodGradeText");
         this._outputTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodGradeText");
         this._raisedCeilingTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodGradeText");
         this._dscTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodGradeText");
         this._splitLine01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._splitLine01.width = 210;
         this._splitLine02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._splitLine02.width = 210;
         this._sendTxt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.GoodsSendTxt");
         this._nameTxt.x = 76;
         this._nameTxt.y = 15;
         this._nameTxt.width = 220;
         this._specialTxt.width = 58;
         this._specialTxt.x = 0;
         this._specialTxt.y = 1;
         this._bindTxt.x = 0;
         this._bindTxt.y = 0;
         this._matureTimeTxt.width = 170;
         this._outputTxt.width = 170;
         this._totalBox.x = 10;
         this._totalBox.spacing = 4;
         this.addChild(this._yellowBg);
         this.addChild(this._purpleBg);
         this.addChild(this._blueBg);
         this.addChild(this._greenBg);
         this.addChild(this._whiteBg);
         this.addChild(this._itemIcon);
         this._itemIcon.x = 9;
         this.addChild(this._profileImg);
         this._profileImg.x = 8;
         this.addChild(this._nameTxt);
         this.addChild(this._totalBox);
         this._totalBox.y = 55;
         this._priceTxt.x = 70;
      }
    $$updateTransform() {
         var _loc5_ = null;
         var _loc3_ = null;
         var _loc1_ = null;
         var _loc2_ = null;
         var _loc4_ = null;
         if(this.tipData)
         {
            this.clean();
            _loc5_ = $.as(this.tipData, $.C("yishi.datas.goods.GoodsInfo"));
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc5_.templateId);
            this._itemIcon.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(_loc5_.templateInfo.TemplateId);
            this._profileImg.setFrame(_loc5_.templateInfo.Profile);
            if(_loc3_)
            {
               this._totalBox.addChild(this._specialTxt);
               this._totalBox.addChild(this._bindTxt);
               this._totalBox.addChild(this._splitLine01);
               this._totalBox.addChild(this._matureTimeTxt);
               this._totalBox.addChild(this._outputTxt);
               this._totalBox.addChild(this._raisedCeilingTxt);
               this._totalBox.addChild(this._dscTxt);
               this._totalBox.addChild(this._splitLine02);
               this._totalBox.addChild(this._sendTxt);
               this._totalBox.addChild(this._priceTxt);
               _loc1_ = "";
               _loc2_ = $.C("yishi.manager.TempleteManager").instance.goodsTemplateCate.getTemplateByID(_loc3_.Property2);
               this._nameTxt.text = _loc3_.TemplateName;
               this._nameTxt.setFrame(_loc3_.Profile);
               if($.int(_loc3_.Property1 / 60) <= 0)
               {
                  _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.needMinutes",_loc3_.Property1 % 60);
               }
               else if(_loc3_.Property1 % 60 == 0)
               {
                  _loc1_ = $.int(_loc3_.Property1 / 60) + $.C("manager.LanguageMgr").GetTranslation("public.time.hour");
               }
               else
               {
                  _loc1_ = $.C("manager.LanguageMgr").GetTranslation("public.needHM",$.int(_loc3_.Property1 / 60),_loc3_.Property1 % 60);
               }
               this._matureTimeTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SeedTip.matureTime",_loc1_);
               if(_loc2_)
               {
                  _loc1_ = _loc3_.Property3 + _loc2_.TemplateName;
               }
               else
               {
                  _loc1_ = _loc3_.Property3.toString();
               }
               this._outputTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SeedTip.output",_loc1_);
               if(_loc5_.templateInfo.SonType == 1500)
               {
                  this._raisedCeilingTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SeedTip.raisedCeilingTxt",_loc5_.templateInfo.Property5.toString());
               }
               else if(this._totalBox.contains(this._raisedCeilingTxt))
               {
                  this._totalBox.removeChild(this._raisedCeilingTxt);
               }
               this._dscTxt.text = _loc3_.Description;
               this._dscTxt.height = this._dscTxt.textHeight + 5;
               if(_loc3_.Property5 > 0)
               {
                  this._specialTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SeedTip.specialCrop");
               }
               else if(this._specialTxt.parent)
               {
                  this._specialTxt.parent.removeChild(this._specialTxt);
               }
               if(_loc5_.validDate > 0)
               {
                  this._totalBox.addChild(this._timeText);
               }
               if(_loc5_.leftTime == -1)
               {
                  _loc4_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTip.timeStr01");
               }
               else if(_loc5_.leftTime < 0)
               {
                  _loc4_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
               }
               else
               {
                  _loc4_ = $.C("yishi.utils.DateFormatter").getFullDateString(_loc5_.leftTime);
               }
               this._timeText.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTip.time.text") + ":" + _loc4_;
               if(_loc5_.id != 0)
               {
                  if(_loc5_.isBinds)
                  {
                     this._bindTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind1");
                     this._bindTxt.setFrame(1);
                  }
                  else
                  {
                     this._bindTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTipsContent.bind2");
                     this._bindTxt.setFrame(2);
                  }
                  this._priceTxt.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.PropTips.price",_loc3_.SellGold);
                  this._sendTxt.text = "shift+" + $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.EquipTip.send.text");
               }
               else
               {
                  if(this._splitLine01.parent)
                  {
                     this._splitLine01.parent.removeChild(this._splitLine01);
                  }
                  if(this._priceTxt.parent)
                  {
                     this._priceTxt.parent.removeChild(this._priceTxt);
                  }
                  if(this._bindTxt.parent)
                  {
                     this._bindTxt.parent.removeChild(this._bindTxt);
                  }
                  if(this._splitLine02.parent)
                  {
                     this._splitLine02.parent.removeChild(this._splitLine02);
                  }
                  if(this._sendTxt.parent)
                  {
                     this._sendTxt.parent.removeChild(this._sendTxt);
                  }
               }
            }
            this._totalBox.refreshChildPos();
            this._bg.height = this._totalBox.y + this._totalBox.height + 10;
            this._yellowBg.height = this._bg.height;
            this._purpleBg.height = this._bg.height;
            this._blueBg.height = this._bg.height;
            this._greenBg.height = this._bg.height;
            this._whiteBg.height = this._bg.height;
            this._yellowBg.width = this._bg.width;
            this._purpleBg.width = this._bg.width;
            this._blueBg.width = this._bg.width;
            this._greenBg.width = this._bg.width;
            this._whiteBg.width = this._bg.width;
            this._yellowBg.y = this._bg.y - 3;
            this._purpleBg.y = this._bg.y - 3;
            this._blueBg.y = this._bg.y - 3;
            this._greenBg.y = this._bg.y - 3;
            this._whiteBg.y = this._bg.y - 3;
            this.showProfileBg(_loc5_.templateInfo.Profile);
         }
      }
    showProfileBg(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         this._bg.visible = false;
         this._yellowBg.visible = false;
         this._purpleBg.visible = false;
         this._blueBg.visible = false;
         this._greenBg.visible = false;
         this._whiteBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               this._whiteBg.visible = true;
               break;
            case 1:
               this._greenBg.visible = true;
               break;
            case 2:
               this._blueBg.visible = true;
               break;
            case 3:
               this._purpleBg.visible = true;
               break;
            case 4:
               this._yellowBg.visible = true;
         }
      }
    clean() {
         while(this._totalBox.numChildren > 0)
         {
            this._totalBox.removeChildAt(this._totalBox.numChildren - 1);
         }
      }
    dispose() {
         if(this._yellowBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._yellowBg);
         }
         this._yellowBg = null;
         if(this._purpleBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._purpleBg);
         }
         this._purpleBg = null;
         if(this._blueBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._blueBg);
         }
         this._blueBg = null;
         if(this._greenBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._greenBg);
         }
         this._greenBg = null;
         if(this._whiteBg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._whiteBg);
         }
         this._whiteBg = null;
         if(this._itemIcon)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._itemIcon);
         }
         this._itemIcon = null;
         if(this._profileImg)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._profileImg);
         }
         this._profileImg = null;
         if(this._totalBox)
         {
            this._totalBox.dispose();
         }
         this._totalBox = null;
         if(this._timeText)
         {
            this._timeText.dispose();
         }
         this._timeText = null;
         if(this._splitLine01)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._splitLine01);
         }
         this._splitLine01 = null;
         if(this._splitLine02)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._splitLine02);
         }
         this._splitLine02 = null;
         if(this._nameTxt)
         {
            this._nameTxt.dispose();
         }
         this._nameTxt = null;
         if(this._matureTimeTxt)
         {
            this._matureTimeTxt.dispose();
         }
         this._matureTimeTxt = null;
         if(this._outputTxt)
         {
            this._outputTxt.dispose();
         }
         this._outputTxt = null;
         if(this._specialTxt)
         {
            this._specialTxt.dispose();
         }
         this._specialTxt = null;
         if(this._describe)
         {
            this._describe.dispose();
         }
         this._describe = null;
         if(this._priceTxt)
         {
            this._priceTxt.dispose();
         }
         this._priceTxt = null;
         if(this._bindTxt)
         {
            this._bindTxt.dispose();
         }
         this._bindTxt = null;
         if(this._sendTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._sendTxt);
         }
         this._sendTxt = null;
         if(this._dscTxt)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._dscTxt);
         }
         this._dscTxt = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
  }
  $.meta(__SeedTip, "yishi.view.tips.goods.SeedTip", []);
  return __SeedTip;
}
deps["yishi.view.tips.goods.SeedTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "yishi.datas.goods.GoodsInfo", "yishi.manager.TempleteManager", "yishi.utils.DateFormatter", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.goods.ShopGoodsTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.goods.EquipTip");
  class __ShopGoodsTips extends __Base {
    static $fields(self) {
    }
    constructor() {
         super();
      }
  }
  $.meta(__ShopGoodsTips, "yishi.view.tips.goods.ShopGoodsTips", []);
  return __ShopGoodsTips;
}
deps["yishi.view.tips.goods.ShopGoodsTips"] = ["yishi.view.tips.goods.EquipTip"];

defs["yishi.view.tips.goods.SkillNotShowGradeTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __SkillNotShowGradeTips extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._sp1 = null;
    self._line01 = null;
    self._icon = null;
    self._describe1 = null;
    self._title1 = null;
    self._level1 = null;
    self._method = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillTotalBox");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._method = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.skillCostTxt");
         this._title1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNameText_2");
         this._level1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._line01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._describe1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillDescribe1");
         this._sp1 = new ($.C("flash.display.Sprite"))();
         this.addChild(this._totalBox);
         this.addChild(this._icon);
         this._bg.width = 300;
      }
    clean() {
         this._totalBox.removeAllChild();
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc1_ = null;
         this.clean();
         if($.is(this.tipData, $.C("mvc.module.gamehall.GameHallBlessInfo")))
         {
            _loc2_ = $.as(this.tipData, $.C("mvc.module.gamehall.GameHallBlessInfo"));
            _loc1_ = _loc2_.skillTempInfo;
            this._icon.x = 11;
            this._icon.y = -11;
            this._icon.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc1_.Icons);
            this._level1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.levelTxt",_loc2_.level);
            this._title1.htmlText = _loc1_.TemplateName;
            this._method.text = this.getSkillType(_loc1_);
            this._sp1.addChild(this._title1);
            this._sp1.addChild(this._method);
            this._method.y = 41;
            this._sp1.addChild(this._level1);
            this._level1.y = 41;
            this._sp1.addChild(this._line01);
            this._line01.y = 65;
            this._describe1.text = _loc1_.Description;
            this._describe1.height = this._describe1.textHeight + 8;
            this._sp1.addChild(this._describe1);
            this._describe1.y = this._line01.y + 11;
            this._totalBox.addChild(this._sp1);
            this._bg.height = this._totalBox.height + 20;
         }
      }
    getSkillType(param1) {
         if(param1.UseWay == 2)
         {
            return "[" + $.C("manager.LanguageMgr").GetTranslation("yishi.datas.templates.SkillTempInfo.UseWay02") + "]";
         }
         switch(param1.AcceptObject)
         {
            case 1:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type01");
            case 2:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type02");
            case 3:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type03");
            case 4:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type04");
            case 5:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type05");
            case 6:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type06");
            case 7:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type07");
            case 8:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type08");
            case 9:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type09");
            case 10:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type10");
            case 11:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type11");
            case 12:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type12");
            case 13:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type13");
            case 14:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type14");
            case 15:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type15");
            case 16:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type16");
            case 17:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type17");
            case 18:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type18");
            case 19:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type19");
            case 20:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type20");
            case 21:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type21");
            default:
               return "";
         }
      }
  }
  $.meta(__SkillNotShowGradeTips, "yishi.view.tips.goods.SkillNotShowGradeTips", []);
  return __SkillNotShowGradeTips;
}
deps["yishi.view.tips.goods.SkillNotShowGradeTips"] = ["com.pickgliss.ui.ComponentFactory", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.gamehall.GameHallBlessInfo", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.goods.SkillShowCurrentGradeTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __SkillShowCurrentGradeTips extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._sp1 = null;
    self._line01 = null;
    self._icon = null;
    self._describe1 = null;
    self._title1 = null;
    self._level1 = null;
    self._method = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillTotalBox");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._method = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.skillCostTxt");
         this._title1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNameText_2");
         this._level1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._line01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._describe1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillDescribe1");
         this._sp1 = new ($.C("flash.display.Sprite"))();
         this.addChild(this._totalBox);
         this.addChild(this._icon);
         this._bg.width = 300;
      }
    clean() {
         this._totalBox.removeAllChild();
      }
    $$updateTransform() {
         var _loc2_ = null;
         var _loc1_ = null;
         var _loc3_ = null;
         this.clean();
         if($.is(this.tipData, $.C("mvc.module.gamehall.GameHallBlessInfo")))
         {
            _loc2_ = $.as(this.tipData, $.C("mvc.module.gamehall.GameHallBlessInfo"));
            _loc1_ = _loc2_.skillTempInfo;
            this._icon.x = 11;
            this._icon.y = -11;
            this._icon.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc1_.Icons);
            _loc3_ = _loc2_.level + "/" + _loc1_.Grades;
            this._level1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.levelTxt",_loc3_);
            this._title1.htmlText = _loc1_.TemplateName;
            this._method.text = this.getSkillType(_loc1_);
            this._sp1.addChild(this._title1);
            this._sp1.addChild(this._method);
            this._method.y = 41;
            this._sp1.addChild(this._level1);
            this._level1.y = 41;
            this._sp1.addChild(this._line01);
            this._line01.y = 65;
            this._describe1.text = _loc1_.Description;
            this._describe1.height = this._describe1.textHeight + 8;
            this._sp1.addChild(this._describe1);
            this._describe1.y = this._line01.y + 11;
            this._totalBox.addChild(this._sp1);
            this._bg.height = this._totalBox.height + 20;
         }
      }
    getSkillType(param1) {
         if(param1.UseWay == 2)
         {
            return "[" + $.C("manager.LanguageMgr").GetTranslation("yishi.datas.templates.SkillTempInfo.UseWay02") + "]";
         }
         switch(param1.AcceptObject)
         {
            case 1:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type01");
            case 2:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type02");
            case 3:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type03");
            case 4:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type04");
            case 5:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type05");
            case 6:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type06");
            case 7:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type07");
            case 8:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type08");
            case 9:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type09");
            case 10:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type10");
            case 11:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type11");
            case 12:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type12");
            case 13:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type13");
            case 14:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type14");
            case 15:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type15");
            case 16:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type16");
            case 17:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type17");
            case 18:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type18");
            case 19:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type19");
            case 20:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type20");
            case 21:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type21");
            default:
               return "";
         }
      }
  }
  $.meta(__SkillShowCurrentGradeTips, "yishi.view.tips.goods.SkillShowCurrentGradeTips", []);
  return __SkillShowCurrentGradeTips;
}
deps["yishi.view.tips.goods.SkillShowCurrentGradeTips"] = ["com.pickgliss.ui.ComponentFactory", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.gamehall.GameHallBlessInfo", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.goods.SkillTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __SkillTips extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._sp1 = null;
    self._sp2 = null;
    self._line01 = null;
    self._line02 = null;
    self._line03 = null;
    self._icon = null;
    self._method = null;
    self._title1 = null;
    self._level1 = null;
    self._cooldown1 = null;
    self._costSp1 = null;
    self._costHitPoint1 = null;
    self._costAvengerSp = null;
    self._describe1 = null;
    self._nextGrade = null;
    self._title2 = null;
    self._level2 = null;
    self._cooldown2 = null;
    self._costSp2 = null;
    self._costHitPoint2 = null;
    self._describe2 = null;
    self._method2 = null;
    self._need = null;
    self._condition1 = null;
    self._spliceLine = null;
    self._petSkillIcon = null;
    self._conditionVbox = null;
    self._petTypeList = null;
    self._petTypeNameList = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 300;
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillTotalBox");
         this._icon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         this._method = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.skillCostTxt");
         this._title1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNameText_2");
         this._level1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._cooldown1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._costSp1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.skillCostTxt");
         this._costHitPoint1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.skillCostTxt");
         this._describe1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillDescribe1");
         this._spliceLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillSpliceLine");
         this._nextGrade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNextGradeTxt");
         this._title2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNameText_2");
         this._level2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._method2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.skillCostTxt");
         this._cooldown2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._costSp2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.skillCostTxt");
         this._costHitPoint2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.skillCostTxt");
         this._describe2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillDescribe1");
         this._need = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNeedTxt");
         this._line01 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line02 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line03 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._petSkillIcon = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("petTip.PetTypeImage");
         this._costAvengerSp = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.skillCostTxt");
         this._sp1 = new ($.C("flash.display.Sprite"))();
         this._sp2 = new ($.C("flash.display.Sprite"))();
         this._conditionVbox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._petTypeList = [101,102,103,104,105,106,117,118,119,107];
         this._petTypeNameList = $.C("manager.LanguageMgr").GetTranslation("pet.petTypeList").split("|");
         this._bg.width = 300;
         this._petSkillIcon.x = 260;
         this._petSkillIcon.y = 23;
         this.addChild(this._totalBox);
         this.addChild(this._icon);
      }
    $$updateTransform() {
         var _loc5_ = null;
         var _loc1_ = null;
         var _loc2_ = null;
         var _loc4_ = 0;
         var _loc3_ = false;
         this.clean();
         if($.is(this.tipData, $.C("mvc.module.armyII.SkillInfo")))
         {
            _loc5_ = $.as(this.tipData, $.C("mvc.module.armyII.SkillInfo"));
            if(_loc5_.templateInfo.MasterType != 4)
            {
               _loc1_ = _loc5_.nextTemplateInfo;
            }
            this._method.text = this.getSkillType(_loc5_.templateInfo);
            this._icon.x = 11;
            this._icon.y = -11;
            this._icon.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc5_.templateInfo.Icons);
            _loc4_ = $.int(_loc5_.templateInfo.MasterType);
            _loc3_ = this._petTypeList.indexOf(_loc4_) >= 0;
            if(_loc3_ && this._petTypeNameList[this._petTypeList.indexOf(_loc4_)])
            {
               this._petSkillIcon.setFrame(this._petTypeList.indexOf(_loc4_) + 1);
               this.addChild(this._petSkillIcon);
            }
            else if(this._petSkillIcon.parent)
            {
               this._petSkillIcon.parent.removeChild(this._petSkillIcon);
            }
            if(_loc5_.grade == 0)
            {
               this.notLearn(_loc5_);
            }
            else if(_loc1_)
            {
               this.notFull(_loc5_);
            }
            else
            {
               this.fullSkill(_loc5_);
            }
         }
         else if($.is(this.tipData, $.C("yishi.datas.templates.SkillTempInfo")))
         {
            _loc2_ = $.as(this.tipData, $.C("yishi.datas.templates.SkillTempInfo"));
            this._icon.x = 11;
            this._icon.y = -11;
            this._icon.icon = $.C("yishi.utils.IconFactory").getTecIconByIcon(_loc2_.Icons);
            _loc4_ = $.int(_loc2_.MasterType);
            _loc3_ = this._petTypeList.indexOf(_loc4_) >= 0;
            if(_loc3_ && this._petTypeNameList[this._petTypeList.indexOf(_loc4_)])
            {
               this._petSkillIcon.setFrame(this._petTypeList.indexOf(_loc4_) + 1);
               this.addChild(this._petSkillIcon);
            }
            else if(this._petSkillIcon.parent)
            {
               this._petSkillIcon.parent.removeChild(this._petSkillIcon);
            }
            this._level1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.levelTxt",_loc2_.Grades);
            this._title1.htmlText = _loc2_.TemplateName;
            this._method.text = this.getSkillType(_loc2_);
            this._method.y = 41;
            this._level1.y = 41;
            this._sp1.addChild(this._title1);
            if(_loc2_.Grades > 0 || this.isTalent(_loc2_))
            {
               this._sp1.addChild(this._level1);
            }
            this._sp1.addChild(this._method);
            if(_loc2_.CoolDown > 0)
            {
               this._cooldown1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc2_.CoolDown * 0.001);
               this._sp1.addChild(this._cooldown1);
               this._cooldown1.y = 73;
            }
            else if(_loc3_)
            {
               this._cooldown1.text = "";
               this._sp1.addChild(this._cooldown1);
               this._cooldown1.y = 73;
            }
            if($.int(_loc2_.Cost) < 0)
            {
               this._costSp1.text = this.getCostString(_loc3_,$.int(_loc2_.Cost));
               this._sp1.addChild(this._costSp1);
               this._costSp1.y = 59;
            }
            if($.int(_loc2_.HitPointCost) < 0)
            {
               this._costHitPoint1.text = this.getCostString(_loc3_,$.int(_loc2_.HitPointCost),true);
               this._sp1.addChild(this._costHitPoint1);
               this._costHitPoint1.y = 77;
            }
            if((_loc2_.MasterType == 500 || _loc2_.MasterType == 501) && $.int(_loc2_.Cost) > 0)
            {
               this._costAvengerSp.text = this.getAvengerCostString($.int(_loc2_.Cost / 10));
               this._sp1.addChild(this._costAvengerSp);
               this._costAvengerSp.y = 77;
            }
            this._sp1.addChild(this._line01);
            this._line01.y = 0;
            if(!this._cooldown1.parent && !this._costSp1.parent && !this._costHitPoint1.parent)
            {
               this._line01.y = this._method.y + this._method.textHeight + 20;
            }
            else if(this._costHitPoint1.parent)
            {
               this._line01.y = this._costHitPoint1.y + this._costHitPoint1.textHeight + 18;
            }
            else if(this._costAvengerSp.parent)
            {
               this._line01.y = this._costAvengerSp.y + this._costAvengerSp.textHeight + 11;
            }
            else if(this._cooldown1.parent)
            {
               this._line01.y = this._cooldown1.y + this._cooldown1.textHeight + 11;
            }
            else if(this._costSp1.parent)
            {
               this._line01.y = this._costSp1.y + this._costSp1.textHeight + 20;
            }
            this._line01.y = this._line01.y == 0 ? this._level1.y + this._level1.textHeight + 6 : this._line01.y;
            this._describe1.text = _loc2_.Description;
            this._describe1.height = this._describe1.textHeight + 8;
            this._sp1.addChild(this._describe1);
            this._describe1.y = this._line01.y + 11;
            this._totalBox.addChild(this._sp1);
            this._bg.height = this._totalBox.height + 20;
         }
      }
    fullSkill(param1) {
         var _loc2_ = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",param1.templateInfo.Grades);
         var _loc4_ = $.int(param1.templateInfo.MasterType);
         var _loc3_ = this._petTypeList.indexOf(_loc4_) >= 0;
         this._title1.htmlText = param1.templateInfo.TemplateName;
         this._sp1.addChild(this._title1);
         this._sp1.addChild(this._method);
         this._method.y = 41;
         if(param1.templateInfo.Grades > 0 && _loc4_ != 4)
         {
            this._level1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.levelTxt",param1.templateInfo.Grades);
            this._sp1.addChild(this._level1);
            this._level1.y = 41;
         }
         if(param1.templateInfo.CoolDown > 0)
         {
            this._cooldown1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",param1.templateInfo.CoolDown * 0.001);
            this._sp1.addChild(this._cooldown1);
            this._cooldown1.y = 73;
         }
         if($.int(param1.templateInfo.Cost) < 0)
         {
            this._costSp1.text = this.getCostString(_loc3_,$.int(param1.templateInfo.Cost));
            this._sp1.addChild(this._costSp1);
            this._costSp1.y = 59;
         }
         if($.int(param1.templateInfo.HitPointCost) < 0)
         {
            this._costHitPoint1.text = this.getCostString(_loc3_,$.int(param1.templateInfo.HitPointCost),true);
            this._sp1.addChild(this._costHitPoint1);
            this._costHitPoint1.y = 77;
         }
         this._sp1.addChild(this._line01);
         this._line01.y = 0;
         if(!this._cooldown1.parent && !this._costSp1.parent && this._costHitPoint1.parent)
         {
            this._line01.y = this._method.y + this._method.textHeight + 20;
         }
         else if(this._costHitPoint1.parent)
         {
            this._line01.y = this._costHitPoint1.y + this._costHitPoint1.textHeight + 18;
         }
         else if(this._cooldown1.parent)
         {
            this._line01.y = this._cooldown1.y + this._cooldown1.textHeight + 20;
         }
         else if(this._costSp1.parent)
         {
            this._line01.y = this._costSp1.y + this._costSp1.textHeight + 20;
         }
         else
         {
            this._line01.y = 72;
         }
         this._line01.y = this._line01.y == 0 ? this._level1.y + this._level1.textHeight + 6 : this._line01.y;
         this._describe1.text = param1.templateInfo.Description;
         this._describe1.height = this._describe1.textHeight + 10;
         this._sp1.addChild(this._describe1);
         this._describe1.y = this._line01.y + 11;
         this._sp1.addChild(this._line02);
         this._line02.y = this._describe1.y + this._describe1.textHeight + 18;
         this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.maxGrade");
         if(_loc4_ != 4)
         {
            this._sp1.addChild(this._nextGrade);
         }
         this._nextGrade.y = this._line02.y + 11;
         this._totalBox.addChild(this._sp1);
         this._bg.height = this._totalBox.height + 20;
      }
    notFull(param1) {
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc6_ = $.int(param1.templateInfo.MasterType);
         var _loc5_ = this._petTypeList.indexOf(_loc6_) >= 0;
         var _loc3_ = param1.nextTemplateInfo;
         this._title1.htmlText = param1.templateInfo.TemplateName;
         this._sp1.addChild(this._title1);
         this._sp1.addChild(this._method);
         this._method.y = 41;
         if(param1.templateInfo.Grades > 0)
         {
            this._level1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.levelTxt",param1.templateInfo.Grades);
            this._sp1.addChild(this._level1);
            this._level1.y = 41;
         }
         if(param1.templateInfo.CoolDown > 0)
         {
            this._cooldown1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",param1.templateInfo.CoolDown * 0.001);
            this._sp1.addChild(this._cooldown1);
            this._cooldown1.y = 73;
         }
         if($.int(param1.templateInfo.Cost) < 0)
         {
            this._costSp1.text = this.getCostString(_loc5_,$.int(param1.templateInfo.Cost));
            this._sp1.addChild(this._costSp1);
            this._costSp1.y = 59;
         }
         if($.int(param1.templateInfo.HitPointCost) < 0)
         {
            this._costHitPoint1.text = this.getCostString(_loc5_,$.int(param1.templateInfo.HitPointCost),true);
            this._sp1.addChild(this._costHitPoint1);
            this._costHitPoint1.y = 77;
         }
         this._sp1.addChild(this._line01);
         this._line01.y = 0;
         if(!this._costSp1.parent && !this._cooldown1.parent && !this._costHitPoint1.parent)
         {
            this._line01.y = this._method.y + this._method.textHeight + 20;
         }
         else if(this._costHitPoint1.parent)
         {
            this._line01.y = this._costHitPoint1.y + this._costHitPoint1.textHeight + 18;
         }
         else if(this._cooldown1.parent)
         {
            this._line01.y = this._cooldown1.y + this._cooldown1.textHeight + 20;
         }
         else if(this._costSp1.parent)
         {
            this._line01.y = this._costSp1.y + this._costSp1.textHeight + 20;
         }
         this._line01.y = this._line01.y == 0 ? this._level1.y + this._level1.textHeight + 6 : this._line01.y;
         this._describe1.text = param1.templateInfo.Description;
         this._describe1.height = this._describe1.textHeight + 10;
         this._sp1.addChild(this._describe1);
         this._describe1.y = this._line01.y + 11;
         this._totalBox.addChild(this._sp1);
         this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.nextGrade");
         this._totalBox.addChild(this._spliceLine);
         this._sp2.addChild(this._nextGrade);
         this._nextGrade.y = 6;
         this._title2.htmlText = _loc3_.TemplateName;
         this._level2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.levelTxt",_loc3_.Grades);
         this._sp2.addChild(this._title2);
         this._title2.numLines == 2 ? (this._title2.y = -5) : (Number(this._title2.y = 6));
         this._method2.text = this._method.text;
         this._sp2.addChild(this._method2);
         this._method2.y = 29;
         this._sp2.addChild(this._level2);
         this._level2.y = 29;
         if(_loc3_.CoolDown > 0)
         {
            this._cooldown2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc3_.CoolDown * 0.001);
            this._sp2.addChild(this._cooldown2);
            this._cooldown2.y = 60;
         }
         if($.int(_loc3_.Cost) < 0)
         {
            this._costSp2.text = this.getCostString(_loc5_,$.int(_loc3_.Cost));
            this._sp2.addChild(this._costSp2);
            this._costSp2.y = 47;
         }
         if($.int(_loc3_.HitPointCost) < 0)
         {
            this._costHitPoint2.text = this.getCostString(_loc5_,$.int(_loc3_.HitPointCost),true);
            this._sp2.addChild(this._costHitPoint2);
            this._costHitPoint2.y = 65;
         }
         this._sp2.addChild(this._line02);
         if(!this._costSp2.parent && !this._cooldown2.parent && !this._costHitPoint2.parent)
         {
            this._line02.y = this._method2.y + this._method2.textHeight + 20;
         }
         else if(this._costHitPoint2.parent)
         {
            this._line02.y = this._costHitPoint2.y + this._costHitPoint2.textHeight + 18;
         }
         else if(this._cooldown2.parent)
         {
            this._line02.y = this._cooldown2.y + this._cooldown2.textHeight + 20;
         }
         else if(this._costSp2.parent)
         {
            this._line02.y = this._costSp2.y + this._costSp2.textHeight + 20;
         }
         this._describe2.text = _loc3_.Description;
         this._describe2.height = this._describe2.textHeight + 10;
         this._sp2.addChild(this._describe2);
         this._describe2.y = this._line02.y + 11;
         _loc4_ = param1.checkUpgradeCondition(_loc3_);
         if(_loc4_.length > 0)
         {
            this._sp2.addChild(this._line03);
            this._line03.y = this._describe2.y + this._describe2.height;
            this._need.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.need");
            this._sp2.addChild(this._need);
            this._need.y = this._line03.y + 10;
            this._sp2.addChild(this._conditionVbox);
            this._conditionVbox.y = this._need.y + this._need.textHeight + 3;
         }
         for (_loc2_ of $.values(_loc4_))
         {
            this._condition1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillConditionTxt");
            this._condition1.text = _loc2_;
            this._conditionVbox.addChild(this._condition1);
         }
         this._totalBox.addChild(this._sp2);
         if(this._conditionVbox.parent)
         {
            this._bg.height = this._totalBox.height + 26;
         }
         else
         {
            this._bg.height = this._totalBox.height + 20;
         }
      }
    notLearn(param1) {
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc5_ = 0;
         var _loc7_ = null;
         var _loc8_ = $.int(param1.templateInfo.MasterType);
         var _loc6_ = this._petTypeList.indexOf(_loc8_) >= 0;
         var _loc3_ = param1.nextTemplateInfo;
         this._title1.htmlText = _loc3_.TemplateName;
         this._sp2.addChild(this._title1);
         this._sp2.addChild(this._method);
         this._method.y = 41;
         if(_loc3_.CoolDown > 0)
         {
            this._cooldown2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc3_.CoolDown * 0.001);
            this._sp2.addChild(this._cooldown2);
            this._cooldown2.y = 73;
         }
         else if(_loc6_)
         {
            this._cooldown2.text = "";
            this._sp2.addChild(this._cooldown2);
         }
         if($.int(_loc3_.Cost) < 0)
         {
            this._costSp2.text = this.getCostString(_loc6_,$.int(_loc3_.Cost));
            this._sp2.addChild(this._costSp2);
            this._costSp2.y = 59;
         }
         if($.int(_loc3_.HitPointCost) < 0)
         {
            this._line01.y = this._method.y + this._method.height + 20;
            this._costHitPoint2.text = this.getCostString(_loc6_,$.int(_loc3_.HitPointCost),true);
            this._sp2.addChild(this._costHitPoint2);
            this._costHitPoint2.y = 77;
         }
         if(!this._costSp2.parent && !this._cooldown2.parent && !this._costHitPoint2.parent)
         {
            this._line01.y = this._method.y + this._method.height + 18;
         }
         else if(this._costHitPoint2.parent)
         {
            this._line01.y = this._costHitPoint2.y + this._costHitPoint2.textHeight + 20;
         }
         else if(this._costSp2.parent)
         {
            this._line01.y = this._costSp2.y + this._costSp2.textHeight + 18;
         }
         else if(this._cooldown2.parent)
         {
            this._line01.y = this._cooldown2.y + this._cooldown2.textHeight + 20;
         }
         this._sp2.addChild(this._line01);
         this._line01.x = 0;
         this._describe2.text = _loc3_.Description;
         this._describe2.height = this._describe2.textHeight + 10;
         this._describe2.y = this._line01.y + 11;
         this._sp2.addChild(this._describe2);
         this._need.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.need");
         if(param1.templateInfo.MasterType == 200)
         {
            this._need.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.remoteneed");
            _loc5_ = $.int($.C("yishi.manager.TempleteManager").instance.remotePetTemplateCate.getTemplateBySkillId(param1.templateId).Index);
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.remoteValue",_loc5_);
            _loc4_ = [_loc7_];
         }
         else if($.C("yishi.manager.TempleteManager").instance.childPveBossTemplateCate && $.C("yishi.manager.TempleteManager").instance.childPveBossTemplateCate.getAllSkillId().indexOf(param1.templateId) > -1 && $.C("yishi.scene.SceneManager").instance.currentType != "BATTLE_SCENE")
         {
            this._need.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.remoteneed");
            _loc5_ = $.int($.C("yishi.manager.TempleteManager").instance.childPveBossTemplateCate.getChildPveSkillUnlockGrade(param1.templateId));
            _loc7_ = $.C("manager.LanguageMgr").GetTranslation("childpve.skilltip.unlock",_loc5_);
            _loc4_ = [_loc7_];
         }
         else
         {
            _loc4_ = param1.checkUpgradeCondition(_loc3_);
         }
         if(_loc4_.length > 0 && _loc8_ != 4)
         {
            this._sp2.addChild(this._line02);
            this._line02.y = this._describe2.y + this._describe2.height;
            this._sp2.addChild(this._need);
            this._need.y = this._line02.y + 11;
            this._sp2.addChild(this._conditionVbox);
            this._conditionVbox.y = this._need.y + this._need.textHeight + 3;
         }
         else
         {
            if(this._line02.parent)
            {
               this._line02.parent.removeChild(this._line02);
            }
            if(this._need.parent)
            {
               this._need.parent.removeChild(this._need);
            }
            if(this._conditionVbox.parent)
            {
               this._conditionVbox.parent.removeChild(this._conditionVbox);
            }
         }
         for (_loc2_ of $.values(_loc4_))
         {
            this._condition1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillConditionTxt");
            this._condition1.text = _loc2_;
            this._conditionVbox.addChild(this._condition1);
         }
         this._conditionVbox.refreshChildPos();
         this._totalBox.addChild(this._sp2);
         if(this._conditionVbox.parent)
         {
            this._bg.height = this._conditionVbox.height + this._totalBox.height + 20;
         }
         else
         {
            this._bg.height = this._totalBox.height + 30;
         }
      }
    isTalent(param1) {
         return $.C("battle.data.SkillData").SKILL_SONTYPE_TALENT_ARR.indexOf(param1.SonType) != -1;
      }
    getCostString(param1, param2, param3 = false) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc4_ = "";
         param2 = Math.abs(param2);
         if(param1)
         {
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown03",param2);
         }
         else if(param3)
         {
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown04",param2);
         }
         else if(param3)
         {
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown04",param2);
         }
         else
         {
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",param2);
         }
         return _loc4_;
      }
    getAvengerCostString(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.avengerCost",Math.abs(param1));
      }
    checkCondition(param1) {
         var _loc3_ = null;
         var _loc2_ = this.thane.skillCate.skillScript.split(",");
         for (var _loc4_ of $.values(_loc2_))
         {
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(_loc4_);
            if(_loc3_ && param1.SonType == _loc3_.SonType && param1.Grades <= _loc3_.Grades)
            {
               this._condition1.setFrame(1);
               return;
            }
         }
         this._condition1.setFrame(2);
      }
    clean() {
         this._totalBox.removeAllChild();
         this._conditionVbox.removeAllChild();
         while(this._sp2.numChildren > 0)
         {
            this._sp2.removeChildAt(this._sp2.numChildren - 1);
         }
         while(this._sp1.numChildren)
         {
            this._sp1.removeChildAt(this._sp1.numChildren - 1);
         }
      }
    dispose() {
         if(this._method)
         {
            this._method.dispose();
         }
         this._method = null;
         if(this._icon)
         {
            this._icon.dispose();
         }
         this._icon = null;
         if(this._title1)
         {
            this._title1.dispose();
         }
         this._title1 = null;
         if(this._cooldown1)
         {
            this._cooldown1.dispose();
         }
         this._cooldown1 = null;
         if(this._costSp1)
         {
            this._costSp1.dispose();
         }
         this._costSp1 = null;
         if(this._costHitPoint1)
         {
            this._costHitPoint1.dispose();
         }
         this._costHitPoint1 = null;
         if(this._describe1)
         {
            this._describe1.dispose();
         }
         this._describe1 = null;
         if(this._spliceLine)
         {
            this._spliceLine.dispose();
         }
         this._spliceLine = null;
         if(this._nextGrade)
         {
            this._nextGrade.dispose();
         }
         this._nextGrade = null;
         if(this._title2)
         {
            this._title2.dispose();
         }
         this._title2 = null;
         if(this._cooldown2)
         {
            this._cooldown2.dispose();
         }
         this._cooldown2 = null;
         if(this._costSp2)
         {
            this._costSp2.dispose();
         }
         this._costSp2 = null;
         if(this._costHitPoint2)
         {
            this._costHitPoint2.dispose();
         }
         this._costHitPoint2 = null;
         if(this._describe2)
         {
            this._describe2.dispose();
         }
         this._describe2 = null;
         if(this._need)
         {
            this._need.dispose();
         }
         this._need = null;
         if(this._condition1)
         {
            this._condition1.dispose();
         }
         this._condition1 = null;
         if(this._petSkillIcon)
         {
            this._petSkillIcon.dispose();
         }
         this._petSkillIcon = null;
         if(this._method2)
         {
            this._method2.dispose();
         }
         this._method2 = null;
         if(this._level1)
         {
            this._level1.dispose();
         }
         this._level1 = null;
         if(this._level2)
         {
            this._level2.dispose();
         }
         this._level2 = null;
         if(this._conditionVbox)
         {
            this._conditionVbox.dispose();
         }
         this._conditionVbox = null;
         if(this._totalBox)
         {
            this._totalBox.dispose();
         }
         this._totalBox = null;
         if(this._line01)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line01);
         }
         this._line01 = null;
         if(this._line02)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line02);
         }
         this._line02 = null;
         if(this._line03)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._line03);
         }
         this._line03 = null;
         if(this._sp1)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._sp1);
         }
         this._sp1 = null;
         if(this._sp2)
         {
            $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this._sp2);
         }
         this._sp2 = null;
         this._petTypeList = null;
         this._petTypeNameList = null;
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    getSkillType(param1) {
         if(param1.UseWay == 2)
         {
            return "[" + $.C("manager.LanguageMgr").GetTranslation("yishi.datas.templates.SkillTempInfo.UseWay02") + "]";
         }
         switch(param1.AcceptObject)
         {
            case 1:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type01");
            case 2:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type02");
            case 3:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type03");
            case 4:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type04");
            case 5:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type05");
            case 6:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type06");
            case 7:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type07");
            case 8:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type08");
            case 9:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type09");
            case 10:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type10");
            case 11:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type11");
            case 12:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type12");
            case 13:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type13");
            case 14:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type14");
            case 15:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type15");
            case 16:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type16");
            case 17:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type17");
            case 18:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type18");
            case 19:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type19");
            case 20:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type20");
            case 21:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type21");
            default:
               return "";
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    set thane(v) { super.thane = v; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__SkillTips, "yishi.view.tips.goods.SkillTips", []);
  return __SkillTips;
}
deps["yishi.view.tips.goods.SkillTips"] = ["battle.data.SkillData", "com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "manager.LanguageMgr", "mvc.module.armyII.SkillInfo", "yishi.datas.templates.SkillTempInfo", "yishi.manager.ArmyManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.scene.SceneManager", "yishi.utils.IconFactory", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.goods.StarPowTip"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __StarPowTip extends __Base {
    static $fields(self) {
    self._title = null;
    self._value = null;
    self._totalVBox = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 220;
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.StarPowTipTitleText");
         this._value = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.StarPowTipTitleText");
         this._totalVBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.StarsTotalBox");
         this._title.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.title");
         this._value.x = this._title.x + this._title.width + 10;
         this._totalVBox.width = this._bg.width;
         this._totalVBox.y = this._title.y + this._title.height + 5;
         this.addChild(this._title);
         this.addChild(this._value);
         this.addChild(this._totalVBox);
      }
    $$updateTransform() {
         var _loc1_ = null;
         var _loc8_ = undefined;
         var _loc7_ = 0;
         var _loc2_ = 0;
         var _loc5_ = null;
         var _loc6_ = 0;
         var _loc4_ = 0;
         this.clean();
         if(this.tipData)
         {
            _loc7_ = 0;
            if(this.tipData.hasOwnProperty("starList"))
            {
               _loc1_ = $.as(this.tipData["starList"], $.C("yishi.utils.SimpleDictionary"));
               if(this.tipData.hasOwnProperty("troughList"))
               {
                  _loc8_ = $.as(this.tipData["troughList"], $.Vector);
                  _loc2_ = $.int(_loc8_.length);
                  _loc6_ = 0;
                  while(_loc6_ < _loc2_)
                  {
                     _loc5_ = $.as(_loc8_[_loc6_], $.C("mvc.module.star.StarTroughInfo"));
                     _loc7_ += _loc5_.grade;
                     _loc6_++;
                  }
               }
            }
            else
            {
               _loc1_ = $.as(this.tipData, $.C("yishi.utils.SimpleDictionary"));
            }
            if(_loc1_)
            {
               this._value.text = $.C("yishi.utils.StarHelper").getStarPowerByList($.as(_loc1_, $.C("yishi.utils.SimpleDictionary")),_loc7_ / 8).toString();
               for (var _loc3_ of $.values(_loc1_))
               {
                  if($.is(_loc3_, $.C("mvc.module.star.StarInfo")))
                  {
                     _loc4_ = 0;
                     if(_loc8_ && _loc3_.pos < 8)
                     {
                        _loc4_ = $.int(_loc8_[_loc3_.pos].grade);
                     }
                     this.creatStarItem($.as(_loc3_, $.C("mvc.module.star.StarInfo")),_loc4_);
                  }
               }
            }
            else
            {
               this._value.text = this.tipData.toString();
            }
         }
         this._totalVBox.width + 40 > 220 ? (this._bg.width = this._totalVBox.width + 40) : (Number(this._bg.width = 220));
         this._bg.height = this._totalVBox.y + this._totalVBox.height + 10;
      }
    clean() {
         var _loc1_ = null;
         while(this._totalVBox.numChildren > 0)
         {
            _loc1_ = this._totalVBox.getChildAt(0);
            this._totalVBox.removeChild(_loc1_);
            $.C("com.pickgliss.utils.ObjectUtils").disposeObject(_loc1_);
         }
      }
    creatStarItem(param1, param2 = 0) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc6_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.StarsItemBox");
         var _loc3_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.StarItemNameText");
         var _loc4_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.StarItemNameText");
         var _loc5_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.StarItemNameText");
         _loc3_.text = param1.template.TemplateName;
         _loc3_.setFrame(param1.template.Profile);
         _loc4_.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.starLevel",param1.grade);
         _loc4_.setFrame(param1.template.Profile);
         _loc5_.text = this.initAttribute(param1,param2);
         _loc6_.addChild(_loc3_);
         _loc6_.addChild(_loc4_);
         _loc6_.addChild(_loc5_);
         this._totalVBox.addChild(_loc6_);
      }
    initAttribute(param1, param2 = 0) {
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.Power");
         var _loc4_ = $.int(param1.pos);
         if(param1.template.Power > 0)
         {
            _loc3_ += String($.int(param1.template.Power * param1.grade + param1.template.Power * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.Agility");
         if(param1.template.Agility > 0)
         {
            _loc3_ += String($.int(param1.template.Agility * param1.grade + param1.template.Agility * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.Intellect");
         if(param1.template.Intellect > 0)
         {
            _loc3_ += String($.int(param1.template.Intellect * param1.grade + param1.template.Intellect * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.Physique");
         if(param1.template.Physique > 0)
         {
            _loc3_ += String($.int(param1.template.Physique * param1.grade + param1.template.Physique * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.Captain");
         if(param1.template.Captain > 0)
         {
            _loc3_ += String($.int(param1.template.Captain * param1.grade + param1.template.Captain * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.Attack");
         if(param1.template.Attack > 0)
         {
            _loc3_ += String($.int(param1.template.Attack * param1.grade + param1.template.Attack * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.Defence");
         if(param1.template.Defence > 0)
         {
            _loc3_ += String($.int(param1.template.Defence * param1.grade + param1.template.Defence * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.MagicAttack");
         if(param1.template.MagicAttack > 0)
         {
            _loc3_ += String($.int(param1.template.MagicAttack * param1.grade + param1.template.MagicAttack * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.MagicDefence");
         if(param1.template.MagicDefence > 0)
         {
            _loc3_ += String($.int(param1.template.MagicDefence * param1.grade + param1.template.MagicDefence * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.ForceHit");
         if(param1.template.ForceHit > 0)
         {
            _loc3_ += String($.int(param1.template.ForceHit * param1.grade + param1.template.ForceHit * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.Live");
         if(param1.template.Live > 0)
         {
            _loc3_ += String($.int(param1.template.Live * param1.grade + param1.template.Live * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.Conat");
         if(param1.template.Conat > 0)
         {
            _loc3_ += String($.int(param1.template.Conat * param1.grade + param1.template.Conat * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.StarPowTip.Parry");
         if(param1.template.Parry > 0)
         {
            _loc3_ += String($.int(param1.template.Parry * param1.grade + param1.template.Parry * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + $.C("manager.LanguageMgr").GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + ($.int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         if(!$.C("yishi.utils.StringHelper").isNullOrEmpty(param1.template.DefaultSkill))
         {
            return $.C("yishi.utils.StarHelper").getStarBufferName(param1,param2);
         }
         return "";
      }
    get starManager() {
         return $.C("yishi.manager.StarManager").instance;
      }
    dispose() {
         if(this._title)
         {
            this._title.dispose();
         }
         this._title = null;
         if(this._value)
         {
            this._value.dispose();
         }
         this._value = null;
         if(this._totalVBox)
         {
            this._totalVBox.dispose();
         }
         this._totalVBox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set starManager(v) { super.starManager = v; }
  }
  $.meta(__StarPowTip, "yishi.view.tips.goods.StarPowTip", []);
  return __StarPowTip;
}
deps["yishi.view.tips.goods.StarPowTip"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "mvc.module.star.StarInfo", "mvc.module.star.StarTroughInfo", "yishi.manager.StarManager", "yishi.utils.SimpleDictionary", "yishi.utils.StarHelper", "yishi.utils.StringHelper", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.goods.TalentTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __TalentTips extends __Base {
    static $fields(self) {
    self._totalBox = null;
    self._method = null;
    self._vBox1 = null;
    self._title1 = null;
    self._cooldown1 = null;
    self._cost1 = null;
    self._describe1 = null;
    self._spliceLine = null;
    self._nextGrade = null;
    self._vBox2 = null;
    self._title2 = null;
    self._cooldown2 = null;
    self._cost2 = null;
    self._describe2 = null;
    self._need = null;
    self._condition1 = null;
    }
    constructor() {
         super();
      }
    init() {
         super.init();
         this._bg.width = 310;
         this._totalBox = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillTotalBox");
         this._method = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillTypeText");
         this._vBox1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillSubBox");
         this._title1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNameText");
         this._cooldown1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._cost1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._describe1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillDescribe1");
         this._spliceLine = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillSpliceLine");
         this._nextGrade = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNextGradeTxt");
         this._vBox2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillSubBox");
         this._title2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNameText");
         this._cooldown2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._cost2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._describe2 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillDescribe2");
         this._describe2.width = 250;
         this._describe1.width = 250;
         this._need = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillNeedTxt");
         this.addChild(this._method);
         this.addChild(this._totalBox);
         this._bg.height = this._totalBox.x + this._totalBox.height + 10;
      }
    $$updateTransform() {
         var _loc4_ = null;
         var _loc1_ = null;
         var _loc2_ = null;
         var _loc7_ = null;
         var _loc3_ = null;
         var _loc6_ = 0;
         var _loc5_ = null;
         if($.is(this.tipData, $.C("mvc.module.armyII.SkillInfo")))
         {
            this.clean();
            _loc7_ = $.as(this.tipData, $.C("mvc.module.armyII.SkillInfo"));
            _loc3_ = _loc7_.nextTemplateInfo;
            this._method.text = this.getSkillType(_loc7_.templateInfo);
            if(_loc7_.grade == 0)
            {
               this._title2.htmlText = _loc3_.TemplateName;
               this._vBox2.addChild(this._title2);
               if(_loc3_.CoolDown > 0)
               {
                  this._cooldown2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc3_.CoolDown * 0.001);
                  this._vBox2.addChild(this._cooldown2);
               }
               if($.int(_loc3_.Cost) < 0)
               {
                  _loc6_ = Math.abs($.int(_loc3_.Cost));
                  this._cost2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",_loc6_);
                  this._vBox2.addChild(this._cost2);
               }
               this._describe2.text = _loc3_.Description;
               this._describe2.height = this._describe2.textHeight + 10;
               this._vBox2.addChild(this._describe2);
               _loc4_ = _loc7_.checkTalentUpgradeCondition(_loc3_);
               if(_loc4_.length > 0)
               {
                  this._need.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.need");
                  this._vBox2.addChild(this._need);
               }
               for (_loc1_ of $.values(_loc4_))
               {
                  this._condition1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillConditionTxt");
                  this._condition1.text = _loc1_;
                  this._vBox2.addChild(this._condition1);
               }
               this._totalBox.addChild(this._vBox2);
            }
            else if(_loc3_)
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc7_.templateInfo.Grades);
               if(_loc7_.templateInfo.Grades > 0)
               {
                  this._title1.htmlText = _loc7_.templateInfo.TemplateName + " <font color=\'#ffffff\'>" + _loc2_ + "</font>";
               }
               else
               {
                  this._title1.htmlText = _loc7_.templateInfo.TemplateName;
               }
               this._vBox1.addChild(this._title1);
               if(_loc7_.templateInfo.CoolDown > 0)
               {
                  this._cooldown1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc7_.templateInfo.CoolDown * 0.001);
                  this._vBox1.addChild(this._cooldown1);
               }
               if($.int(_loc7_.templateInfo.Cost) < 0)
               {
                  _loc6_ = Math.abs($.int(_loc7_.templateInfo.Cost));
                  this._cost1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",_loc6_);
                  this._vBox1.addChild(this._cost1);
               }
               this._describe1.text = _loc7_.templateInfo.Description;
               this._describe1.height = this._describe1.textHeight + 10;
               this._vBox1.addChild(this._describe1);
               this._totalBox.addChild(this._vBox1);
               this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.nextGrade");
               this._totalBox.addChild(this._spliceLine);
               this._totalBox.addChild(this._nextGrade);
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc3_.Grades);
               this._title2.htmlText = _loc3_.TemplateName + " <font color=\'#ffffff\'>" + _loc2_ + "</font>";
               this._vBox2.addChild(this._title2);
               if(_loc3_.CoolDown > 0)
               {
                  this._cooldown2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc3_.CoolDown * 0.001);
                  this._vBox2.addChild(this._cooldown2);
               }
               if($.int(_loc3_.Cost) < 0)
               {
                  this._cost2.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",Math.abs($.int(_loc3_.Cost)));
                  this._vBox2.addChild(this._cost2);
               }
               this._describe2.text = _loc3_.Description;
               this._describe2.height = this._describe2.textHeight + 10;
               this._vBox2.addChild(this._describe2);
               _loc4_ = _loc7_.checkTalentUpgradeCondition(_loc3_);
               if(_loc4_.length > 0)
               {
                  this._need.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.need");
                  this._vBox2.addChild(this._need);
               }
               for (_loc1_ of $.values(_loc4_))
               {
                  this._condition1 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillConditionTxt");
                  this._condition1.text = _loc1_;
                  this._vBox2.addChild(this._condition1);
               }
               this._totalBox.addChild(this._vBox2);
            }
            else
            {
               _loc2_ = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc7_.templateInfo.Grades);
               if(_loc7_.templateInfo.Grades > 0)
               {
                  this._title1.htmlText = _loc7_.templateInfo.TemplateName + " <font color=\'#ffffff\'>" + _loc2_ + "</font>";
               }
               else
               {
                  this._title1.htmlText = _loc7_.templateInfo.TemplateName;
               }
               this._vBox1.addChild(this._title1);
               if(_loc7_.templateInfo.CoolDown > 0)
               {
                  this._cooldown1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc7_.templateInfo.CoolDown * 0.001);
                  this._vBox1.addChild(this._cooldown1);
               }
               if($.int(_loc7_.templateInfo.Cost) < 0)
               {
                  this._cost1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",Math.abs($.int(_loc7_.templateInfo.Cost)));
                  this._vBox1.addChild(this._cost1);
               }
               this._describe1.text = _loc7_.templateInfo.Description;
               this._describe1.height = this._describe1.textHeight + 10;
               this._vBox1.addChild(this._describe1);
               this._totalBox.addChild(this._vBox1);
               this._nextGrade.text = $.C("manager.LanguageMgr").GetTranslation("buildings.BaseBuildFrame.maxGrade");
               this._totalBox.addChild(this._nextGrade);
            }
            this._bg.height = this._totalBox.x + this._totalBox.height + 10;
            this._bg.width = 310;
         }
         else if($.is(this.tipData, $.C("yishi.datas.templates.SkillTempInfo")))
         {
            this.clean();
            _loc5_ = $.as(this.tipData, $.C("yishi.datas.templates.SkillTempInfo"));
            _loc2_ = $.C("manager.LanguageMgr").GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc5_.Grades);
            if(_loc5_.Grades > 0)
            {
               this._title1.htmlText = _loc5_.TemplateName + " <font color=\'#ffffff\'>" + _loc2_ + "</font>";
            }
            else
            {
               this._title1.htmlText = _loc5_.TemplateName;
            }
            this._method.text = this.getSkillType(_loc5_);
            this._vBox1.addChild(this._title1);
            if(_loc5_.CoolDown > 0)
            {
               this._cooldown1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc5_.CoolDown * 0.001);
               this._vBox1.addChild(this._cooldown1);
            }
            if($.int(_loc5_.Cost) < 0)
            {
               this._cost1.text = $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",Math.abs($.int(_loc5_.Cost)));
               this._vBox1.addChild(this._cost1);
            }
            this._describe1.text = _loc5_.Description;
            this._describe1.height = this._describe1.textHeight + 8;
            this._vBox1.addChild(this._describe1);
            this._totalBox.addChild(this._vBox1);
            this._bg.height = this._totalBox.x + this._totalBox.height + 10;
            this._bg.width = 310;
         }
      }
    checkCondition(param1) {
         var _loc3_ = null;
         var _loc2_ = this.thane.skillCate.skillScript.split(",");
         for (var _loc4_ of $.values(_loc2_))
         {
            _loc3_ = $.C("yishi.manager.TempleteManager").instance.getSkillTemplateInfoById(_loc4_);
            if(_loc3_ && param1.SonType == _loc3_.SonType && param1.Grades <= _loc3_.Grades)
            {
               this._condition1.setFrame(1);
               return;
            }
         }
         this._condition1.setFrame(2);
      }
    clean() {
         this._vBox1.removeAllChild();
         this._vBox2.removeAllChild();
         this._totalBox.removeAllChild();
      }
    getSkillType(param1) {
         if(param1.UseWay == 2)
         {
            return "";
         }
         switch($.int(param1.AcceptObject) - 1)
         {
            case 0:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type01");
            case 1:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type02");
            case 2:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type03");
            case 3:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type04");
            case 4:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type05");
            case 5:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type06");
            case 6:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type07");
            case 7:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type08");
            case 8:
               return $.C("manager.LanguageMgr").GetTranslation("yishi.view.tips.goods.SkillTips.Type09");
            case 9:
               return $.C("manager.LanguageMgr").GetTranslation("SkillTips.Type10");
            case 10:
               return $.C("manager.LanguageMgr").GetTranslation("SkillTips.Type11");
            case 11:
               return $.C("manager.LanguageMgr").GetTranslation("SkillTips.Type12");
            case 12:
               return $.C("manager.LanguageMgr").GetTranslation("SkillTips.Type13");
            case 13:
               return $.C("manager.LanguageMgr").GetTranslation("SkillTips.Type14");
            case 14:
               return $.C("manager.LanguageMgr").GetTranslation("SkillTips.Type15");
            case 15:
               return $.C("manager.LanguageMgr").GetTranslation("SkillTips.Type16");
            case 16:
               return $.C("manager.LanguageMgr").GetTranslation("SkillTips.Type17");
            default:
               return "";
         }
      }
    get thane() {
         return $.C("yishi.manager.ArmyManager").instance.thane;
      }
    get playerInfo() {
         return $.C("yishi.manager.PlayerManager").instance.currentPlayerModel.playerInfo;
      }
    dispose() {
         if(this._totalBox)
         {
            this._totalBox.dispose();
         }
         this._totalBox = null;
         if(this._method)
         {
            this._method.dispose();
         }
         this._method = null;
         if(this._vBox1)
         {
            this._vBox1.dispose();
         }
         this._vBox1 = null;
         if(this._title1)
         {
            this._title1.dispose();
         }
         this._title1 = null;
         if(this._cooldown1)
         {
            this._cooldown1.dispose();
         }
         this._cooldown1 = null;
         if(this._cost1)
         {
            this._cost1.dispose();
         }
         this._cost1 = null;
         if(this._describe1)
         {
            this._describe1.dispose();
         }
         this._describe1 = null;
         if(this._spliceLine)
         {
            this._spliceLine.dispose();
         }
         this._spliceLine = null;
         if(this._nextGrade)
         {
            this._nextGrade.dispose();
         }
         this._nextGrade = null;
         if(this._vBox2)
         {
            this._vBox2.dispose();
         }
         this._vBox2 = null;
         if(this._title2)
         {
            this._title2.dispose();
         }
         this._title2 = null;
         if(this._cooldown2)
         {
            this._cooldown2.dispose();
         }
         this._cooldown2 = null;
         if(this._cost2)
         {
            this._cost2.dispose();
         }
         this._cost2 = null;
         if(this._describe2)
         {
            this._describe2.dispose();
         }
         this._describe2 = null;
         if(this._need)
         {
            this._need.dispose();
         }
         this._need = null;
         if(this._condition1)
         {
            this._condition1.dispose();
         }
         this._condition1 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    set thane(v) { super.thane = v; }
    set playerInfo(v) { super.playerInfo = v; }
  }
  $.meta(__TalentTips, "yishi.view.tips.goods.TalentTips", []);
  return __TalentTips;
}
deps["yishi.view.tips.goods.TalentTips"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "manager.LanguageMgr", "mvc.module.armyII.SkillInfo", "yishi.datas.templates.SkillTempInfo", "yishi.manager.ArmyManager", "yishi.manager.PlayerManager", "yishi.manager.TempleteManager", "yishi.view.tips.BaseTip"];

defs["yishi.view.tips.goods.TwoEquipContrastTips"] = function define($) {
  const __Base = $.C("yishi.view.tips.BaseTip");
  class __TwoEquipContrastTips extends __Base {
    static $fields(self) {
    self.tip1 = null;
    self.tip2 = null;
    }
    constructor() {
         super();
      }
    init() {
         this.tip1 = new ($.C("yishi.view.tips.goods.FashionCardTip"))();
         this.tip2 = new ($.C("yishi.view.tips.goods.FashionCardTip"))();
      }
    set tipData(param1) {
         var _loc2_ = 0;
         var _loc3_ = 0;
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            if(param1[_loc2_])
            {
               _loc3_ = _loc2_ + 1;
               this["tip" + _loc3_].tipData = param1[_loc2_];
               this.addChild(this["tip" + _loc3_]);
            }
            _loc2_++;
         }
         this.tip2.x = this.tip1.x + this.tip1.width;
      }
    dispose() {
         if(this.tip1)
         {
            this.tip1.dispose();
         }
         this.tip1 = null;
         if(this.tip2)
         {
            this.tip2.dispose();
         }
         this.tip2 = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get tipData() { return super.tipData; }
  }
  $.meta(__TwoEquipContrastTips, "yishi.view.tips.goods.TwoEquipContrastTips", []);
  return __TwoEquipContrastTips;
}
deps["yishi.view.tips.goods.TwoEquipContrastTips"] = ["com.pickgliss.utils.ObjectUtils", "yishi.view.tips.BaseTip", "yishi.view.tips.goods.FashionCardTip"];

defs["yishi.view.tips.rune.RuneProItem"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __RuneProItem extends __Base {
    static $fields(self) {
    self._xing = 0;
    self._back = null;
    self._item = null;
    self._txt = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         this._back = new ($.C("flash.display.Bitmap"))();
         this._item = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("ui.tip.stone.equipInStoneItem.BaseItemViewIcon");
         this._txt = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.stone.proitemTxt");
         this.addChild(this._back);
         this.addChild(this._item);
         this.addChild(this._txt);
      }
    set xing(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._xing == param1)
         {
            return;
         }
         this._xing = param1;
         this._back.bitmapData = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.army.stone.shape" + this._xing);
      }
    set data(param1) {
         var _loc2_ = null;
         var _loc4_ = null;
         this._item.icon = $.C("yishi.utils.IconFactory").getGoodsIconByTID(param1.templateId);
         var _loc3_ = param1.templateInfo;
         if(param1.strengthenGrade > 0)
         {
            _loc4_ = $.C("yishi.manager.TempleteManager").instance.runeGemInfoCate.getInfo(_loc3_.SonType,_loc3_.Property1,param1.strengthenGrade);
            _loc2_ = this.getPropertys(_loc4_);
         }
         else
         {
            _loc2_ = this.getPropertys(_loc3_);
         }
         this._txt.text = _loc2_;
      }
    getPropertys(param1) {
         var _loc2_ = null;
         var _loc7_ = 0;
         if(param1 == null)
         {
            return "";
         }
         var _loc6_ = ["Power","Agility","Intellect","Physique","Captain"];
         var _loc5_ = $.int(_loc6_.length);
         var _loc3_ = "";
         var _loc4_ = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc2_ = _loc6_[_loc7_];
            if(param1[_loc2_] > 0)
            {
               _loc4_ = $.int(param1[_loc2_]);
               _loc3_ = $.C("manager.LanguageMgr").GetTranslation("army.stone." + _loc2_,_loc4_);
               break;
            }
            _loc7_++;
         }
         return _loc3_;
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._back);
         this._back = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._item);
         this._item = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._txt);
         this._txt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
    get xing() { return super.xing; }
    get data() { return super.data; }
  }
  $.meta(__RuneProItem, "yishi.view.tips.rune.RuneProItem", []);
  return __RuneProItem;
}
deps["yishi.view.tips.rune.RuneProItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Bitmap", "flash.display.Sprite", "manager.LanguageMgr", "yishi.manager.TempleteManager", "yishi.utils.IconFactory"];

defs["yishi.view.tips.rune.RuneStoneGroupContent"] = function define($) {
  const __Base = $.C("flash.display.Sprite");
  class __RuneStoneGroupContent extends __Base {
    static $fields(self) {
    self._vbox = null;
    self._hbox = null;
    self._itemList = [];
    self._proList = [];
    self._title = null;
    self._line0 = null;
    self._line = null;
    self._effectList = [];
    self._effctTxtDic = null;
    }
    constructor() {
         super();
         this.initView();
      }
    initView() {
         var _loc2_ = null;
         var _loc1_ = null;
         var _loc3_ = 0;
         this._title = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("tips.SkillCoolDownText");
         this._line = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._line0 = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmap("asset.tips.splitLine");
         this._effectList[0] = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("army.stone.propertyTxt");
         this._effectList[1] = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("army.stone.propertyTxt");
         this._title.text = $.C("manager.LanguageMgr").GetTranslation("runetip.title.eff");
         this._effectList[0].width = 320;
         this._effectList[1].width = 320;
         this._vbox = new ($.C("com.pickgliss.ui.controls.container.VBox"))();
         this._hbox = new ($.C("com.pickgliss.ui.controls.container.HBox"))();
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatCustomObject("ui.tip.stone.equipInStoneItem");
            this._itemList[_loc3_] = _loc2_;
            _loc1_ = new ($.C("yishi.view.tips.rune.RuneProItem"))();
            this._proList[_loc3_] = _loc1_;
            _loc3_++;
         }
         this.addChild(this._vbox);
         this._vbox.x = 10;
         this._vbox.spacing = 5;
         this._hbox.spacing = -5;
      }
    updateView(param1) {
         this._vbox.removeAllChild();
         this._vbox.beginChanges();
         this._vbox.addChild(this._line0);
         this._vbox.addChild(this._title);
         this._vbox.addChild(this._hbox);
         this.updateContents(param1.runeHole,param1.templateInfo.RuneType);
         this._vbox.commitChanges();
      }
    updateContents(param1, param2) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc10_ = 0;
         _loc10_ = 10;
         var _loc15_ = 0;
         var _loc19_ = null;
         var _loc4_ = null;
         var _loc9_ = 0;
         var _loc20_ = 0;
         var _loc6_ = null;
         var _loc5_ = null;
         var _loc17_ = 0;
         var _loc13_ = 0;
         var _loc3_ = null;
         var _loc8_ = 0;
         var _loc11_ = null;
         this._effctTxtDic = new ($.C("flash.utils.Dictionary"))();
         var _loc12_ = param1.split("|");
         var _loc21_ = _loc12_ ? _loc12_[0].split(",") : [];
         var _loc7_ = _loc12_ ? _loc12_[1].split(",") : [];
         var _loc18_ = $.C("yishi.manager.GoodsManager").instance.getRuneEquipBagList(param2);
         var _loc14_ = $.int(_loc7_.length);
         this._hbox.removeAllChild();
         this._hbox.beginChanges();
         var _loc16_ = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc14_)
         {
            _loc4_ = this._itemList[_loc8_];
            _loc3_ = this._proList[_loc8_];
            _loc4_.isSuit = false;
            _loc13_ = $.int(_loc7_[_loc8_]);
            _loc4_.xing = _loc13_;
            _loc3_.xing = _loc13_;
            _loc15_ = (param2 - 1) * 10 + _loc8_;
            _loc19_ = _loc18_[_loc15_];
            _loc4_.data = _loc19_;
            _loc4_.pos = _loc8_;
            if(_loc16_ < _loc8_ + 1)
            {
               _loc20_ = $.int(_loc21_[_loc9_]);
               _loc9_++;
               _loc6_ = $.C("yishi.manager.TempleteManager").instance.runeHoleInfoCate.getInfoById(_loc20_);
               if(_loc16_ == 0)
               {
                  if(_loc6_.GainEffectID1 > 0)
                  {
                     _loc11_ = this._effectList[0];
                     this.createEffectTxt(_loc6_.GainEffectID1,1,_loc11_);
                  }
                  if(_loc6_.GainEffectID2 > 0)
                  {
                     _loc11_ = this._effectList[1];
                     this.createEffectTxt(_loc6_.GainEffectID2,2,_loc11_);
                  }
               }
               _loc17_ = $.int(_loc6_.Length);
               _loc16_ += _loc17_;
               _loc17_--;
            }
            if(_loc17_ > 0)
            {
               _loc17_--;
               _loc4_.isSuit = true;
            }
            this._hbox.addChild(_loc4_);
            _loc8_++;
         }
         this._hbox.commitChanges();
         this.updateGrades();
      }
    createEffectTxt(param1, param2, param3) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if (typeof param2 !== "number" || (param2 | 0) !== param2) param2 = $.int(param2);
         var _loc16_ = null;
         var _loc10_ = null;
         var _loc9_ = null;
         var _loc6_ = null;
         var _loc17_ = null;
         var _loc8_ = null;
         var _loc15_ = 0;
         var _loc13_ = null;
         var _loc12_ = 0;
         var _loc5_ = null;
         var _loc14_ = null;
         var _loc4_ = "";
         var _loc11_ = "";
         var _loc7_ = $.C("yishi.manager.TempleteManager").instance.runeFsgainInfoCate.getInfoById(param1);
         this._effctTxtDic[param1] = [param3,_loc7_.ConditionParam,_loc7_.Condition];
         if(_loc7_.Condition > 0)
         {
            _loc16_ = $.C("manager.LanguageMgr").GetTranslation("army.stone.group.grade" + _loc7_.Condition,_loc7_.ConditionParam);
            _loc4_ = $.C("manager.LanguageMgr").GetTranslation("army.stone.activeFlg",_loc16_);
         }
         if(_loc7_.EffectType == 1)
         {
            _loc10_ = $.C("manager.LanguageMgr").GetTranslation("army.stone.property" + _loc7_.AttributeType);
            if(_loc7_.ValueType == 0)
            {
               _loc10_ += "+" + _loc7_.ValueParam;
            }
            else if(_loc7_.ValueType == 1)
            {
               _loc9_ = _loc7_.ValueParam.split(",");
               _loc6_ = $.C("manager.LanguageMgr").GetTranslation("army.stone.px" + _loc9_[0],_loc9_[1]);
               _loc10_ += _loc6_;
            }
            if(_loc7_.RuneType != null && _loc7_.RuneType != "" && _loc7_.RuneType != "0")
            {
               _loc17_ = $.C("manager.LanguageMgr").GetTranslation("army.stone.dot");
               _loc8_ = _loc7_.RuneType.split(",");
               _loc15_ = $.int(_loc8_.length);
               _loc13_ = "";
               _loc12_ = 0;
               while(_loc12_ < _loc15_)
               {
                  if(_loc12_ < _loc15_ - 1)
                  {
                     _loc13_ += $.C("manager.LanguageMgr").GetTranslation("army.stone.ot" + _loc8_[_loc12_]) + _loc17_;
                  }
                  else
                  {
                     _loc13_ += $.C("manager.LanguageMgr").GetTranslation("army.stone.ot" + _loc8_[_loc12_]);
                  }
                  _loc12_++;
               }
               _loc5_ = $.C("manager.LanguageMgr").GetTranslation("army.stone.ot0",_loc13_);
               _loc10_ += _loc5_;
            }
            _loc11_ = $.C("manager.LanguageMgr").GetTranslation("army.stone.activeXiao",_loc10_);
         }
         else if(_loc7_.EffectType == 2)
         {
            if(_loc7_.NewRuneSkill > 0)
            {
               _loc14_ = $.C("yishi.manager.TempleteManager").instance.getSkillById(_loc7_.NewRuneSkill);
               _loc11_ = $.C("manager.LanguageMgr").GetTranslation("army.stone.activeXiao",_loc14_.Description);
            }
         }
         param3.setFrame(2);
         param3.text = param2 + ". " + _loc4_ + _loc11_;
         param3.height = param3.numLines * 20;
      }
    updateGrades() {
         var _loc4_ = null;
         var _loc2_ = null;
         var _loc8_ = 0;
         var _loc3_ = null;
         var _loc6_ = null;
         var _loc5_ = new ($.C("flash.utils.Dictionary"))();
         var _loc9_ = 0;
         _loc8_ = 0;
         while(_loc8_ < this._hbox.numChildren)
         {
            _loc4_ = $.as(this._hbox.getChildAt(_loc8_), $.C("yishi.view.tips.rune.RuneXingItem"));
            _loc2_ = this._proList[_loc8_];
            if(_loc4_ && _loc4_.data)
            {
               if(!_loc5_[_loc4_.data.templateInfo.Property1])
               {
                  _loc5_[_loc4_.data.templateInfo.Property1] = _loc4_.data.strengthenGrade;
               }
               else
               {
                  _loc5_[_loc4_.data.templateInfo.Property1] += _loc4_.data.strengthenGrade;
               }
               _loc9_ += _loc4_.data.strengthenGrade;
               _loc2_.data = _loc4_.data;
               this._vbox.addChild(_loc2_);
            }
            _loc8_++;
         }
         this._vbox.addChild(this._line);
         _loc5_[99] = _loc9_;
         var _loc1_ = 0;
         var _loc10_ = 0;
         for (var _loc7_ of $.values(this._effctTxtDic))
         {
            _loc3_ = _loc7_[0];
            _loc10_ = $.int(_loc5_[_loc7_[2]]);
            if(_loc10_ >= _loc7_[1])
            {
               _loc3_.setFrame(1);
            }
            else
            {
               _loc3_.setFrame(2);
            }
            _loc1_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc1_)
         {
            _loc6_ = this._effectList[_loc8_];
            this._vbox.addChild(_loc6_);
            _loc8_++;
         }
      }
    dispose() {
         $.C("utils.LogicUtils").disposeDisplayCollection(this._itemList);
         this._itemList = null;
         $.C("utils.LogicUtils").disposeDisplayCollection(this._proList);
         this._proList = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._hbox);
         this._hbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeObject(this._vbox);
         this._vbox = null;
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this._effctTxtDic = null;
      }
  }
  $.meta(__RuneStoneGroupContent, "yishi.view.tips.rune.RuneStoneGroupContent", []);
  return __RuneStoneGroupContent;
}
deps["yishi.view.tips.rune.RuneStoneGroupContent"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.ui.controls.container.HBox", "com.pickgliss.ui.controls.container.VBox", "com.pickgliss.utils.ObjectUtils", "flash.display.Sprite", "flash.utils.Dictionary", "manager.LanguageMgr", "utils.LogicUtils", "yishi.manager.GoodsManager", "yishi.manager.TempleteManager", "yishi.view.tips.rune.RuneProItem", "yishi.view.tips.rune.RuneXingItem"];

defs["yishi.view.tips.rune.RuneXingItem"] = function define($) {
  const __Base = $.C("yishi.view.community.BaseItemView");
  class __RuneXingItem extends __Base {
    static $fields(self) {
    self._xing = 0;
    self._suitStyle = null;
    self._suitBit = null;
    self._isSuit = false;
    self._lockBit = null;
    }
    constructor() {
         super();
      }
    set data(param1) {
         super.data = param1;
         if(param1)
         {
            if(this._itemText)
            {
               this._itemText.text = $.C("manager.LanguageMgr").GetTranslation("public.level2",param1.strengthenGrade);
            }
         }
      }
    hideVpLock() {
         if(this._lockBit)
         {
            this._lockBit.visible = false;
         }
      }
    showVpLock() {
         if(this._lockBit == null)
         {
            this._lockBit = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename("ui.army.stone.bagCellLock2");
            this.addChild(this._lockBit);
         }
         this._lockBit.visible = true;
      }
    set xing(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         if(this._xing == param1)
         {
            return;
         }
         this._xing = param1;
         var _loc2_ = $.as(this._back, $.C("flash.display.Bitmap"));
         if(_loc2_)
         {
            _loc2_.bitmapData = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.army.stone.shape" + this._xing);
         }
         else
         {
            this.backgroundStyle = "asset.army.stone.shape" + this._xing;
         }
      }
    set suitStyle(param1) {
         if (param1 != null && typeof param1 !== "string") param1 = String(param1);
         if(this._suitStyle == param1)
         {
            return;
         }
         this._suitStyle = param1;
         this.onPropertiesChanged("suitStyle");
      }
    onProppertiesUpdate() {
         super.onProppertiesUpdate();
         if(this._changedPropeties["suitStyle"])
         {
            this._suitBit = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatComponentByStylename(this._suitStyle);
            this._suitBit.setFrame(2);
            this._suitBit.mouseChildren = false;
            this._suitBit.mouseEnabled = false;
            this.isSuit = false;
         }
      }
    set isSuit(param1) {
         this._isSuit = param1;
         if(this._suitBit)
         {
            this._suitBit.visible = this._isSuit;
         }
      }
    addChildren() {
         super.addChildren();
         if(this._suitBit)
         {
            this.addChild(this._suitBit);
         }
      }
    dispose() {
         $.C("com.pickgliss.utils.ObjectUtils").disposeAllChildren(this);
         super.dispose();
      }
    get data() { return super.data; }
    get xing() { return super.xing; }
    get suitStyle() { return super.suitStyle; }
    get isSuit() { return super.isSuit; }
  }
  $.meta(__RuneXingItem, "yishi.view.tips.rune.RuneXingItem", []);
  $.statics(__RuneXingItem, () => {
    __RuneXingItem.P_suitStyle = "suitStyle";
  });
  return __RuneXingItem;
}
deps["yishi.view.tips.rune.RuneXingItem"] = ["com.pickgliss.ui.ComponentFactory", "com.pickgliss.utils.ObjectUtils", "flash.display.Bitmap", "manager.LanguageMgr", "yishi.view.community.BaseItemView"];

defs["yishi.view.tips.rune.StoneBitGM"] = function define($) {
  const __Base = $.Object;
  class __StoneBitGM extends __Base {
    static $fields(self) {
    self._bitDatas = [];
    }
    constructor() {
         var _loc1_ = null;
         var _loc2_ = 0;
         super();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = $.C("com.pickgliss.ui.ComponentFactory").Instance.creatBitmapData("asset.army.stone.shape" + _loc2_);
            this._bitDatas.push(_loc1_);
            _loc2_++;
         }
      }
    static get Ins() {
         if(__StoneBitGM._ins == null)
         {
            __StoneBitGM._ins = new (__StoneBitGM)();
         }
         return __StoneBitGM._ins;
      }
    getbitData(param1) {
         if (typeof param1 !== "number" || (param1 | 0) !== param1) param1 = $.int(param1);
         return this._bitDatas[param1];
      }
    static set Ins(v) { super.Ins = v; }
  }
  $.meta(__StoneBitGM, "yishi.view.tips.rune.StoneBitGM", []);
  $.statics(__StoneBitGM, () => {
    __StoneBitGM._ins = null;
  });
  return __StoneBitGM;
}
deps["yishi.view.tips.rune.StoneBitGM"] = ["com.pickgliss.ui.ComponentFactory"];
