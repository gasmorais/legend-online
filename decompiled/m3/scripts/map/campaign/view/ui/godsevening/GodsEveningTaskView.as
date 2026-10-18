package map.campaign.view.ui.godsevening
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.GodsEveningEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mvc.module.godsevening.GodsEveningModel;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.TempleteManager;
   
   public class GodsEveningTaskView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _title:ScaleFrameImage;
      
      private var _hideBtn:BaseButton;
      
      private var _taskVbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _type:int;
      
      private var _isHide:Boolean = false;
      
      private var _rect:Rectangle;
      
      public function GodsEveningTaskView(param1:int)
      {
         super();
         _type = param1;
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("GodsEveningTaskView.Bg");
         _title = ComponentFactory.Instance.creatComponentByStylename("GodsEveningTaskView.Title");
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("GodsEveningTaskView.HideBtn");
         _taskVbox = ComponentFactory.Instance.creatComponentByStylename("GodsEveningTaskView.taskVbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("GodsEveningTaskView.ScrollPanel");
         _scrollPanel.beginChanges();
         _scrollPanel.setView(_taskVbox);
         _scrollPanel.invalidateViewport();
         _rect = new Rectangle(0,0,215,190);
         addChild(_bg);
         addChild(_title);
         addChild(_hideBtn);
         addChild(_scrollPanel);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_hideBtn);
         _hideBtn = null;
         ObjectUtils.disposeObject(_taskVbox);
         _taskVbox = null;
         TweenMax.killChildTweensOf(this);
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
      }
      
      private function addEvent() : void
      {
         GodsEveningManager.instance.addEventListener("TASK_INFO",__infoHandler);
         _hideBtn.addEventListener("click",__hideHandler);
      }
      
      private function removeEvent() : void
      {
         GodsEveningManager.instance.removeEventListener("TASK_INFO",__infoHandler);
         _hideBtn.removeEventListener("click",__hideHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      private function __hideHandler(param1:MouseEvent) : void
      {
         _isHide = !_isHide;
         if(_isHide)
         {
            _hideBtn.scaleX = -1;
            _hideBtn.x = 100;
            _bg.x = -60;
            _title.x = -45;
            TweenMax.to(_rect,0.5,{
               "x":-110,
               "height":30,
               "onUpdate":onUpdateRect
            });
         }
         else
         {
            _hideBtn.scaleX = 1;
            _hideBtn.x = 190;
            _bg.x = 0;
            _title.x = 0;
            TweenMax.to(_rect,0.5,{
               "x":0,
               "height":_bg.height,
               "onUpdate":onUpdateRect
            });
         }
      }
      
      private function onUpdateRect() : void
      {
         this.scrollRect = _rect;
      }
      
      private function __infoHandler(param1:GodsEveningEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:OfferRewardTemplate = null;
         var _loc2_:GodsEveningTaskItem = null;
         var _loc3_:Array = [];
         if(_type == 1)
         {
            _title.setFrame(1);
         }
         else
         {
            _title.setFrame(2);
         }
         _loc3_ = getTaskIds();
         _loc3_.sort(sortFun);
         _taskVbox.removeAllChild();
         for each(var _loc4_:int in _loc3_)
         {
            _loc1_ = TempleteManager.instance.offerRewardTemplateDic[_loc4_];
            _loc2_ = new GodsEveningTaskItem();
            _loc2_.data = _loc1_;
            _taskVbox.addChild(_loc2_);
         }
         _taskVbox.commitChanges();
         _scrollPanel.beginChanges();
         _scrollPanel.vScrollbar.scrollValue = 0;
         _taskVbox.refreshChildPos();
         _scrollPanel.invalidateViewport();
      }
      
      private function sortFun(param1:int, param2:int) : int
      {
         var _loc4_:OfferRewardTemplate = TempleteManager.instance.offerRewardTemplateDic[param1];
         var _loc3_:OfferRewardTemplate = TempleteManager.instance.offerRewardTemplateDic[param2];
         var _loc5_:GodsEveningModel = GodsEveningManager.instance.model;
         if(_loc5_.taskProgressDic[_loc4_.TemplateId] >= _loc4_.RewardGold)
         {
            if(_loc5_.taskGotRewardDic[_loc4_.TemplateId])
            {
               return 1;
            }
            return -1;
         }
         if(_loc5_.taskProgressDic[_loc3_.TemplateId] >= _loc3_.RewardGold)
         {
            if(_loc5_.taskGotRewardDic[_loc3_.TemplateId])
            {
               return -1;
            }
            return 1;
         }
         if(param1 < param2)
         {
            return -1;
         }
         return 1;
      }
      
      private function getTaskIds() : Array
      {
         var _loc2_:Array = [];
         if(_type == 1)
         {
            for(var _loc1_:String in model.teamDataDic)
            {
               if(int(_loc1_) == 1)
               {
                  if(model.teamId != 1)
                  {
                     _loc2_.push(5001);
                     _loc2_.push(5011);
                     _loc2_.push(5021);
                  }
               }
               else if(int(_loc1_) == 2)
               {
                  if(model.teamId != 2)
                  {
                     _loc2_.push(5002);
                     _loc2_.push(5012);
                     _loc2_.push(5022);
                  }
               }
               else if(int(_loc1_) == 3)
               {
                  if(model.teamId != 3)
                  {
                     _loc2_.push(5003);
                     _loc2_.push(5013);
                     _loc2_.push(5023);
                  }
               }
            }
         }
         else
         {
            _loc2_ = [5101,5102,5103];
         }
         return _loc2_;
      }
      
      private function get model() : GodsEveningModel
      {
         return GodsEveningManager.instance.model;
      }
   }
}

