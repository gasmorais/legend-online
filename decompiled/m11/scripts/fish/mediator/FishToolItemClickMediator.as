package fish.mediator
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.ui.ComponentFactory;
   import fish.view.FishSigleView;
   import fish.view.FishToolItem;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.FishManager;
   import mvc.module.fish.FishModel;
   import mvc.module.fish.FishSigModel;
   import yishi.interfaces.IMediator;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class FishToolItemClickMediator implements IMediator
   {
      
      private var _toolItem:FishToolItem;
      
      public function FishToolItemClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _toolItem = param1 as FishToolItem;
         _toolItem.addEventListener("click",__onClickHandler,false,10);
      }
      
      public function unregister(param1:Object) : void
      {
         TweenMax.killAll(true);
         _toolItem.removeEventListener("click",__onClickHandler);
         _toolItem = null;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:SimpleMovie = null;
         if(!model.isForkState(0))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("fish.fishTool.Not"));
            return;
         }
         if(model.fishPoolInfo.count > 0 && model.fishPoolInfo.count >= model.fishPoolInfo.maxCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("fish.FishFrame.NotUseTool"));
            return;
         }
         switch(_toolItem.toolId - 1)
         {
            case 0:
            case 3:
               if(!model.toolFlag)
               {
                  return;
               }
               model.toolFlag = false;
               _loc3_ = ComponentFactory.Instance.creatCustomObject("fish.useFishTool" + _toolItem.toolId);
               _loc2_ = new SimpleMovie(_loc3_,__onComplete);
               _toolItem.parent.addChild(_loc2_);
               FishManager.instance.fishAction(5,[_toolItem.toolId]);
               break;
            case 1:
            case 2:
               checkTool(_toolItem.toolId);
         }
      }
      
      private function checkTool(param1:int) : void
      {
         var _loc2_:String = null;
         if(model.fishForkInfo.type == 0)
         {
            FishManager.instance.fishAction(5,[_toolItem.toolId]);
            return;
         }
         if(model.fishForkInfo.type == 2 && param1 == 3)
         {
            return;
         }
         if(model.fishForkInfo.type == 1 && param1 == 2)
         {
            return;
         }
         if(model.fishForkInfo.type == 2 && param1 == 2)
         {
            _loc2_ = LanguageMgr.GetTranslation("fish.fishTool.change1");
         }
         if(model.fishForkInfo.type == 1 && param1 == 3)
         {
            _loc2_ = LanguageMgr.GetTranslation("fish.fishTool.change2");
         }
         SimpleAlertHelper.instance.data = [change,param1];
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,true);
      }
      
      private function change(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            FishManager.instance.fishAction(5,[_toolItem.toolId]);
         }
      }
      
      private function __onComplete() : void
      {
         var _loc1_:* = null;
         var _loc2_:Point = null;
         for each(_loc1_ in model.fishSigsModel)
         {
            if(_loc1_.fishSigInfo.fishState == 4)
            {
               _loc2_ = new Point();
               _loc2_.x = _loc1_.fishSigInfo.x;
               _loc2_.y = _loc1_.fishSigInfo.y;
               if(_loc1_.fishSigInfo.fish)
               {
                  if(_loc1_.fishSigInfo.x <= 830 / 2)
                  {
                     TweenMax.to(_loc1_.fishSigInfo.fish as FishSigleView,1,{
                        "bezierThrough":[{
                           "x":_loc2_.x - 50,
                           "y":_loc2_.y - 50
                        },{
                           "x":0,
                           "y":80
                        },{
                           "x":-200,
                           "y":100
                        }],
                        "orientToBezier":false,
                        "ease":Quart.easeOut,
                        "onComplete":_moveComplete,
                        "onCompleteParams":[_loc1_.fishSigInfo.fish]
                     });
                  }
                  else
                  {
                     TweenMax.to(_loc1_.fishSigInfo.fish as FishSigleView,1,{
                        "bezierThrough":[{
                           "x":_loc2_.x - 50,
                           "y":_loc2_.y - 50
                        },{
                           "x":840,
                           "y":80
                        },{
                           "x":1000,
                           "y":100
                        }],
                        "orientToBezier":false,
                        "ease":Quart.easeOut,
                        "onComplete":_moveComplete,
                        "onCompleteParams":[_loc1_.fishSigInfo.fish]
                     });
                  }
               }
            }
         }
         FishManager.instance.fishAction(1,[20]);
      }
      
      private function _moveComplete(param1:FishSigleView) : void
      {
         param1.visible = false;
         model.toolFlag = true;
      }
      
      private function get model() : FishModel
      {
         return FishManager.instance.model;
      }
   }
}

