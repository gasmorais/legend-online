package child.emblem
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import mvc.module.children.EmblemInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BulePowerItem;
   import yishi.view.frame.BuyFrameI;
   
   public class ChildEmblemTabView extends Component
   {
      
      private var _topBg:Image;
      
      private var _bottomBg:Image;
      
      private var _childEmblemIcon:Image;
      
      private var _firstTxt:Bitmap;
      
      private var _lvTxt:GradientText;
      
      private var _progress:BulePowerItem;
      
      private var _upBtn:IconButton;
      
      private var _reduceResiButton:IconButton;
      
      private var _reduceResiIcon:Image;
      
      private var _ballList:Vector.<ChildEmblemBallView>;
      
      private var _rightView:ChildEmblemRightView;
      
      private var _currentLv:int;
      
      private var _filter:UIFilter;
      
      private var _mask:Sprite;
      
      private var _changeView:ChildEmblemItemChangeView;
      
      private var postions:Array = [[40.5,144.5],[80.5,104.95],[123.5,67.95],[105.5,198.35],[146.65,159.55],[201.85,141.55],[200.45,41.95],[257.45,36.95],[314.65,41.95],[391.05,67.95],[434.25,105.55],[475.05,145.55],[311.05,141.55],[364.25,160.35],[407.05,199.15]];
      
      private var _itemList:Vector.<ChildEmblemItemView>;
      
      public function ChildEmblemTabView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:ChildEmblemBallView = null;
         var _loc2_:ChildEmblemItemView = null;
         _topBg = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.topBg");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.bottomBg");
         _childEmblemIcon = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.childEmblemIcon");
         _firstTxt = ComponentFactory.Instance.creatBitmap("asset.ChildEmblemTabView.firstTxt");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.lvTxt");
         _progress = ComponentFactory.Instance.creatCustomObject("ChildEmblemUpView.LevelExpWidth",[true]);
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.upBtn");
         _reduceResiIcon = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.reduceResiIcon");
         _reduceResiButton = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemTabView.reduceResiButton");
         _rightView = ComponentFactory.Instance.creatComponentByStylename("child.emblem.ChildEmblemRightView");
         _ballList = new Vector.<ChildEmblemBallView>();
         _filter = new UIFilter();
         addChild(_topBg);
         addChild(_bottomBg);
         addChild(_childEmblemIcon);
         addChild(_firstTxt);
         addChild(_lvTxt);
         addChild(_progress);
         addChild(_upBtn);
         addChild(_reduceResiIcon);
         addChild(_reduceResiButton);
         _reduceResiButton.visible = false;
         addChild(_rightView);
         _currentLv = model.selectedChild.emblemLv;
         _loc3_ = 1;
         while(_loc3_ <= 6)
         {
            _loc1_ = new ChildEmblemBallView();
            _loc1_.pos = _loc3_;
            _loc1_.x = 53 + (_loc3_ - 1) % 2 * 450;
            _loc1_.y = 468 + int((_loc3_ - 1) / 2) * 108;
            _ballList.push(_loc1_);
            _loc3_++;
         }
         _itemList = new Vector.<ChildEmblemItemView>();
         _loc3_ = 0;
         while(_loc3_ < 15)
         {
            _loc2_ = new ChildEmblemItemView();
            _loc2_.x = _bottomBg.x + postions[_loc3_][0];
            _loc2_.y = _bottomBg.y + postions[_loc3_][1];
            _loc2_.pos = _loc3_;
            addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc3_++;
         }
         _mask = new Sprite();
         _mask.graphics.lineStyle(1,0,0.1);
         _mask.graphics.beginFill(0,0.7);
         _mask.graphics.drawRect(0,0,547,308);
         _mask.graphics.endFill();
         _mask.width = 547;
         _mask.height = 308;
         _mask.x = _bottomBg.x;
         _mask.y = _bottomBg.y;
         addChild(_mask);
         _mask.visible = false;
         _changeView = new ChildEmblemItemChangeView();
         addChild(_changeView);
         _changeView.visible = false;
      }
      
      private function unintView() : void
      {
         ObjectUtils.disposeObject(_topBg);
         _topBg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_childEmblemIcon);
         _childEmblemIcon = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         ObjectUtils.disposeObject(_reduceResiButton);
         _reduceResiButton = null;
         ObjectUtils.disposeObject(_reduceResiIcon);
         _reduceResiIcon = null;
         LogicUtils.disposeDisplayCollection(_ballList);
         _ballList = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_changeView);
         _changeView = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         postions = null;
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:UpgradeTemplateInfo = null;
         maskClickHandle(null);
         _reduceResiIcon.isFollowMouse = false;
         _reduceResiIcon.tipStyle = "yishi.view.tips.OneLineTip";
         _reduceResiIcon.tipDirctions = "2,1";
         if(isDie)
         {
            return;
         }
         if(model.selectedChild)
         {
            _rightView.data = model.selectedChild;
            _lvTxt.text = "Nv." + model.selectedChild.emblemLv;
            _loc2_ = 0;
            while(_loc2_ < _ballList.length)
            {
               _ballList[_loc2_].refreshView();
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < _itemList.length)
            {
               _itemList[_loc2_].refreshView();
               _loc2_++;
            }
            _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(model.selectedChild.emblemLv + 1,47);
            if(model.selectedChild.emblemLv <= 0)
            {
               _progress.max = _loc1_.Data;
               _progress.current = 0;
               _firstTxt.visible = true;
               _reduceResiButton.visible = false;
               _reduceResiIcon.tipData = null;
               _upBtn.iconStyle = "asset.ChildEmblemTabView.upBtnIcon1";
            }
            else
            {
               if(_loc1_)
               {
                  _progress.max = _loc1_.Data;
                  _progress.current = model.selectedChild.emblemGp;
               }
               else
               {
                  _progress.full = true;
               }
               _firstTxt.visible = false;
               _reduceResiButton.visible = true;
               _reduceResiIcon.tipData = LanguageMgr.GetTranslation("child.emblem.ChildEmblemBallView.ballTip1",model.selectedChild.emblemList[1].getValueByIndex(1));
               _upBtn.iconStyle = "asset.ChildEmblemTabView.upBtnIcon2";
            }
         }
      }
      
      private function initEvent() : void
      {
         if(_upBtn)
         {
            _upBtn.addEventListener("click",__upBtnHandler);
         }
         if(_mask)
         {
            _mask.addEventListener("click",maskClickHandle);
         }
         _reduceResiButton.addEventListener("click",__reduceResiBtnHandler);
         MsgMan.addObserver("ChildEvent.HEAD_CHANGE",this,__changeHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
         MsgMan.addObserver("ChildEvent.EMBLEM_BALL_CLICK",this,__ballClickHandler);
         StageReferance.stage.addEventListener("click",__stageClick);
      }
      
      private function __ballClickHandler(param1:String, param2:Object) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _itemList.length)
         {
            _itemList[_loc6_].stopShining();
            _loc6_++;
         }
         var _loc5_:ChildEmblemItemView = param2 as ChildEmblemItemView;
         var _loc9_:EmblemInfo = model.selectedChild.emblemList[int(_loc5_.pos / 3) + 2];
         var _loc4_:Array = [];
         if(_loc9_)
         {
            _loc4_ = [_loc9_.resi1,_loc9_.resi2,_loc9_.resi3];
            if(_loc5_.pos % 3 == 0)
            {
               _loc8_ = int(_loc9_.resi1);
               _loc7_ = int(_loc9_.grade1);
            }
            else if(_loc5_.pos % 3 == 1)
            {
               _loc8_ = int(_loc9_.resi2);
               _loc7_ = int(_loc9_.grade2);
            }
            else if(_loc5_.pos % 3 == 2)
            {
               _loc8_ = int(_loc9_.resi3);
               _loc7_ = int(_loc9_.grade3);
            }
         }
         else
         {
            _loc8_ = 0;
         }
         _mask.visible = true;
         _changeView.x = param2.x + 23;
         _changeView.y = param2.y + 22;
         _changeView.scaleX = 0.28;
         _changeView.scaleY = 0.28;
         _changeView.visible = true;
         _changeView.data = {
            "resiType":_loc8_,
            "alreadySelect":_loc4_,
            "pos":int(_loc5_.pos / 3) + 2,
            "order":_loc5_.pos % 3,
            "resiGrade":_loc7_
         };
         TweenLite.to(_changeView,0.33,{
            "scaleX":1,
            "scaleY":1
         });
      }
      
      private function __stageClick(param1:MouseEvent) : void
      {
         if(!_mask.visible)
         {
            return;
         }
         if(DisplayUtils.isTargetOrContain(param1.target as DisplayObject,_changeView as DisplayObject))
         {
            return;
         }
         maskClickHandle(null);
      }
      
      public function maskClickHandle(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _mask.visible = false;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _itemList[_loc2_].refreshView();
            _loc2_++;
         }
         _changeView.visible = false;
      }
      
      private function removeEvent() : void
      {
         if(_upBtn)
         {
            _upBtn.removeEventListener("click",__upBtnHandler);
         }
         if(_mask)
         {
            _mask.removeEventListener("click",maskClickHandle);
         }
         _reduceResiButton.removeEventListener("click",__reduceResiBtnHandler);
         MsgMan.removeObserver("ChildEvent.HEAD_CHANGE",this,__changeHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
         MsgMan.removeObserver("ChildEvent.EMBLEM_BALL_CLICK",this,__ballClickHandler);
         StageReferance.stage.removeEventListener("click",__stageClick);
      }
      
      protected function __reduceResiBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:Object = {
            "pos":1,
            "index":1
         };
         ChildManager.instance.openEmblemUpView(_loc2_);
      }
      
      private function __changeHandler(param1:String, param2:Object) : void
      {
         if(model.selectedChild)
         {
            _currentLv = model.selectedChild.emblemLv;
            refreshView();
         }
      }
      
      private function __childInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __upBtnHandler(param1:MouseEvent) : void
      {
         var obj:Object;
         var num:int;
         var quickUIcallback:Function;
         var confirm:String;
         var cancel:String;
         var prompt:String;
         var content:String;
         var event:MouseEvent = param1;
         if(model.selectedChild.emblemLv > 0)
         {
            obj = {
               "pos":0,
               "index":0
            };
            ChildManager.instance.openEmblemUpView(obj);
         }
         else
         {
            num = int(GoodsManager.instance.getBagCountByTempId(1,208046));
            if(num <= 0)
            {
               quickUIcallback = function():void
               {
                  var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
                  var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopInfoByItemIdAndArea(208046,10);
                  _loc1_.data(_loc2_,1);
                  _loc1_.callback = buyCallBack;
                  _loc1_.show();
               };
               CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
            }
            else
            {
               SimpleAlertHelper.instance.data = [upCallback];
               confirm = LanguageMgr.GetTranslation("public.confirm");
               cancel = LanguageMgr.GetTranslation("public.cancel");
               prompt = LanguageMgr.GetTranslation("public.prompt");
               content = LanguageMgr.GetTranslation("child.emblem.ChildEmblemTabView.confirmOpen");
               SimpleAlertHelper.instance.popAlerFrame(prompt,content,confirm,cancel);
            }
         }
      }
      
      private function buyCallBack(param1:Boolean, param2:Object = null) : void
      {
         if(!param1)
         {
            return;
         }
      }
      
      private function upCallback(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ChildSender.emblemActive(model.selectedChild.childId);
         }
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unintView();
         super.dispose();
      }
   }
}

