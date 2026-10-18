package secretary
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import managers.LitteActionManager;
   import managers.SecretaryManager;
   import mvc.module.secretary.SecretaryData;
   import mvc.module.secretary.SecretaryItemData;
   import secretary.view.SecretaryCompentView;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.AssistantTempInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class LittleSecretaryFrame extends Frame implements IManualSize, IEnterFrame
   {
      
      public var _tabSpanel:ScrollPanel;
      
      private var _helpBtn:BaseButton;
      
      public var _npc:Bitmap;
      
      public var _tabVbox:VBox;
      
      public var _btnList:SelectedButtonGroup;
      
      private var _immediateExeBtn:IconButton;
      
      private var _allExeBtn:IconButton;
      
      private var _view:SecretaryCompentView;
      
      private var _back:DisplayObject;
      
      public var _fgx1:Bitmap;
      
      public var _fgx2:Bitmap;
      
      public var _tabBg:Bitmap;
      
      private var _index:int = 1;
      
      public function LittleSecretaryFrame()
      {
         super();
         SecretaryManager.instance.goGettower();
         ConsortiaSocketOutManager.getAltarInfo();
         SecretaryManager.instance.model.getTabArr();
         SecretaryManager.instance.gotoGetGemNum();
         SecretaryManager.instance.isFinish = false;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("secretary.view.SecretaryCompentView.back");
         titleText = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips7");
         _npc = ComponentFactory.Instance.creatBitmap("asset.secrearytary.npc");
         _fgx1 = ComponentFactory.Instance.creatBitmap("asset.secrearytary.leftbg");
         _fgx2 = ComponentFactory.Instance.creatBitmap("asset.secrearytary.leftfengexian");
         _tabBg = ComponentFactory.Instance.creatBitmap("asset.secrearytary.leftfengexianline");
         _tabSpanel = ComponentFactory.Instance.creatComponentByStylename("LittleSecretaryFrame.tabSpanel");
         _immediateExeBtn = ComponentFactory.Instance.creatComponentByStylename("LittleSecretaryFrame.exeBtn");
         _allExeBtn = ComponentFactory.Instance.creatComponentByStylename("LittleSecretaryFrame.allBtn");
         addToContent(_back);
         addToContent(_tabBg);
         addToContent(_npc);
         addToContent(_fgx1);
         addToContent(_fgx2);
         addToContent(_tabSpanel);
         _tabVbox = ComponentFactory.Instance.creatCustomObject("secretary.otherVbox");
         _tabSpanel.setView(_tabVbox);
         _view = ComponentFactory.Instance.creatCustomObject("secretary.view.SecretaryCompentView");
         addToContent(_immediateExeBtn);
         addToContent(_allExeBtn);
         addToContent(_view);
         initData();
         LitteActionManager.Instance.isOpen = true;
      }
      
      public function enterFrame() : void
      {
         actManager.exc();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get actManager() : LitteActionManager
      {
         return SecretaryManager.instance.actManager;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,695,575);
      }
      
      private function initData() : void
      {
         var _loc5_:SelectedTextButton = null;
         var _loc3_:AssistantTempInfo = null;
         var _loc4_:int = 0;
         _btnList = new SelectedButtonGroup();
         var _loc1_:Array = model.tabArr;
         var _loc2_:int = int(_loc1_ ? _loc1_.length : 0);
         _tabVbox.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("SecretaryTabItem.Btn");
            _loc5_.text = _loc1_[_loc4_].TypeName;
            _loc5_.y = _loc4_ * (_loc5_.height + 15);
            _tabVbox.addChild(_loc5_);
            _btnList.addSelectItem(_loc5_);
            _loc4_++;
         }
         _tabVbox.commitChanges();
         _tabSpanel.invalidateViewport();
         var _loc6_:Array = model.toTabGetDataArr(1);
         _view.refrshView(_loc6_);
      }
      
      private function getFun(param1:Event) : void
      {
         _index = param1.currentTarget.selectIndex + 1;
         var _loc2_:Array = model.toTabGetDataArr(_index);
         _view.refrshView(_loc2_);
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("SecretaryAwardFrame",this,__disposeAction);
         MsgMan.addObserver("LitteActionManager",this,__dispose);
         MsgMan.addObserver("SecretaryCompentItem",this,__secretaryCompentItem);
         addEventListener("response",__frameResponse);
         _immediateExeBtn.addEventListener("click",__onimmediateClick);
         _allExeBtn.addEventListener("click",__onallExeClick);
         _btnList.addEventListener("change",getFun);
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function __disposeAction(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      private function __dispose(param1:String, param2:Object) : void
      {
         if(!this.visible)
         {
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         _btnList.removeEventListener("change",getFun);
         MsgMan.removeObserver("SecretaryAwardFrame",this,__disposeAction);
         MsgMan.removeObserver("LitteActionManager",this,__dispose);
         MsgMan.removeObserver("SecretaryCompentItem",this,__secretaryCompentItem);
         removeEventListener("response",__frameResponse);
         _immediateExeBtn.removeEventListener("click",__onimmediateClick);
         _allExeBtn.removeEventListener("click",__onallExeClick);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      private function __secretaryCompentItem(param1:String, param2:Object) : void
      {
         var _loc3_:Array = null;
         if(param2 == 2 || param2 == 4 || param2 == 3)
         {
            _loc3_ = model.toTabGetDataArr(_index);
            _view.refrshView(_loc3_);
         }
      }
      
      private function __onimmediateClick(param1:MouseEvent) : void
      {
         var _loc12_:SecretaryItemData = null;
         var _loc7_:int = 0;
         SoundManager.instance.play("022");
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:Array = model.toTabGetDataArr(_index);
         _loc7_ = 0;
         while(_loc7_ < _loc10_.length)
         {
            _loc12_ = _loc10_[_loc7_];
            if(_loc12_.state && Boolean(_loc12_.isOpen))
            {
               if(_loc12_.moneyType != 0)
               {
                  if(!_loc12_.moneyState)
                  {
                     _loc4_ += _loc12_.moneyNum;
                  }
                  else
                  {
                     _loc6_ += _loc12_.moneyNum;
                  }
               }
               _loc5_ += _loc12_.goldNum;
            }
            _loc7_++;
         }
         if(_loc4_ <= 0 && _loc6_ <= 0)
         {
            exeIndexCallBack(true,true);
            return;
         }
         SimpleAlertHelper.instance.data = [exeIndexCallBack];
         var _loc8_:String = "";
         if(_loc4_ > 0)
         {
            _loc8_ += " " + LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips1",_loc4_);
         }
         if(_loc6_ > 0)
         {
            _loc8_ += " " + LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips2",_loc6_);
         }
         if(_loc5_ > 0)
         {
            _loc8_ += " " + LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips3",_loc5_);
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc11_:String = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips") + "<font color=\'#95feff\'>" + _loc8_ + "</font>" + LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips10");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc9_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc11_,_loc2_,_loc3_,false,true,true,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert",null,350,"","");
      }
      
      private function exeIndexCallBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:Array = null;
         var _loc5_:SecretaryItemData = null;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc4_ = model.toTabGetDataArr(_index);
            _loc3_ = 0;
            while(_loc3_ < _loc4_.length)
            {
               _loc5_ = _loc4_[_loc3_];
               if(_loc3_ == _loc4_.length - 1)
               {
                  SecretaryManager.instance.isFinish = true;
               }
               if(_loc5_.state && Boolean(_loc5_.isOpen))
               {
                  if(_loc5_.type != 5 && Boolean(model.openAward))
                  {
                     FrameControllerManager.instance.openControllerByInfo("SECRETARY",1);
                     model.openAward = false;
                  }
                  actManager.addAction(_loc5_.getAction());
                  this.visible = false;
               }
               _loc3_++;
            }
         }
      }
      
      private function __onallExeClick(param1:MouseEvent) : void
      {
         var _loc12_:SecretaryItemData = null;
         var _loc7_:int = 0;
         SoundManager.instance.play("022");
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:Array = model.allItemDatas;
         _loc7_ = 0;
         while(_loc7_ < _loc10_.length)
         {
            _loc12_ = _loc10_[_loc7_];
            if(_loc12_.state && Boolean(_loc12_.isOpen))
            {
               if(_loc12_.moneyType != 0)
               {
                  if(!_loc12_.moneyState)
                  {
                     _loc4_ += _loc12_.moneyNum;
                  }
                  else
                  {
                     _loc6_ += _loc12_.moneyNum;
                  }
               }
               _loc5_ += _loc12_.goldNum;
            }
            _loc7_++;
         }
         if(_loc4_ <= 0 && _loc6_ <= 0)
         {
            exeAllCallBack(true,true);
            return;
         }
         var _loc8_:String = "";
         if(_loc4_ > 0)
         {
            _loc8_ += " " + LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips1",_loc4_);
         }
         if(_loc6_ > 0)
         {
            _loc8_ += " " + LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips2",_loc6_);
         }
         if(_loc5_ > 0)
         {
            _loc8_ += " " + LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips3",_loc5_);
         }
         SimpleAlertHelper.instance.data = [exeAllCallBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc11_:String = LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips") + "<font color=\'#95feff\'>" + _loc8_ + "</font>" + LanguageMgr.GetTranslation("secretary.LittleSecretaryFrameTips10");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc9_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc11_,_loc2_,_loc3_,false,true,true,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert",null,350,"","");
      }
      
      private function exeAllCallBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:Array = null;
         var _loc5_:SecretaryItemData = null;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc4_ = model.allItemDatas;
            _loc3_ = 0;
            while(_loc3_ < _loc4_.length)
            {
               _loc5_ = _loc4_[_loc3_];
               if(_loc3_ == _loc4_.length - 1)
               {
                  SecretaryManager.instance.isFinish = true;
               }
               if(_loc5_.state && Boolean(_loc5_.isOpen))
               {
                  if(_loc5_.type != 5 && Boolean(model.openAward))
                  {
                     FrameControllerManager.instance.openControllerByInfo("SECRETARY",1);
                     model.openAward = false;
                  }
                  this.visible = false;
                  actManager.addAction(_loc5_.getAction());
               }
               _loc3_++;
            }
         }
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFrame.helperFrame");
         _loc2_.show();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : SecretaryData
      {
         return SecretaryManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         SecretaryManager.instance.isFinish = false;
         ObjectUtils.disposeObject(_npc);
         _npc = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         if(actManager)
         {
            actManager.dipose();
         }
         ObjectUtils.disposeAllChildren(this);
         LitteActionManager.Instance.isOpen = false;
         super.dispose();
      }
   }
}

