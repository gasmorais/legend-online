package yishi.actions.map
{
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.CampaignMapView;
   import map.internals.data.CampaignNode;
   import yishi.actions.map.collection.CollectionAction;
   import yishi.comm.PackageIn;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.PathManager;
   import yishi.view.tools.BaseMovie;
   
   public class CampaignActionsFactory
   {
      
      public function CampaignActionsFactory()
      {
         super();
      }
      
      public static function createAction(param1:String, param2:Object, param3:PackageIn, param4:int = 75, param5:int = 0) : void
      {
         var mapModel:CampaignMapModel;
         var mapView:CampaignMapView;
         var targetNode:CampaignNode;
         var movie:BaseMovie;
         var onMovieOver:*;
         var $action:String = param1;
         var $target:Object = param2;
         var pkg:PackageIn = param3;
         var time:int = param4;
         var targetId:int = param5;
         pkg.position = 20;
         switch($action)
         {
            case "DISAPPEARD":
               GameBaseQueueManager.instance.addAction(new CommonAction($target,time));
               break;
            case "TRANSPORT_START":
               GameBaseQueueManager.instance.addAction(new TranseferAction($target,$target.x,$target.y,$action));
               break;
            case "TRANSPORT_END":
               GameBaseQueueManager.instance.addAction(new TranseferEndAction(pkg,$action));
               break;
            case "FLICKER":
               GameBaseQueueManager.instance.addAction(new AlphaFlickerAction($target));
               break;
            case "TRAP":
               GameBaseQueueManager.instance.addAction(new TrapAction($target));
               break;
            case "SESSION":
               GameBaseQueueManager.instance.addAction(new MessageAction(pkg));
               break;
            case "GAME_PLOT":
               break;
            case "MOVIE_MAP_NAME":
               GameBaseQueueManager.instance.addAction(new MapNameMovieAction());
               break;
            case "COLLECTION":
               if(CampaignManager.instance.mapModel.onCollectionId == 0)
               {
                  GameBaseQueueManager.instance.addAction(new CollectionAction($target,targetId),5);
               }
               break;
            case "SIMPLE_MOVIE":
               mapModel = CampaignManager.instance.mapModel;
               mapView = CampaignManager.instance.mapView as CampaignMapView;
               if(mapModel && mapView)
               {
                  targetNode = mapModel.getMapNodeByNodeId(targetId);
                  if(targetNode && targetNode.nodeView)
                  {
                     onMovieOver = function():void
                     {
                        if(mapView)
                        {
                           mapView.mouseEnabled = mapView.mouseChildren = true;
                        }
                        if(mapModel && targetNode)
                        {
                           targetNode.info.state = 1;
                           if(targetNode.nodeView)
                           {
                              targetNode.nodeView.visible = true;
                           }
                           targetNode.commit();
                        }
                     };
                     mapView.mouseEnabled = mapView.mouseChildren = false;
                     movie = new BaseMovie(PathManager.solveCampaignMovieByUrl(targetNode.param4),onMovieOver);
                     movie.x = targetNode.nodeView.x;
                     movie.y = targetNode.nodeView.y;
                     if(targetNode.preParent)
                     {
                        targetNode.preParent.addChild(movie);
                     }
                  }
               }
         }
      }
   }
}

