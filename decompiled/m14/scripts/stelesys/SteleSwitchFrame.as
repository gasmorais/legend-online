package stelesys
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.stele.StelesysInfo;
   import mvc.module.stele.StelesysModel;
   import stelesys.view.StelaSwitchObj;
   import stelesys.view.SteleSysChooseMenu;
   import stelesys.view.StelesysBagView;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.view.base.PageBar;
   import yishi.view.base.TextAddBitmap;
   
   public class SteleSwitchFrame extends Frame implements IManualSize
   {
      
      private var _fbg:Bitmap;
      
      private var _menu:SteleSysChooseMenu;
      
      private var _bagView:StelesysBagView;
      
      private var _currInfoList:Array;
      
      private var _type:int;
      
      private var _pageBar:PageBar;
      
      private var _bitTxt:TextAddBitmap;
      
      public function SteleSwitchFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,770,615);
      }
      
      private function initView() : void
      {
         _fbg = ComponentFactory.Instance.creatBitmap("asset.stelesys.switchBg");
         _bitTxt = ComponentFactory.Instance.creatCustomObject("ui.stela.swithBitTxt");
         _menu = ComponentFactory.Instance.creatCustomObject("stelesys.switchMenu");
         _bagView = ComponentFactory.Instance.creatCustomObject("stelesys.switch.bagView");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.switch.PageBar");
         addToContent(_fbg);
         addToContent(_bitTxt);
         addToContent(_bagView);
         addToContent(_pageBar);
         addToContent(_menu);
         _bitTxt.initView("ui.stelesys.intensifySortTxt","asset.stelesys.selectCount");
         _bitTxt.adjustPositionY(7);
         _bitTxt.setText("0");
         var _loc1_:String = "1|1|1|1|1|1,1|1|1|1|1|1";
         model.changeSwitchStr(_loc1_);
         _menu.menuType = 1;
         _menu.refreshSwitchMenuName(_loc1_);
         model.lockMainTip = true;
      }
      
      private function refreshView() : void
      {
         var _loc1_:Array = model.allStelaList;
         var _loc4_:Array = [];
         if(_type == 2)
         {
            for each(var _loc5_:StelesysInfo in _loc1_)
            {
               if(!_loc5_.isCurrMaxLv)
               {
                  _loc4_.push(_loc5_);
               }
            }
         }
         else
         {
            _loc4_ = _loc1_;
         }
         var _loc3_:StelaSwitchObj = _menu.switchObj;
         var _loc2_:Array = model.doSwitch(_loc4_,_loc3_.stars,_loc3_.colors);
         model.doSort(_loc2_);
         _currInfoList = _loc2_;
         _pageBar.setAutoPagingData(_currInfoList,40);
         _pageBar.setCurPage(1);
         _bitTxt.setText("" + _currInfoList.length);
      }
      
      private function get model() : StelesysModel
      {
         return SteleSysManager.Ins.model;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("STELE_SYS_SWITCH",switchHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_CHOOSE",chooseHandler);
         _pageBar.addEventListener("change",pageChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("STELE_SYS_SWITCH",switchHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_CHOOSE",chooseHandler);
         _pageBar.removeEventListener("change",pageChangeHandler);
      }
      
      private function pageChangeHandler(param1:Event) : void
      {
         _bagView.refreshView(_pageBar.getCurPageDatas());
      }
      
      private function chooseHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function switchHandler(param1:NotificationEvent) : void
      {
         _menu.refreshSwitchMenuName(model.currSwitchStr);
         refreshView();
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_fbg);
         _fbg = null;
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_bitTxt);
         _bitTxt = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         model.lockMainTip = false;
         model.currChoose = null;
         super.dispose();
         _currInfoList = null;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         _type = int(param1.frameData);
         if(_type == 0)
         {
            titleText = LanguageMgr.GetTranslation("stela.preview.title");
            _bagView.forbitItemClick();
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("stela.switchFrame.title");
         }
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

