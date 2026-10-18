package child.emblem
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import mvc.module.children.EmblemInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.BulePowerItem;
   import yishi.view.frame.BuyFrameI;
   
   public class ChildEmblemUpView extends Frame
   {
      
      protected var _bg:ScaleBitmapImage;
      
      private var _lvIcon:Image;
      
      private var _lvTxt:FilterFrameText;
      
      private var _exp:BulePowerItem;
      
      private var _item:BaseItemView;
      
      private var _currentTxt:FilterFrameText;
      
      private var _costTxt:FilterFrameText;
      
      private var _inputBack:Image;
      
      private var _inputTxt:FilterFrameText;
      
      private var _alertTxt:FilterFrameText;
      
      private var _data:EmblemInfo;
      
      protected var _opSp:Sprite;
      
      protected var _upBtn:IconButton;
      
      private var _pos:int;
      
      private var _clickIndex:int;
      
      private var _needId:int;
      
      public function ChildEmblemUpView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,310,300);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.bg");
         _lvIcon = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.lvIcon");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.levelTxt");
         _exp = ComponentFactory.Instance.creatCustomObject("ChildEmblemUpView.LevelExp",[true]);
         _item = ComponentFactory.Instance.creatCustomObject("ChildEmblemUpView.item");
         _currentTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.currentTxt");
         _costTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.costTxt");
         _inputBack = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.inputBack");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.inputTxt");
         _alertTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.alertTxt");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.upBtn");
         _upBtn.y = 165;
         _opSp = new Sprite();
         addToContent(_bg);
         addToContent(_opSp);
         _opSp.addChild(_lvIcon);
         _opSp.addChild(_lvTxt);
         _opSp.addChild(_exp);
         _opSp.addChild(_item);
         _opSp.addChild(_currentTxt);
         _opSp.addChild(_costTxt);
         _opSp.addChild(_inputBack);
         _opSp.addChild(_inputTxt);
         _opSp.addChild(_alertTxt);
         addToContent(_upBtn);
         _costTxt.text = LanguageMgr.GetTranslation("child.attribute.ChildUpgradeGrowthView.numTitle2");
      }
      
      protected function unitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_lvIcon);
         _lvIcon = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_exp);
         _exp = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_currentTxt);
         _currentTxt = null;
         ObjectUtils.disposeObject(_costTxt);
         _costTxt = null;
         ObjectUtils.disposeObject(_inputBack);
         _inputBack = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_alertTxt);
         _alertTxt = null;
         ObjectUtils.disposeAllChildren(_opSp);
         ObjectUtils.disposeObject(_opSp);
         _opSp = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         _data = null;
      }
      
      protected function refreshView() : void
      {
         var _loc1_:UpgradeTemplateInfo = null;
         if(model.selectedChild == null)
         {
            dispose();
            return;
         }
         var _loc3_:int = 0;
         _alertTxt.text = "";
         if(_pos == 0)
         {
            titleText = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.titleTxt1");
            _needId = 208046;
            _lvTxt.text = model.selectedChild.emblemLv + "";
            _loc3_ = int(GoodsManager.instance.getBagCountByTempId(1,_needId));
            _currentTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.currentTxt1",_loc3_);
            _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(model.selectedChild.emblemLv + 1,47);
            if(_loc1_ == null)
            {
               _alertTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.alertTxt3");
               _upBtn.enable = false;
               _exp.full = true;
            }
            else
            {
               _alertTxt.visible = false;
               _upBtn.enable = true;
               _exp.max = _loc1_.Data;
               _exp.current = model.selectedChild.emblemGp;
            }
            _upBtn.iconStyle = "asset.ChildEmblemUpView.upBtnIcon1";
            _upBtn.iconInnerRectString = "24,82,8,30,13";
         }
         else if(_pos == 1)
         {
            _data = model.selectedChild.emblemList[_pos];
            if(!_data)
            {
               return;
            }
            titleText = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.titleTxt2");
            _needId = 208048;
            _lvTxt.text = _data.grade1 + "";
            _loc3_ = int(GoodsManager.instance.getBagCountByTempId(1,_needId));
            _currentTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.currentTxt2",_loc3_);
            _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(_data.grade1 + 1,49);
            if(_loc1_ == null)
            {
               _alertTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.alertTxt3");
               _upBtn.enable = false;
               _exp.full = true;
            }
            else
            {
               _upBtn.enable = true;
               _exp.max = _loc1_.Data;
               _exp.current = _data.gp1;
               if(_loc1_.Data == _data.gp1 && _data.grade1 == model.selectedChild.emblemLv)
               {
                  _alertTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.alertTxt1",model.selectedChild.emblemLv + 1);
                  _upBtn.enable = false;
               }
            }
            _upBtn.iconStyle = "asset.ChildEmblemUpView.upBtnIcon2";
            _upBtn.iconInnerRectString = "40,50,8,30,13";
         }
         else
         {
            _data = model.selectedChild.emblemList[_pos];
            if(!_data)
            {
               return;
            }
            titleText = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.titleTxt3");
            _needId = 208047;
            _lvTxt.text = _data["grade" + (_clickIndex + 1)] + "";
            _loc3_ = int(GoodsManager.instance.getBagCountByTempId(1,_needId));
            _currentTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.currentTxt3",_loc3_);
            _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(_data["grade" + (_clickIndex + 1)] + 1,48);
            if(_loc1_ == null)
            {
               _alertTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.alertTxt3");
               _upBtn.enable = false;
               _exp.full = true;
            }
            else
            {
               _upBtn.enable = true;
               _exp.max = _loc1_.Data;
               _exp.current = _data["gp" + (_clickIndex + 1)];
               if(_loc1_.Data == _data["gp" + (_clickIndex + 1)] && _data["grade" + (_clickIndex + 1)] == model.selectedChild.emblemLv)
               {
                  _upBtn.enable = false;
                  _alertTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.alertTxt2",model.selectedChild.emblemLv + 1);
               }
            }
            _upBtn.iconStyle = "asset.ChildEmblemUpView.upBtnIcon2";
            _upBtn.iconInnerRectString = "40,50,8,30,13";
         }
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.templateId = _needId;
         _item.data = _loc4_;
         var _loc2_:int = int(GoodsManager.instance.getBagCountByTempId(1,_needId));
         _loc2_ = int(_loc2_ <= 0 ? 1 : _loc2_);
         _inputTxt.text = _loc2_ + "";
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_upBtn)
         {
            _upBtn.addEventListener("click",__upBtnHandler);
         }
         if(_inputTxt)
         {
            _inputTxt.addEventListener("change",__txtChangeHandler);
         }
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
      }
      
      private function removeEVent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_upBtn)
         {
            _upBtn.removeEventListener("click",__upBtnHandler);
         }
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("change",__txtChangeHandler);
         }
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __childInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __txtChangeHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(isDie == false)
         {
            _loc2_ = int(GoodsManager.instance.getBagCountByTempId(1,_needId));
            _loc4_ = parseInt(_inputTxt.text);
            _loc3_ = Math.max(_loc2_,9999);
            if(_loc4_ <= 0)
            {
               _inputTxt.text = "1";
            }
            if(_loc4_ >= _loc3_)
            {
               _inputTxt.text = _loc3_ + "";
            }
         }
      }
      
      private function __upBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = parseInt(_inputTxt.text);
         var _loc3_:int = 0;
         if(_pos == 0)
         {
            _loc3_ = int(GoodsManager.instance.getBagCountByTempId(1,208046));
            if(_loc3_ < _loc2_)
            {
               showQutiBuy(208046,_loc2_ - _loc3_);
            }
            else
            {
               ChildSender.emblemUp(model.selectedChild.childId,_loc2_);
            }
         }
         else if(_pos == 1)
         {
            _loc3_ = int(GoodsManager.instance.getBagCountByTempId(1,208048));
            if(_loc3_ < _loc2_)
            {
               showQutiBuy(208048,_loc2_ - _loc3_);
            }
            else
            {
               ChildSender.emblemUpProperty(model.selectedChild.childId,_pos,0,_loc2_);
            }
         }
         else
         {
            _loc3_ = int(GoodsManager.instance.getBagCountByTempId(1,208047));
            if(_loc3_ < _loc2_)
            {
               showQutiBuy(208047,_loc2_ - _loc3_);
            }
            else
            {
               ChildSender.emblemUpProperty(model.selectedChild.childId,_pos,_clickIndex,_loc2_);
            }
         }
      }
      
      private function showQutiBuy(param1:int, param2:int) : void
      {
         var temapleteId:int = param1;
         var count:int = param2;
         var quickUIcallback:Function = function():void
         {
            var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
            var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopInfoByItemIdAndArea(temapleteId,10);
            _loc1_.data(_loc2_,count);
            _loc1_.callback = buyCallBack;
            _loc1_.show();
         };
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function buyCallBack(param1:Boolean, param2:Object = null) : void
      {
         var _loc4_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc3_:int = 0;
         if(_pos == 0)
         {
            _loc3_ = 208046;
            _loc4_ = int(GoodsManager.instance.getBagCountByTempId(1,_loc3_));
            _currentTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.currentTxt1",_loc4_);
         }
         else if(_pos == 1)
         {
            _loc3_ = 208048;
            _loc4_ = int(GoodsManager.instance.getBagCountByTempId(1,_loc3_));
            _currentTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.currentTxt2",_loc4_);
         }
         else
         {
            _loc3_ = 208047;
            _loc4_ = int(GoodsManager.instance.getBagCountByTempId(1,_loc3_));
            _currentTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.currentTxt3",_loc4_);
         }
         _inputTxt.text = _loc4_ + "";
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(param1 && param1.frameData)
         {
            _pos = param1.frameData.pos;
            _clickIndex = param1.frameData.index;
            refreshView();
            LayerManager.Instance.addToLayer(this,3,true,true,1);
         }
      }
      
      override public function dispose() : void
      {
         removeEVent();
         unitView();
         super.dispose();
      }
   }
}

