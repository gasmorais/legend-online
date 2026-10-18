package carnvial.view
{
   import carnvial.item.CarnivalTaskItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.carnival.CarnivalTaskInfo;
   import yishi.events.NotificationEvent;
   
   public class CarnivalDayTaskPage extends BaseCarnivalPage
   {
      
      private var _roleBit:Bitmap;
      
      private var _panel:ScrollPanel;
      
      private var _vbox:VBox;
      
      private var _restTxtBg:Bitmap;
      
      private var _resttxt:FilterFrameText;
      
      private var _itemList:Dictionary = new Dictionary();
      
      public function CarnivalDayTaskPage()
      {
         super();
         initView();
         initData();
         initEvent();
      }
      
      override protected function initView() : void
      {
         _roleBit = new Bitmap();
         addChild(_roleBit);
         toLoadImg(_roleBit,"tab6_role",_activeId);
         _panel = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.taskScollPanel");
         _vbox = ComponentFactory.Instance.creatCustomObject("ui.carnival.taskScollBox");
         _restTxtBg = ComponentFactory.Instance.creatBitmap("asset.carniver.timeSetBg");
         _resttxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.retTimeTxt");
         addChild(_panel);
         addChild(_restTxtBg);
         addChild(_resttxt);
         _panel.setView(_vbox);
         _resttxt.htmlText = LanguageMgr.GetTranslation("carnival.today.reset");
      }
      
      private function initData() : void
      {
         var _loc1_:CarnivalTaskItem = null;
         var _loc3_:CarnivalTaskInfo = null;
         var _loc4_:int = 0;
         _panel.beginChanges();
         _vbox.beginChanges();
         var _loc5_:Array = model.getAllTaskInfo();
         _loc5_.sortOn("taskId",16);
         var _loc2_:int = int(_loc5_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc5_[_loc4_];
            _loc1_ = new CarnivalTaskItem();
            _loc1_.data = _loc3_;
            _vbox.addChild(_loc1_);
            _itemList[_loc3_.taskId] = _loc1_;
            _loc4_++;
         }
         _vbox.commitChanges();
         _panel.commitChanges();
         _panel.invalidateViewport();
      }
      
      override protected function updateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:CarnivalTaskItem = null;
         var _loc4_:Array = model.getAllTaskInfo();
         for each(var _loc3_:CarnivalTaskInfo in _loc4_)
         {
            _loc2_ = _itemList[_loc3_.taskId];
            if(_loc2_)
            {
               _loc2_.data = _loc3_;
            }
         }
      }
      
      override protected function clearView() : void
      {
         for each(var _loc1_:CarnivalTaskItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_roleBit);
         _roleBit = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_restTxtBg);
         _restTxtBg = null;
         ObjectUtils.disposeObject(_resttxt);
         _resttxt = null;
      }
   }
}

