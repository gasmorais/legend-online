package ylex
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.YLExpedtionManger;
   import mvc.module.children.ChildData;
   import mvc.module.ylex.ChildCampInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import ylex.view.YLExpeditionChooseView;
   import ylex.view.YLExpedtionNodeItem;
   
   public class YLExpedtionChooseFrame extends Frame
   {
      
      public var _view3:YLExpeditionChooseView;
      
      private var _kbg:Scale9CornerImage;
      
      private var _list:Vector.<YLExpedtionNodeItem>;
      
      private var _data:ChildCampInfo;
      
      public function YLExpedtionChooseFrame()
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
         var _loc3_:YLExpedtionNodeItem = null;
         var _loc4_:int = 0;
         var _loc5_:ChildData = null;
         var _loc6_:ChildTempInfo = null;
         var _loc2_:BaseIconView = null;
         _data = param1;
         if(_data && _view3)
         {
            _list = new Vector.<YLExpedtionNodeItem>();
            _loc4_ = 0;
            while(_loc4_ < 3)
            {
               _loc3_ = new YLExpedtionNodeItem();
               _loc3_.addEventListener("click",itemClickHandler);
               _loc3_.addEventListener("mouseOver",itemOverHandler);
               _loc3_.addEventListener("mouseOut",itemOutHandler);
               _loc3_.buttonMode = true;
               _loc3_.diff = _loc4_ + 1;
               _view3._zzNodeHbox.addChild(_loc3_);
               _list[_loc4_] = _loc3_;
               _loc4_++;
            }
            _loc5_ = _data.opChildData;
            _loc6_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc5_.job,_loc5_.growthGrade);
            _loc2_ = _view3._icon;
            if(_loc6_)
            {
               _view3._zzNodeTitleDes.text = LanguageMgr.GetTranslation("YLExpeditionItem.doZhuzha.who",_loc6_.JobName);
               _loc2_.visible = true;
               _loc2_.icon = PathManager.info.ResourcePath + "icon" + _loc6_.Icon;
            }
         }
      }
      
      private function initView() : void
      {
         _kbg = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.YLExpedtionChooseFrame.bg");
         _view3 = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.view3");
         addToContent(_kbg);
         addToContent(_view3);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         for each(var _loc1_:YLExpedtionNodeItem in _list)
         {
            _loc1_.removeEventListener("click",itemClickHandler);
            _loc1_.removeEventListener("mouseOver",itemOverHandler);
            _loc1_.removeEventListener("mouseOut",itemOutHandler);
         }
      }
      
      private function itemOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:YLExpedtionNodeItem = param1.currentTarget as YLExpedtionNodeItem;
         _loc2_._zzNodeBg.setFrame(2);
      }
      
      private function itemOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:YLExpedtionNodeItem = param1.currentTarget as YLExpedtionNodeItem;
         _loc2_._zzNodeBg.setFrame(1);
      }
      
      private function itemClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:YLExpedtionNodeItem = param1.currentTarget as YLExpedtionNodeItem;
         var _loc2_:String = LanguageMgr.GetTranslation("YLExpeditionItem.doChoose" + _loc5_.diff);
         SimpleAlertHelper.instance.data = [confirmChoose,_loc5_.diff];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc2_,_loc3_,_loc4_,true,true);
      }
      
      private function confirmChoose(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc4_:int = 0;
         if(param1)
         {
            _loc4_ = int(_data.opChildData.childId);
            YLExpedtionManger.instance.sendOp(2,_data.id,_loc4_,param3);
            dispose();
         }
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
         ObjectUtils.disposeObject(_view3);
         _view3 = null;
         ObjectUtils.disposeObject(_kbg);
         _kbg = null;
         super.dispose();
         _data = null;
         _list = null;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("YLExpedtionChooseFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

