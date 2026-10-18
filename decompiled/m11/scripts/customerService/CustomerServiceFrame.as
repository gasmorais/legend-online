package customerService
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import customerService.view.CustomerServiceBaseView;
   import customerService.view.ServiceReplyView;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.MailCheckManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.customerService.CustomerServiceModel;
   import mvc.module.customerService.ServiceReplyInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.CustomerServiceManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.StringHelper;
   
   public class CustomerServiceFrame extends Frame implements IManualSize
   {
      
      private static const VIEW_PACKAGE:String = "customerService.view";
      
      private var _describeBackGround:Scale9CornerImage;
      
      private var _backGroundK:Scale9CornerImage;
      
      private var _bottomImage:ScaleLeftRightImage;
      
      private var _viewTypeCombox:ComboBox;
      
      private var _viewTypeComboxContain:Sprite = new Sprite();
      
      private var viewCache:Dictionary = new Dictionary(true);
      
      private var _currentView:CustomerServiceBaseView;
      
      private var _serviceReplyView:ServiceReplyView;
      
      public function CustomerServiceFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _describeBackGround = ComponentFactory.Instance.creatComponentByStylename("customerservice.describeBackGround");
         _backGroundK = ComponentFactory.Instance.creatComponentByStylename("customerservice.backgroundK");
         _bottomImage = ComponentFactory.Instance.creatComponentByStylename("customerservice.bottomImage");
         _viewTypeCombox = creatCombox(model.problemList,"asset.customerservice.ProblemTypeTxt","customerservice.ProblemSelectedComboBox",12,43,94,41,true);
         this.addToContent(_backGroundK);
         this.addToContent(_describeBackGround);
         this.addToContent(_bottomImage);
      }
      
      public function creatCombox(param1:Vector.<Object>, param2:String = null, param3:String = null, param4:int = 0, param5:int = 0, param6:int = -1, param7:int = -1, param8:Boolean = false) : ComboBox
      {
         var _loc9_:Bitmap = null;
         var _loc10_:int = 0;
         var _loc12_:Bitmap = null;
         if(param2)
         {
            _loc9_ = ComponentFactory.Instance.creatBitmap(param2);
            _loc9_.x = param4;
            _loc9_.y = param5;
            _viewTypeComboxContain.addChild(_loc9_);
         }
         var _loc11_:ComboBox = ComponentFactory.Instance.creatComponentByStylename(param3);
         _loc10_ = 0;
         while(_loc10_ < param1.length)
         {
            _loc11_.listPanel.vectorListModel.append(param1[_loc10_]);
            _loc10_++;
         }
         _loc11_.listPanel.list.defaultSelectItemByCellValue = param1[0];
         if(param2)
         {
            if(param6 == -1 && param7 == -1)
            {
               _loc11_.x = param4 + _loc9_.width;
               _loc11_.y = param5;
            }
            else
            {
               _loc11_.x = param6;
               _loc11_.y = param7;
            }
         }
         else
         {
            _loc11_.x = param4;
            _loc11_.y = param5;
         }
         if(param8)
         {
            _loc12_ = ComponentFactory.Instance.creatBitmap("asset.customerservice.SignMust");
            _loc12_.x = _loc11_.x + _loc11_.width;
            _loc12_.y = _loc11_.y + 7;
            _viewTypeComboxContain.addChild(_loc12_);
         }
         _viewTypeComboxContain.addChild(_loc11_);
         return _loc11_;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _viewTypeCombox.addEventListener("stateChange",_viewChangeHandler);
         CustomerServiceManager.instance.addEventListener("complete",_submitSuccessHandler);
         _viewTypeCombox.button.addEventListener("click",_clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _viewTypeCombox.removeEventListener("stateChange",_viewChangeHandler);
         CustomerServiceManager.instance.removeEventListener("complete",_submitSuccessHandler);
         _viewTypeCombox.button.removeEventListener("click",_clickHandler);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               model.refreshData();
         }
      }
      
      private function _clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
      }
      
      private function _viewChangeHandler(param1:InteractiveEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = model.viewIdToString(_viewTypeCombox.currentSelectedCellValue.id);
         changeViewWith(_loc2_);
      }
      
      public function changeViewWith(param1:String) : void
      {
         model.viewType = param1;
         var _loc3_:String = getFullClassName(param1);
         var _loc2_:CustomerServiceBaseView = viewCache[_loc3_];
         if(_loc2_ == null)
         {
            _loc2_ = ClassUtils.CreatInstance(_loc3_,[model]);
            viewCache[_loc3_] = _loc2_;
         }
         currentView = _loc2_;
         _loc2_ = null;
      }
      
      private function getFullClassName(param1:String) : String
      {
         return StringHelper.format("{0}.{1}","customerService.view",param1);
      }
      
      private function _submitSuccessHandler(param1:Event) : void
      {
         this.dispose();
         model.refreshData();
      }
      
      private function get model() : CustomerServiceModel
      {
         return CustomerServiceManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ServiceReplyInfo = null;
         titleText = LanguageMgr.GetTranslation("customerservice.CustomerServiceFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
         if(param1 && param1.frameData)
         {
            _loc2_ = int(param1.frameData);
            _viewTypeCombox.listPanel.list.defaultSelectItemByCellValue = model.problemList[_loc2_];
            addToContent(_viewTypeComboxContain);
         }
         else
         {
            _loc3_ = model.getMessage();
            if(_loc3_)
            {
               model.viewType = "ServiceReplyView";
               _serviceReplyView = new ServiceReplyView(model);
               currentView = _serviceReplyView;
               CustomerServiceManager.instance.sendRead();
            }
            else
            {
               addToContent(_viewTypeComboxContain);
               changeViewWith("ConsultingGameView");
            }
         }
      }
      
      public function set currentView(param1:CustomerServiceBaseView) : void
      {
         if(_currentView == param1)
         {
            return;
         }
         if(_currentView)
         {
            _currentView.viewChange();
            _currentView.parent && _currentView.parent.removeChild(_currentView);
         }
         _currentView = param1;
         this.addToContent(_currentView);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_backGroundK);
         _backGroundK = null;
         ObjectUtils.disposeObject(_describeBackGround);
         _describeBackGround = null;
         ObjectUtils.disposeObject(_bottomImage);
         _bottomImage = null;
         ObjectUtils.disposeObject(_viewTypeCombox);
         _viewTypeCombox = null;
         ObjectUtils.disposeAllChildren(_viewTypeComboxContain);
         _viewTypeComboxContain = null;
         _serviceReplyView && _serviceReplyView.dispose();
         _serviceReplyView = null;
         for(var _loc1_:String in viewCache)
         {
            ObjectUtils.disposeObject(viewCache[_loc1_]);
            viewCache[_loc1_] = null;
            delete viewCache[_loc1_];
         }
         viewCache = null;
         _currentView = null;
         super.dispose();
         if(thane.grades >= 6 && Boolean(MailCheckManager.instance.model.isShow))
         {
            FrameControllerManager.instance.openControllerByInfo("mailcheck",2);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,this.width,this.height);
      }
   }
}

