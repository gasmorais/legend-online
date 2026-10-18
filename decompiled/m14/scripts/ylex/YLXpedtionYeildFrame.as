package ylex
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.ylex.ChildCampInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildCampTempTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import ylex.view.YLEepedtionYeildView;
   import ylex.view.YLExpedtionLeftListView;
   
   public class YLXpedtionYeildFrame extends Frame
   {
      
      public var _view2:YLEepedtionYeildView;
      
      private var _kbg:Scale9CornerImage;
      
      private var _leftView:YLExpedtionLeftListView;
      
      private var btnGrounp:SelectedButtonGroup;
      
      private var _zhuzhaBtn:SelectedIconButton;
      
      private var _data:ChildCampInfo;
      
      public function YLXpedtionYeildFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get data() : ChildCampInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildCampInfo) : void
      {
         var _loc2_:ChildCampTempTempInfo = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = TempleteManager.instance.childCampTempCate.getTempByGrade(_data.grade);
            if(_loc2_)
            {
               showRewards(_view2._ydzzRwBox,_loc2_.StationedAward);
            }
            _view2.data = _data;
            _leftView.data = _data;
         }
      }
      
      private function showRewards(param1:HBox, param2:String) : void
      {
         var _loc4_:String = null;
         var _loc8_:Array = null;
         var _loc3_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         var _loc6_:int = 0;
         var _loc9_:Array = param2.split("|");
         var _loc5_:int = int(_loc9_ ? _loc9_.length : 0);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _loc9_[_loc6_];
            _loc8_ = _loc4_.split(",");
            _loc3_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            param1.addChild(_loc3_);
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = int(_loc8_[0]);
            _loc7_.count = int(_loc8_[1]);
            _loc3_.data = _loc7_;
            _loc6_++;
         }
      }
      
      private function initView() : void
      {
         _kbg = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.YLXpedtionYeildFrame.bg");
         _view2 = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.view2");
         _zhuzhaBtn = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.YLXpedtionYeildFrame.zhuzhaBtn");
         _leftView = ComponentFactory.Instance.creatCustomObject("ylex.view.YLExpedtionLeftListView");
         addToContent(_kbg);
         addToContent(_view2);
         addToContent(_leftView);
         addToContent(_zhuzhaBtn);
         btnGrounp = new SelectedButtonGroup();
         btnGrounp.addSelectItem(_zhuzhaBtn);
         btnGrounp.selectIndex = 0;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         btnGrounp.addEventListener("change",__btnChangeHandler);
         NotificationManager.instance.addEventListener("YLExpedtionModel.EVENT_UPDATE_INFO",updateInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         btnGrounp.removeEventListener("change",__btnChangeHandler);
         NotificationManager.instance.removeEventListener("YLExpedtionModel.EVENT_UPDATE_INFO",updateInfoHandler);
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         _view2.data = _data;
         _leftView.data = _data;
      }
      
      private function __btnChangeHandler(param1:Event) : void
      {
         _leftView.refreshListView();
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
         ObjectUtils.disposeObject(_view2);
         _view2 = null;
         ObjectUtils.disposeObject(_kbg);
         _kbg = null;
         ObjectUtils.disposeObject(_zhuzhaBtn);
         _zhuzhaBtn = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         btnGrounp = null;
         super.dispose();
         _data = null;
      }
      
      public function show() : void
      {
         var _loc1_:int = int(_data ? _data.id : 1);
         titleText = LanguageMgr.GetTranslation("YLXpedtionYeildFrame.titleText",_loc1_);
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

